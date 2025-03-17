# -*- coding: utf-8 -*-
from flask import Flask, jsonify
import requests
import numpy as np
import hdbscan
from st_dbscan import ST_DBSCAN
from datetime import datetime
from geopy.distance import geodesic

app = Flask(__name__)

# ฟังก์ชันคำนวณระยะห่างเป็นเมตร
def to_meters(locations):
    base_point = locations[0]  # ใช้จุดแรกเป็นจุดอ้างอิง
    return np.array([geodesic(base_point, point).meters for point in locations])

# ฟังก์ชันรวมข้อมูลกลุ่ม

def format_grouped_data(grouped_data):
    formatted_data = []
    for cluster_id, group in grouped_data.items():
        first_location = group['locations'][0]
        formatted_data.append({
            "id": cluster_id,
            "user_id": 0,
            "acclocation": "ไม่ระบุ",
            "latitude": first_location[0],
            "longitude": first_location[1],
            "numinjur": group['numinjur'],
            "numdeath": group['numdeath'],
            "accdate": datetime.utcnow().isoformat() + "Z", 
            "accinfo": "กลุ่มอุบัติเหตุที่ {cluster_id}"
        })
    return formatted_data


# ฟังก์ชันรวมข้อมูลกลุ่ม

def group_data_by_clusters(labels, locations, numinjur, numdeath):
    grouped_data = {}
    for idx, label in enumerate(labels):
        if label == -1:  # noise จุดที่ไม่เข้ากลุ่ม
            continue
        label = int(label)  # แปลงจาก int64 เป็น int
        if label not in grouped_data:
            grouped_data[label] = {'locations': [], 'numinjur': 0, 'numdeath': 0}
        grouped_data[label]['locations'].append(locations[idx])
        grouped_data[label]['numinjur'] += numinjur[idx]
        grouped_data[label]['numdeath'] += numdeath[idx]
    return grouped_data

@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "DBSCAN API is running"}), 200

# ดึงข้อมูลจาก API
def fetch_data():
    url = "http://localhost:3000/api/accidentdata"
    response = requests.get(url)

    if response.status_code != 200:
        return None

    data = response.json()
    locations, timestamps, numinjur, numdeath = [], [], [], []

    for entry in data['data']:
        locations.append([entry['latitude'], entry['longitude']])
        timestamps.append(datetime.strptime(entry['accdate'], "%Y-%m-%dT%H:%M:%S.%fZ"))
        numinjur.append(entry['numinjur'])
        numdeath.append(entry['numdeath'])

    return locations, timestamps, numinjur, numdeath

# API สำหรับ HDBSCAN
@app.route('/api/hdbscan', methods=['GET'])
def run_hdbscan():
    data = fetch_data()
    if data is None:
        return jsonify({"error": "ไม่สามารถดึงข้อมูลได้"}), 500

    locations, timestamps, numinjur, numdeath = data
    hdbscan_model = hdbscan.HDBSCAN(min_cluster_size=2, min_samples=2, metric='haversine')
    hdbscan_labels = hdbscan_model.fit_predict(np.radians(locations))
    hdbscan_grouped = group_data_by_clusters(hdbscan_labels, locations, numinjur, numdeath)
    formatted_data = format_grouped_data(hdbscan_grouped)

    return jsonify({"message": "เรียกข้อมูลสำเร็จ", "data": formatted_data})

# API สำหรับ ST-DBSCAN ไม่อ้างอิงเวลา
@app.route('/api/st-dbscan', methods=['GET'])
def run_st_dbscan():
    data = fetch_data()
    if data is None:
        return jsonify({"error": "ไม่สามารถดึงข้อมูลได้"}), 500

    locations, timestamps, numinjur, numdeath = data  # แก้ไขบรรทัดนี้
    locations_meters = to_meters(locations)
    
    st_dbscan_model = ST_DBSCAN(eps1=70, min_samples=2)  # ไม่ใช้ eps2
    st_dbscan_model.fit(np.column_stack((locations_meters, np.zeros(len(locations)))) )
    st_dbscan_grouped = group_data_by_clusters(st_dbscan_model.labels, locations, numinjur, numdeath)
    formatted_data = format_grouped_data(st_dbscan_grouped)

    return jsonify({"message": "เรียกข้อมูลสำเร็จ", "data": formatted_data})


# API สำหรับ ST-DBSCAN (กลางวัน)
@app.route('/api/st-dbscan/day', methods=['GET'])
def run_st_dbscan_day():
    data = fetch_data()
    if data is None:
        return jsonify({"error": "ไม่สามารถดึงข้อมูลได้"}), 500

    locations, timestamps, numinjur, numdeath = data
    daytime_indices = [i for i, t in enumerate(timestamps) if 6 <= t.hour < 18]
    if not daytime_indices:
        return jsonify({"message": "ไม่มีข้อมูลอุบัติเหตุช่วงกลางวัน"}), 200
    
    daytime_locations = [locations[i] for i in daytime_indices]
    daytime_numinjur = [numinjur[i] for i in daytime_indices]
    daytime_numdeath = [numdeath[i] for i in daytime_indices]
    locations_meters = to_meters(daytime_locations)
    
    st_dbscan_model = ST_DBSCAN(eps1=70, eps2=1, min_samples=2)
    st_dbscan_model.fit(np.column_stack((locations_meters, np.zeros(len(daytime_indices)))))
    st_dbscan_grouped = group_data_by_clusters(st_dbscan_model.labels, daytime_locations, daytime_numinjur, daytime_numdeath)
    formatted_data = format_grouped_data(st_dbscan_grouped)

    return jsonify({"message": "เรียกข้อมูลสำเร็จ", "data": formatted_data})

# API สำหรับ ST-DBSCAN (กลางคืน)
@app.route('/api/st-dbscan/night', methods=['GET'])
def run_st_dbscan_night():
    data = fetch_data()
    if data is None:
        return jsonify({"error": "ไม่สามารถดึงข้อมูลได้"}), 500

    locations, timestamps, numinjur, numdeath = data
    nighttime_indices = [i for i, t in enumerate(timestamps) if t.hour < 6 or t.hour >= 18]
    if not nighttime_indices:
        return jsonify({"message": "ไม่มีข้อมูลอุบัติเหตุช่วงกลางคืน"}), 200
    
    nighttime_locations = [locations[i] for i in nighttime_indices]
    nighttime_numinjur = [numinjur[i] for i in nighttime_indices]
    nighttime_numdeath = [numdeath[i] for i in nighttime_indices]
    locations_meters = to_meters(nighttime_locations)
    
    st_dbscan_model = ST_DBSCAN(eps1=70, eps2=1, min_samples=2)
    st_dbscan_model.fit(np.column_stack((locations_meters, np.ones(len(nighttime_indices)))))
    st_dbscan_grouped = group_data_by_clusters(st_dbscan_model.labels, nighttime_locations, nighttime_numinjur, nighttime_numdeath)
    formatted_data = format_grouped_data(st_dbscan_grouped)

    return jsonify({"message": "เรียกข้อมูลสำเร็จ", "data": formatted_data})

if __name__ == '__main__':
    app.run(host='localhost', port=5000, debug=True)
