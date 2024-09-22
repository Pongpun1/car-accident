<template>
  <div>
    <div class="NavBar">
      <NavTopBar />
    </div>

    <div class="MainContent">
      <h2>เพิ่มข้อมูลข้อมูล</h2>

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
        <b-button variant="primary" @click="AddData">บันทึกข้อมูล</b-button>
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

    AddData() {
      if (
        !this.formData.acclocation ||
        !this.formData.latitude ||
        !this.formData.longitude ||
        !this.formData.accdate
      ) {
        alert("กรุณากรอกข้อมูลให้ครบถ้วน");
        return;
      }

      axios
        .post("http://localhost:8080/api/data/single", this.formData, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then(() => {
          alert("บันทึกข้อมูลสำเร็จ");
          
          this.$router.push("/data");
          this.formData = {
            acclocation: "",
            latitude: "",
            longitude: "",
            numinjur: 0,
            numdeath: 0,
            accdate: "",
          };
        })
        .catch((error) => {
          if (error.response && error.response.status === 400) {
            alert(error.response.data.message);
          } else {
            console.error("เกิดข้อผิดพลาด:", error);
            alert("เกิดข้อผิดพลาดในการบันทึกข้อมูล");
          }
        });
    },
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
