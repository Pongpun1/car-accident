<template>
  <div>
    <div class="NavBar">
      <NavTopBar />
    </div>
    <div class="chart-container"> <!-- เพิ่ม container รอบ charts -->
      <div class="charts">
        <BarChart />
        <PieChart />
      </div>
    </div>
    <div class="statistics">
      <h3>ค่าเฉลี่ยสำหรับผู้เสียชีวิตและผู้บาดเจ็บ</h3>
      <p>ค่าเฉลี่ยผู้เสียชีวิตของทุกสถานที่: {{ deathMean }}</p>
      <p>ผู้เสียชีวิตมากที่สุด: {{ deathMax }} </p>
      <p>ผู้เสียชีวิตน้อยที่สุด: {{ deathMin }} </p>
      <p>ค่าเฉลี่ยผู้บาดเจ็บทุกสถานที่: {{ injuryMean }}</p>
      <p>ผู้บาดเจ็บมากที่สุด: {{ injuryMax }}</p>
      <p>ผู้บาดเจ็บน้อยที่สุด: {{ injuryMin }}</p>
    </div>
  </div>
</template>

<script>
import NavTopBar from "../components/nav-bar.vue";
import PieChart from "../components/PieChart.vue";
import BarChart from "../components/BarChart.vue";
import axios from "axios";

export default {
  components: {
    NavTopBar,
    PieChart,
    BarChart,
  },
  data() {
    return {
      deathMean: 0,
      deathMax: 0,
      deathMin: 0,
      injuryMean: 0,
      injuryMax: 0,
      injuryMin: 0,
    };
  },
  mounted() {
    this.fetchStatistics();
  },
  methods: {
    fetchStatistics() {
      axios.get("http://localhost:3000/api/data/")
        .then((response) => {
          const accidents = response.data.data;

          const deathCounts = accidents.map((accident) => accident.numdeath);
          const injuryCounts = accidents.map((accident) => accident.numinjur);

          this.deathMean = (deathCounts.reduce((sum, value) => sum + value, 0) / deathCounts.length).toFixed(2);
          this.injuryMean = (injuryCounts.reduce((sum, value) => sum + value, 0) / injuryCounts.length).toFixed(2);

          this.deathMax = Math.max(...deathCounts);
          this.injuryMax = Math.max(...injuryCounts);

          this.deathMin = Math.min(...deathCounts);
          this.injuryMin = Math.min(...injuryCounts);
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
        });
    },
  },
};
</script>

<style>
.chart-container {
  background-color: #FFFFFF;
  margin: 80px 180px 0 180px;
  border-radius: 20px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.charts {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 60vh;
}

.charts > div {
  flex: 1;
  max-width: 600px;
  margin: 0 10px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.statistics {
  background-color: #ffffff;
  padding: 10px;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  width: 40%;
  margin: 20px auto 0; 
  font-size: 1.1rem;
}

.statistics h3 {
  margin-bottom: 10px;
  font-size: 1.5rem;
  font-weight: bold;
}

.statistics p {
  margin: 5px 0;
}
</style>
