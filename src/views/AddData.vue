<template>
  <div class="MainContentAdd">
    <div class="NavBar">
      <NavTopBar />
    </div>

    <h2 class="AddHeader"><strong>{{ $t("addData") }}</strong></h2>
    <div class="input-form-container">
      <div class="input-form">
        <b-input-group size="lg" :prepend="$t('location')" class="input">
          <b-form-input
            v-model="formData.acclocation"
            type="text"
            :placeholder="$t('locationHolder')"
          ></b-form-input>
          <b-input-group-append>
            <b-button @click="searchLocation">
              <b-icon icon="search" aria-hidden="true" font-scale="1"></b-icon>
            </b-button>
          </b-input-group-append>
        </b-input-group>

        <b-input-group size="lg" :prepend="$t('latitude')" class="input">
          <b-form-input
            v-model="formData.latitude"
            :placeholder="$t('latitudeHolder')"
          ></b-form-input>
        </b-input-group>

        <b-input-group size="lg" :prepend="$t('longitude')" class="input">
          <b-form-input
            v-model="formData.longitude"
            :placeholder="$t('longitudeHolder')"
          ></b-form-input>
        </b-input-group>

        <b-input-group
          size="lg"
          :prepend="$t('injured')"
          class="input"
        >
          <b-form-input
            v-model="formData.numinjur"
            type="number"
            :placeholder="ระบุจำนวนผู้บาดเจ็บ"
          ></b-form-input>
        </b-input-group>

        <b-input-group
          size="lg"
          :prepend="$t('death')"
          class="input"
        >
          <b-form-input
            v-model="formData.numdeath"
            type="number"
            placeholder="ระบุจำนวนผู้เสียชีวิต"
          ></b-form-input>
        </b-input-group>

        <b-input-group size="lg" :prepend="$t('date')" class="input">
          <b-form-input
            id="example-input"
            v-model="formattedAccdate"
            type="text"
            :placeholder="$t('dateHolder')"
            autocomplete="off"
          ></b-form-input>
          <b-input-group-append>
            <b-form-datepicker
              v-model="formData.accdate"
              button-only
              right
              locale="th"
              aria-controls="example-input"
              :date-format-options="{
                year: 'numeric',
                month: 'long',
                day: 'numeric',
              }"
            ></b-form-datepicker>
          </b-input-group-append>
        </b-input-group>

        <b-input-group size="lg" class="input">
          <b-form-textarea
            v-model="formData.accinfo"
            rows="5"
            max-rows="8"
            :placeholder="$t('infoHolder')"
          ></b-form-textarea>
        </b-input-group>

        <b-button-group size="lg" class="Addbutton">
          <b-button variant="primary" @click="AddData">{{ $t("editSave") }}</b-button>
        </b-button-group>
      </div>

      <div class="map-container">
        <Map
          :center="mapCenter"
          :zoom="13"
          style="width: 100%; height: 800px"
          @click="onMapClick"
        >
          <GoogleMapMarker
            v-if="formData.latitude && formData.longitude"
            :position="{
              lat: parseFloat(formData.latitude),
              lng: parseFloat(formData.longitude),
            }"
          />
        </Map>
      </div>
    </div>
  </div>
</template>

<script>
import NavTopBar from "../components/TopNavBar.vue";
import axios from "axios";
import { Map, Marker as GoogleMapMarker } from "vue2-google-maps";

