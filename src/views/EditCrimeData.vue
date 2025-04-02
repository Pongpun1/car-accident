<template>
  <div class="MainContentEdit">
    <div class="NavBar">
      <NavTopBar />
    </div>

    <h2 class="EditHeader">
      <strong>{{ $t("editInfo") }}</strong>
    </h2>

    <div class="input-form-container">
      <div class="input-form">
        <b-input-group size="lg" :prepend="$t('location')" class="input">
          <b-form-input
            v-model="formData.crimelocation"
            type="text"
            :placeholder="$t('locationHolder')"
          ></b-form-input>
          <b-input-group-append>
            <b-button @click="searchLocation">
              <b-icon icon="search" aria-hidden="true" font-scale="1"></b-icon>
            </b-button>
          </b-input-group-append>
        </b-input-group>

        <b-input-group
          size="lg"
          :prepend="$t('latitude')"
          :placeholder="$t('latitudeHolder')"
          class="input"
        >
          <b-form-input v-model="formData.latitude"></b-form-input>
        </b-input-group>

        <b-input-group
          size="lg"
          :prepend="$t('longitude')"
          :placeholder="$t('longitudeHolder')"
          class="input"
        >
          <b-form-input v-model="formData.longitude"></b-form-input>
        </b-input-group>

        <b-input-group size="lg" :prepend="$t('injured')" class="input">
          <b-form-input
            v-model="formData.numinjur"
            type="number"
          ></b-form-input>
        </b-input-group>

        <b-input-group size="lg" :prepend="$t('death')" class="input">
          <b-form-input
            v-model="formData.numdeath"
            type="number"
          ></b-form-input>
        </b-input-group>

        <b-input-group size="lg" :prepend="$t('date')" class="input">
          <b-form-input
            id="example-input"
            v-model="formattedCrimedate"
            type="text"
            :placeholder="$t('dateHolder')"
            autocomplete="off"
          ></b-form-input>
          <b-input-group-append>
            <b-form-datepicker
              v-model="formData.crimedate"
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

        <b-input-group size="lg" :prepend="$t('category')" class="input">
          <b-form-select
            v-model="formData.category"
            :options="categories"
          ></b-form-select>
        </b-input-group>

        <b-input-group size="lg" class="input">
          <b-form-textarea
            v-model="formData.crimeinfo"
            rows="5"
            max-rows="8"
            :placeholder="$t('infoHolder')"
          ></b-form-textarea>
        </b-input-group>

        <b-button-group size="lg" class="Editbutton">
          <b-button variant="primary" @click="updateData">
            {{ $t("editSave") }}
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
import { API_URL } from "@/config";
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
        category: "อาชญากรรม",
        crimelocation: "",
        latitude: "",
        longitude: "",
        numinjur: 0,
        numdeath: 0,
        crimedate: "",
      },
      categories: [
        { value: "อุบัติเหตุ", text: this.$t("accident") },
        { value: "อาชญากรรม", text: this.$t("crime") },
        { value: "ไม่ระบุรายละเอียด", text: this.$t("unspecified") },
      ],
      mapCenter: {
        lat: 13.736717,
        lng: 100.523186,
      },
    };
  },

  computed: {
    formattedCrimedate() {
      if (this.formData.crimedate) {
        const date = new Date(this.formData.crimedate);
        const buddhistYear = date.getFullYear() + 543;
        return `${date.getDate()} ${date.toLocaleString("th-TH", {
          month: "long",
        })} ${buddhistYear}`;
      }
      return "";
    },
  },

  methods: {
    showCrimeSingleData() {
      const id = this.$route.params.id;
      axios
        .get(`${API_URL}/api/crimedata/${id}`)
        .then((response) => {
          this.formData = response.data.data[0];
          if (!this.formData.category) {
            this.formData.category = "อาชญากรรม";
          }
          this.updateMapCenter();
        })
        .catch((error) => {
          console.error("Error fetching data from API:", error);
        });
    },

    updateData() {
      const id = this.$route.params.id;

      this.formData.latitude = parseFloat(this.formData.latitude);
      this.formData.longitude = parseFloat(this.formData.longitude);

      const formatDate = (dateStr) => {
        if (!dateStr) return null;
        const dateObj = new Date(dateStr);
        if (isNaN(dateObj)) return null;
        return dateObj.toISOString().split("T")[0];
      };
      this.formData.crimedate = formatDate(this.formData.crimedate);
      
      if (this.formData.category === "อาชญากรรม") {
        axios
          .put(`${API_URL}/api/crimedata/${id}`, this.formData)
          .then(() => {
            alert(this.$t("dataUpdated"));
            this.$router.push("/data");
          })
          .catch((error) => {
            console.error("Error updating data:", error);
            alert(this.$t("dataExists"));
          });
      } else {
        axios
          .delete(`${API_URL}/api/crimedata/${id}`)
          .then(() => {
            const newData = { ...this.formData };

            if (this.formData.category === "อุบัติเหตุ") {
              newData.acclocation = newData.crimelocation;
              newData.accdate = formatDate(newData.crimedate);
              newData.accinfo = newData.crimeinfo;
              delete newData.crimelocation;
              delete newData.crimedate;
              delete newData.crimeinfo;

              axios
                .post(`${API_URL}/api/accidentdata/single`, newData)
                .then(() => {
                  alert(this.$t("dataUpdated"));
                  this.$router.push("/data");
                });
            } else if (this.formData.category === "ไม่ระบุรายละเอียด") {
              newData.location = newData.crimelocation;
              newData.date = formatDate(newData.crimedate);
              newData.info = newData.crimeinfo;
              delete newData.crimelocation;
              delete newData.crimedate;
              delete newData.crimeinfo;

              axios
                .post(`${API_URL}/api/unspecifieddata/single`, newData)
                .then(() => {
                alert(this.$t("dataUpdated"));
                  this.$router.push("/data");
                });
            }
          })
          .catch((error) => {
            console.error("Error moving data:", error);
            alert(this.$t("errorMovingData"));
          });
      }
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
      const location = this.formData.crimelocation;
      if (location) {
        const geocodeUrl = `${API_URL}/geocode?address=${encodeURIComponent(
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
            alert(this.$t("notFoundLocation"));
          }
        } catch (error) {
          console.error("Error fetching location:", error);
        }
      } else {
        alert(this.$t("enterLocation"));
      }
    },

    async onMapClick(event) {
      const lat = event.latLng.lat().toFixed(7);
      const lng = event.latLng.lng().toFixed(7);
      this.formData.latitude = parseFloat(lat);
      this.formData.longitude = parseFloat(lng);

      const geocodeUrl = `${API_URL}/geocode?lat=${lat}&lng=${lng}&language=th`;
      try {
        const response = await axios.get(geocodeUrl);
        if (response.data.results.length) {
          this.formData.crimelocation =
            response.data.results[0].formatted_address;
        }
      } catch (error) {
        console.error("Error fetching location:", error);
      }
    },
  },

  mounted() {
    this.showCrimeSingleData();
  },
};
</script>

<style>
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
  margin-top: 30px;
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
  width: 530px;
  margin: 1% auto;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: transform 0.3s ease;
}

.Editbutton:hover {
  transform: scale(1.05);
}

.map-container {
  width: 65%;
  height: 800px;
  margin-top: -50px;
}
</style>
