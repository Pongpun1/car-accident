<template>
  <div>
    <div class="NavBar">
      <NavTopBar />
    </div>

    <div class="MainContent">
      <h2>แก้ไขข้อมูล</h2>

      <b-input-group size="lg" prepend="สถานที่เกิดเหตุ" class="input">
        <b-form-input v-model="formData.acclocation" type="text"></b-form-input>
      </b-input-group>

      <b-input-group size="lg" prepend="ละติจูด" class="input">
        <b-form-input v-model="formData.latitude"></b-form-input>
      </b-input-group>

      <b-input-group size="lg" prepend="ลองจิจูด" class="input">
        <b-form-input v-model="formData.longitude"></b-form-input>
      </b-input-group>

      <b-input-group size="lg" prepend="จำนวนผู้บาดเจ็บ" class="input">
        <b-form-input v-model="formData.numinjur" type="number"></b-form-input>
      </b-input-group>

      <b-input-group size="lg" prepend="จำนวนผู้เสียชีวิต" class="input">
        <b-form-input v-model="formData.numdeath" type="number"></b-form-input>
      </b-input-group>

      <b-input-group size="lg" prepend="วันและเวลาเกิดเหตุ" class="input">
        <b-form-input
          id="example-input"
          v-model="formData.accdate"
          type="text"
          placeholder="YYYY-MM-DD"
          autocomplete="off"
        ></b-form-input>
        <b-input-group-append>
          <b-form-datepicker
            v-model="formData.accdate"
            button-only
            right
            locale="th-US"
            aria-controls="example-input"
          ></b-form-datepicker>
        </b-input-group-append>
      </b-input-group>

      <b-button-group size="lg" class="button">
        <b-button variant="primary" @click="updateData">บันทึกการแก้ไข</b-button>
      </b-button-group>
    </div>
  </div>
</template>

<script>
import NavTopBar from "../components/nav-bar.vue";
import axios from "axios";

export default {
  components: {
    NavTopBar,
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
    };
  },
  methods: {
    showSingleData() {
      const id = this.$route.params.id;
      axios
        .get(`http://localhost:8080/api/data/${id}`)
        .then((response) => {
          this.formData = response.data.data[0];
        })
        .catch((error) => {
          console.error("Error fetching data from API:", error);
        });
    },

    updateData() {
      const id = this.$route.params.id;
      axios
        .put(`http://localhost:8080/api/data/${id}`, this.formData)
        .then(() => {
          alert("ข้อมูลได้รับการอัปเดตเรียบร้อยแล้ว");
          this.$router.push("/data");
        })
        .catch((error) => {
          console.error("Error updating data:", error);
        });
    },
  },

  mounted() {
    this.showSingleData();
  },
};
</script>

<style>
.NavBar {
  width: 100%;
}

.MainContent {
  position: absolute;
  top: 5%;
  left: 20px;
  padding: 20px;
}

.MainContent h2 {
  margin-bottom: 10px;
}

.input {
  margin-bottom: 10px;
}

.button {
  width: 500px;
}
</style>
