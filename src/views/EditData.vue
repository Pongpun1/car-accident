<template>
  <div class="MainContentEdit">
    <div class="NavBar">
      <NavTopBar />
    </div>

    <h2 class="EditHeader">แก้ไขข้อมูล</h2>

    <div class="input-form-container">
      <div class="input-form">
        <b-input-group size="lg" prepend="สถานที่เกิดเหตุ" class="input">
          <b-form-input
            v-model="formData.acclocation"
            type="text"
          ></b-form-input>
          <b-input-group-append>
            <b-button @click="searchLocation">
              <b-icon icon="search" aria-hidden="true" font-scale="1"></b-icon>
            </b-button>
          </b-input-group-append>
        </b-input-group>

        <b-input-group size="lg" prepend="ละติจูด" class="input">
          <b-form-input v-model="formData.latitude"></b-form-input>
        </b-input-group>

        <b-input-group size="lg" prepend="ลองจิจูด" class="input">
          <b-form-input v-model="formData.longitude"></b-form-input>
        </b-input-group>

        <b-input-group size="lg" prepend="จำนวนผู้บาดเจ็บ" class="input">
          <b-form-input
            v-model="formData.numinjur"
            type="number"
          ></b-form-input>
        </b-input-group>

        <b-input-group size="lg" prepend="จำนวนผู้เสียชีวิต" class="input">
          <b-form-input
            v-model="formData.numdeath"
            type="number"
          ></b-form-input>
        </b-input-group>

        <b-input-group size="lg" prepend="วันและเวลาเกิดเหตุ" class="input">
          <b-form-input
            id="example-input"
            v-model="formattedAccdate"
            type="text"
            placeholder="เลือกวันและเวลา"
            autocomplete="off"
            readonly
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

        <b-button-group size="lg" class="Editbutton">
          <b-button variant="primary" @click="updateData">
            บันทึกการแก้ไข
          </b-button>
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
import NavTopBar from "../components/nav-bar.vue";
import axios from "axios";
import { Map, Marker as GoogleMapMarker } from "vue2-google-maps";
import { format } from "date-fns";
import { th } from "date-fns/locale";

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
      },
      mapCenter: {
        lat: 13.736717,
        lng: 100.523186,
      },
    };
  },

  computed: {
    formattedAccdate() {
      return this.formData.accdate
        ? format(new Date(this.formData.accdate), "d MMMM yyyy", { locale: th })
        : "";
    },
  },

  methods: {
    showSingleData() {
      const id = this.$route.params.id;
      axios
        .get(`http://localhost:3000/api/data/${id}`)
        .then((response) => {
          this.formData = response.data.data[0];
          this.updateMapCenter();
        })
        .catch((error) => {
          console.error("Error fetching data from API:", error);
        });
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

    updateData() {
      const id = this.$route.params.id;
      axios
        .put(`http://localhost:3000/api/data/${id}`, this.formData)
        .then(() => {
          alert("ข้อมูลได้รับการอัปเดต");
          this.$router.push("/data");
        })
        .catch((error) => {
          console.error("Error updating data:", error);
          alert("ข้อมูลนี้มีอยู่แล้วในระบบ");
        });
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

  mounted() {
    this.showSingleData();
  },
};
</script>

<style>
/* CSS ที่ใช้สำหรับจัดหน้า */
.NavBar {
  width: 100%;
}

.MainContentEdit {
  width: 100%;
  margin: 0;
  padding: 50px;
  box-sizing: border-box;
}

.EditHeader {
  margin-left: 30px;
  margin-top: 60px;
}

.input-form-container {
  display: flex;
  justify-content: space-between;
}

.input-form .input {
  margin-bottom: 15px;
}

.input-form {
  width: 32%;
  padding: 20px;
}

.Editbutton {
  width: 300px;
  margin: 1% auto;
  display: flex;
  justify-content: center;
  align-items: center;
}

.map-container {
  width: 65%;
  height: 800px;
}
</style>
