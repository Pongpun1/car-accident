<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App',
}
</script>

<style>
html, body, #app {
  margin: 0;
  padding: 0;
  height: 100vh; /* ความสูงเต็มจอ */
  width: 100vw; /* ความกว้างเต็มจอ */
  display: flex;
  justify-content: center;
  align-items: center; /* จัดให้อยู่กลางหน้าจอ */
  box-sizing: border-box;
}
</style>
