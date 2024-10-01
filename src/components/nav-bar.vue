<template>
  <div>
    <b-navbar fixed="top" expand="lg" variant="faded" type="light" class="bg-blue d-flex justify-content-between">
      <b-navbar-brand href="#">
        <span class="navbar-text ml-3 text-white"> ระบบจัดการเหตุการณ์และอุบัติเหตุ </span>
      </b-navbar-brand>
      <div v-if="isAuthenticated" class="navbar-user">
        <span class="navbar-text text-white">ยินดีต้อนรับ, {{ username }}</span>
        <button @click="logoutUser" variant="secondary" class="btn btn-outline-light btn-sm ml-3">ออกจากระบบ</button>
      </div>
    </b-navbar>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

export default {
  name: "NavTopBar",
  computed: {
    ...mapGetters(["username", "isAuthenticated"]),
  },
  methods: {
    ...mapActions(["logout"]),
    logoutUser() {
      this.logout();
      this.$store.dispatch("initializeStore");
      this.$router.push("/"); 
    },
  },
  mounted() {
    this.$store.dispatch("initializeStore");
  },
};
</script>

<style>
.bg-blue {
  background-color: #9a7b4f;
  width: 100%;
  padding: 0;
}

.navbar-text {
  font-size: 25px;
  margin-left: 20px;
}

.text-white {
  color: white;
}

.navbar-user {
  display: flex;
  align-items: center;
  margin-right: 30px;
}

.navbar-user button {
  margin-left: 15px;
}

body {
  background-color: #f9efdf;
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
}
</style>
