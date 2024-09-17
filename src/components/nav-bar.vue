<template>
    <div>
      <!-- Navbar with User text next to logo -->
      <b-navbar fixed="top" expand="lg" variant="faded" type="light" class="bg-blue d-flex justify-content-start">
        <b-navbar-brand href="#">
          <img src="../assets/gps1.png" class="logo d-inline-block align-top" alt="Kitten">
          <span class="navbar-text">Pongpun Saengphon</span>
        </b-navbar-brand>
      </b-navbar>
    </div>
  </template>
  
  <script>
  export default {
    name: "NavTopBar",
  };
  </script>
  
  <style>
  /* กำหนดสีพื้นหลัง navbar */
  .bg-blue {
    background-color: #9A7B4F;
    width: 100%;
    padding: 0;
  }
  
  /* ปรับขนาดและตำแหน่งของ logo */
  .logo {
    width: 50px;
    height: 50px;
    margin-top: 0;
    margin-left: 30px;
    padding-top: 0;
    vertical-align: middle;
  }

  .navbar-text {
    font-size: 25px;
    margin-left: 20px;
  }
  
  /* ปรับ body ให้ไม่มี margin/padding และกำหนดฟอนต์ */
  body {
    background-color: #f9efdf;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
  }
  </style>
  