export default {
  components: {
    NavTopBar,
    Map,
    GoogleMapMarker,
  },

  data() {
    return {
      formData: {
        acclocation: "",
        latitude: "",
        longitude: "",
        numinjur: 0,
        numdeath: 0,
        accdate: "",
        accinfo: "",
      },
      mapCenter: {
        lat: 13.736717,
        lng: 100.523186,
      },
    };
  },

  watch: {
    "formData.latitude": "updateMapCenter",
    "formData.longitude": "updateMapCenter",
  },

  computed: {
    formattedAccdate() {
      if (this.formData.accdate) {
        const date = new Date(this.formData.accdate);
        const buddhistYear = date.getFullYear() + 543;
        return `${date.getDate()} ${date.toLocaleString("th-TH", {
          month: "long",
        })} ${buddhistYear}`;
      }
      return "";
    },
  },

  methods: {
    AddData() {
      if (
        !this.formData.latitude ||
        !this.formData.longitude ||
        !this.formData.accdate
      ) {
        alert("กรุณากรอกข้อมูลให้ครบถ้วน");
        return;
      }

      let apiEndpoint = "";
      if (
        this.formData.accinfo &&
        (this.formData.accinfo.includes("รถชน") ||
          this.formData.accinfo.includes("รถล้ม") ||
          this.formData.accinfo.includes("รถคว่ำ") ||
          this.formData.accinfo.includes("อุบัติเหตุ") ||
          this.formData.accinfo.includes("ประสานงา") ||
          this.formData.accinfo.includes("ชนท้าย") ||
          this.formData.accinfo.includes("เสียหลัก"))
      ) {
        apiEndpoint = "http://localhost:3000/api/accidentdata/single";
      } else if (
        this.formData.accinfo &&
        (this.formData.accinfo.includes("อาชญากรรม") ||
          this.formData.accinfo.includes("โจร") ||
          this.formData.accinfo.includes("ปล้น") ||
          this.formData.accinfo.includes("จี้") ||
          this.formData.accinfo.includes("ชิงทรัพย์") ||
          this.formData.accinfo.includes("ขโมย") ||
          this.formData.accinfo.includes("คนร้าย") ||
          this.formData.accinfo.includes("ข่มขืน") ||
          this.formData.accinfo.includes("ฆ่า") ||
          this.formData.accinfo.includes("ฆาตกรรม") ||
          this.formData.accinfo.includes("อนาจาร") ||
          this.formData.accinfo.includes("ก่อเหตุความไม่สงบ") ||
          this.formData.accinfo.includes("ยาเสพติด") ||
          this.formData.accinfo.includes("ลักพาตัว"))
      ) {
        apiEndpoint = "http://localhost:3000/api/crimedata/single";

        const crimeData = {
          crimedate: new Date(this.formData.accdate).toISOString(),
          crimelocation: this.formData.acclocation,
          latitude: this.formData.latitude,
          longitude: this.formData.longitude,
          numinjur: this.formData.numinjur,
          numdeath: this.formData.numdeath,
          crimeinfo: this.formData.accinfo,
        };

        axios
          .post(apiEndpoint, crimeData, {
            headers: {
              "Content-Type": "application/json",
            },
          })
          .then(() => {
            alert(this.$t("saveSuccess"));
            this.$router.push("/data");
            this.resetForm();
          })
          .catch((error) => {
            if (error.response && error.response.status === 400) {
              alert(error.response.data.message);
            } else {
              alert(this.$t("saveFail"));
            }
          });
        return;
      } else if (!this.formData.accinfo) {
        apiEndpoint = "http://localhost:3000/api/unspecifieddata/single";

        const unspecifiedData = {
          date: new Date(this.formData.accdate).toISOString(),
          location: this.formData.acclocation,
          latitude: this.formData.latitude,
          longitude: this.formData.longitude,
          numinjur: this.formData.numinjur,
          numdeath: this.formData.numdeath,
          info: this.formData.accinfo,
        };

        axios
          .post(apiEndpoint, unspecifiedData, {
            headers: {
              "Content-Type": "application/json",
            },
          })
          .then(() => {
            alert(this.$t("saveSuccess"));
            this.$router.push("/data");
            this.resetForm();
          })
          .catch((error) => {
            if (error.response && error.response.status === 400) {
              alert(error.response.data.message);
            } else {
              alert(this.$t("saveFail"));
            }
          });
        return;
      } else {
        apiEndpoint = "http://localhost:3000/api/unspecifieddata/single";

        const formattedDate = new Date(this.formData.accdate).toISOString();

        axios
          .post(
            apiEndpoint,
            {
              date: formattedDate,
            },
            {
              headers: {
                "Content-Type": "application/json",
              },
            }
          )
          .then(() => {
            alert(this.$t("saveSuccess"));
            this.$router.push("/data");
            this.resetForm();
          })
          .catch((error) => {
            if (error.response && error.response.status === 400) {
              alert(error.response.data.message);
            } else {
              alert(this.$t("saveFail"));
            }
          });
      }
    },

    resetForm() {
      this.formData = {
        acclocation: "",
        latitude: "",
        longitude: "",
        numinjur: 0,
        numdeath: 0,
        accdate: "",
        accinfo: "",
      };
    },

    updateMapCenter() {
      if (this.formData.latitude && this.formData.longitude) {
        this.mapCenter = {
          lat: parseFloat(this.formData.latitude),
          lng: parseFloat(this.formData.longitude),
        };
      }
    },

    async searchLocation() {
      const location = this.formData.acclocation;
      if (location) {
        const geocodeUrl = `http://localhost:3000/geocode?address=${encodeURIComponent(
          location
        )}&language=th`;

        try {
          const response = await axios.get(geocodeUrl);
          if (response.data.results.length) {
            const { lat, lng } = response.data.results[0].geometry.location;
            this.formData.latitude = lat;
            this.formData.longitude = lng;
            this.updateMapCenter();
          } else {
            alert("ไม่พบตำแหน่งที่ระบุ");
          }
        } catch (error) {
          console.error("Error fetching location:", error);
          alert("เกิดข้อผิดพลาดในการค้นหาสถานที่");
        }
      } else {
        alert("กรุณากรอกสถานที่เกิดเหตุ");
      }
    },

    async onMapClick(event) {
      const lat = event.latLng.lat().toFixed(7);
      const lng = event.latLng.lng().toFixed(7);
      this.formData.latitude = parseFloat(lat);
      this.formData.longitude = parseFloat(lng);

      const geocodeUrl = `http://localhost:3000/geocode?lat=${lat}&lng=${lng}&language=th`;
      try {
        const response = await axios.get(geocodeUrl);
        if (response.data.results.length) {
          this.formData.acclocation =
            response.data.results[0].formatted_address;
        }
      } catch (error) {
        console.error("Error fetching location:", error);
      }
    },
  },
};
</script>

<style>
.NavBar {
  width: 100%;
}

.MainContentAdd {
  width: 100%;
  margin: 0;
  padding: 50px;
  box-sizing: border-box;
}

.AddHeader {
  margin-left: 30px;
  margin-top: 30px;
}

.input-form-container {
  display: flex;
  justify-content: space-between;
}

.input-form {
  width: 32%;
  padding: 20px;
}

.Addbutton {
  width: 530px;
  margin: 1% auto;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: transform 0.3s ease;
}
.Addbutton:hover {
  transform: scale(1.05);
}

.map-container {
  width: 65%;
  height: 800px;
  margin-top: -50px;
}
</style>
