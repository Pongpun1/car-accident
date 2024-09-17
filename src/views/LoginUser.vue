<template>
  <div class="main">
    <div class="form-container">
      <form>
        <img src="../assets/gps1.png" class="logo1" alt="GPS Logo" />
        <h2>Sign In</h2>
        <br />
        <div class="form-group">
          <input type="text" class="form-control" placeholder="ID" />
        </div>

        <div class="form-group">
          <input type="password" class="form-control" placeholder="Password" />
        </div>

        <button class="btn login-button">Login</button>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: "LoginUser",
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
  background: rgba(255, 255, 255, 0.3); /* Black with 30% opacity */
  z-index: 1; /* Make sure it sits above the background image but below content */
}

.main > * {
  position: relative;
  z-index: 2; /* Ensure content sits above the overlay */
}

.image-container {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-image {
  max-width: 100%;
  height: auto;
}

.form-container {
  position: fixed;
  top: 50%; /* ตั้งให้ตำแหน่งเริ่มที่กลางหน้าจอ */
  right: 0;
  transform: translateY(-50%); /* เลื่อนขึ้นครึ่งหนึ่งของความสูงฟอร์ม */
  height: 100vh;
  width: 450px; /* กำหนดความกว้างของฟอร์ม */
  padding: 20px;
  background-color: #f9efdf;
  box-shadow: -2px 0 5px rgba(0, 0, 0, 0.2);
  border-radius: 0 0 0 10px;
  display: flex; /* ใช้ Flexbox */
  flex-direction: column; /* ตั้งค่าเป็นแนวตั้ง */
  justify-content: center; /* จัดแนวกลางในแนวตั้ง */
  align-items: center; /* จัดแนวกลางในแนวนอน */
}

form {
  text-align: center; /* จัดข้อความและเนื้อหาให้อยู่ตรงกลาง */
}

h2 {
  margin-top: 20px; /* ปรับระยะห่างด้านบนให้เหมาะสม */
  text-align: left; /* จัดข้อความให้อยู่ทางซ้าย */
  width: 100%; /* ให้ข้อความขยายเต็มความกว้างของฟอร์ม */
}

.logo1 {
  width: 250px;
  margin-bottom: 10px; /* ลด margin-bottom ให้เล็กลง */
  margin-top: -80px; /* ปรับ margin-top เพื่อให้โลโก้ไม่ติดกับด้านบน */
  display: block; /* จัดให้อยู่กึ่งกลาง */
  margin-left: auto;
  margin-right: auto;
}

.form-group {
  margin-bottom: 25px;
  width: 350px;
}

.form-control {
  border-radius: 15px; /* ทำมุมให้โค้งมน */
  height: 45px;
  width: 100%; /* ทำให้ช่องกรอกข้อมูลขยายให้เต็มความกว้างของฟอร์ม */
  padding: 12px 20px; /* เพิ่ม padding ให้ดูใหญ่ขึ้น */
  font-size: 16px; /* ขนาดฟอนต์ที่ใหญ่ขึ้น */
}

.login-button {
  width: 100%; /* ทำให้ปุ่มขยายเต็มความกว้างของฟอร์ม */
  padding: 12px; /* เพิ่ม padding ให้ปุ่ม */
  font-size: 16px; /* ขนาดฟอนต์ที่ใหญ่ขึ้น */
  color: #ffffff; /* สีฟอนต์ */
  background-color: #9a7b4f; /* สีพื้นหลังของปุ่ม */
  border: none; /* ลบเส้นขอบปุ่ม */
  border-radius: 10px; /* ทำมุมให้โค้งมน */
}
</style>
