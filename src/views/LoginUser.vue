<template>
  <div class="main">
    <div class="form-container">
      <form @submit.prevent="login">
        <!-- <img src="../assets/gps1.png" class="logo1" alt="GPS Logo" /> -->
        <h3>เข้าสู่ระบบ</h3>
        <br />
        <b-form-group
          :state="usernameState"
          invalid-feedback="กรุณากรอกชื่อผู้ใช้งาน"
          label-cols-sm="12"
          class="form-group-custom"
        >
          <b-form-input
            id="username-input"
            v-model="username"
            :state="usernameState"
            placeholder="ชื่อผู้ใช้"
            class="form-control"
          />
        </b-form-group>

        <b-form-group
          :state="passwordState"
          invalid-feedback="กรุณากรอกรหัสผ่าน"
          label-cols-sm="12"
          class="form-group-custom"
        >
          <b-form-input
            id="password-input"
            type="password"
            v-model="password"
            :state="passwordState"
            placeholder="รหัสผ่าน"
            class="form-control"
          />
        </b-form-group>

        <button class="btn login-button">เข้าสู่ระบบ</button>

        <p v-if="errorMessage" class="error-box">
          <span class="error">{{ errorMessage }}</span>
        </p>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "LoginUser",
  data() {
    return {
      username: "",
      password: "",
      errorMessage: "",
    };
  },
  computed: {
    usernameState() {
      return this.username.length > 0 ? true : null;
    },
    passwordState() {
      return this.password.length > 0 ? true : null;
    },
  },
  methods: {
    async login() {
      if (!this.username || !this.password) {
        this.errorMessage = "กรุณากรอกข้อมูลให้ครบถ้วน";
        return;
      }

      try {
        const response = await axios.post("http://34.126.127.208:3000/users/login", {
          username: this.username,
          password: this.password,
        });

        if (response.data.message === "เข้าสู่ระบบสำเร็จ") {
          localStorage.setItem("token", response.data.token);
          localStorage.setItem("username", response.data.user.username);
          // this.login({ username: response.data.user.username });
          this.$store.dispatch("initializeStore");  
          await this.$router.push("/data");
          
        } else {
          this.errorMessage = "การเข้าสู่ระบบล้มเหลว";
        }
      } catch (error) {
        this.errorMessage = error.response?.data?.message || "ไม่พบข้อมูล";
      } finally {
        this.$store.dispatch("initializeStore");
      }
    },
  },
};
</script>

<style>
.main {
  display: flex;
  height: 100vh;
  width: 100vw;
  background-image: url("../assets/background.jpg");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  position: relative;
}

.main::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(255, 255, 255, 0.3);
  z-index: 1;
}

.main > * {
  position: relative;
  z-index: 2;
}

.image-container {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.form-container {
  position: fixed;
  top: 50%;
  right: 0;
  transform: translateY(-50%);
  height: 100vh;
  width: 450px;
  padding: 20px;
  background-color: #f9efdf;
  box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
  border-radius: 0 10px 10px 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

form {
  text-align: left;
  margin-left: 20px;
}

h3 {
  margin-bottom: -20px;
  text-align: left;
  width: 100%;
}

/* .logo1 {
  width: 250px;
  margin-bottom: 10px;
  margin-top: -80px;
  display: block;
  margin-left: auto;
  margin-right: auto;
} */

.form-group {
  margin-bottom: 5px;
  width: 100%;
}

.form-group-custom {
  text-align: left;
  width: 100%;
}

.form-control {
  height: 40px;
  width: 90%;
  padding: 12px 20px;
  font-size: 16px;
}

.login-button {
  margin-top: 15px;
  height: 50px;
  width: 90%;
  padding: 12px;
  font-size: 17px;
  color: #ffffff;
  background-color: #9a7b4f;
  border-radius: 10px;
}

.error-box {
  background-color: #f8d7da;
  border: 1px solid #f5c2c7;
  color: #842029;
  padding: 10px;
  width: 90%;
  border-radius: 5px;
  margin-top: 20px;
  text-align: left;
}

.error {
  font-size: 14px;
}
</style>
