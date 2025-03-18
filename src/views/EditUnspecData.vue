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
            v-model="formData.location"
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
            v-model="formatteddate"
            type="text"
            :placeholder="$t('dateHolder')"
            autocomplete="off"
          ></b-form-input>
          <b-input-group-append>
            <b-form-datepicker
              v-model="formData.date"
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
            v-model="formData.info"
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
        category: "ไม่ระบุ",
        location: "",
        latitude: "",
        longitude: "",
        numinjur: 0,
        numdeath: 0,
        date: "",
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
    formatteddate() {
      if (this.formData.date) {
        const date = new Date(this.formData.date);
        const buddhistYear = date.getFullYear() + 543;
        return `${date.getDate()} ${date.toLocaleString("th-TH", {
          month: "long",
        })} ${buddhistYear}`;
      }
      return "";
    },
  },

  methods: {
    showAccidentSingleData() {
      const id = this.$route.params.id;
      axios
        .get(`http://localhost:3000/api/unspecifieddata/${id}`)
        .then((response) => {
          this.formData = response.data.data[0];
          if (!this.formData.category) {
            this.formData.category = "ไม่ระบุรายละเอียด";
          }
          this.updateMapCenter();
        })
        .catch((error) => {
          console.error("Error fetching data from API:", error);
        });
    },

    updateData() {
      const id = this.$route.params.id;

      if (this.formData.category === "ไม่ระบุ") {
        axios
          .put(`http://localhost:3000/api/unspecifieddata/${id}`, this.formData)
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
          .delete(`http://localhost:3000/api/unspecifieddata/${id}`)
          .then(() => {
            const newData = { ...this.formData };

            if (this.formData.category === "อุบัติเหตุ") {
              newData.acclocation = newData.location;
              newData.accdate = newData.date;
              newData.accinfo = newData.info;
              delete newData.location;
              delete newData.date;
              delete newData.info;

              axios
                .post("http://localhost:3000/api/accidentdata/single", newData)
                .then(() => {
                  this.$router.push("/data");
                });
            } else if (this.formData.category === "ไม่ระบุ") {
              newData.crimelocation = newData.location;
              newData.crimedate = newData.date;
              newData.crimeinfo = newData.info;
              delete newData.location;
              delete newData.date;
              delete newData.info;

              axios
                .post("http://localhost:3000/api/crimedata/single", newData)
                .then(() => {
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
      const location = this.formData.location;
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

      const geocodeUrl = `http://localhost:3000/geocode?lat=${lat}&lng=${lng}&language=th`;
      try {
        const response = await axios.get(geocodeUrl);
        if (response.data.results.length) {
          this.formData.location = response.data.results[0].formatted_address;
        }
      } catch (error) {
        console.error("Error fetching location:", error);
      }
    },
  },

  mounted() {
    this.showAccidentSingleData();
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
