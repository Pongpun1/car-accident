<template>
  <div>
    <b-navbar fixed="top" expand="lg" variant="faded" type="light" class="bg-blue d-flex justify-content-between">
      <b-navbar-brand href="#">
        <span class="navbar-text ml-3 text-white"><strong>ระบบจัดการเหตุการณ์และอุบัติเหตุ</strong></span>
      </b-navbar-brand>
      <div v-if="isAuthenticated" class="navbar-user">
        <b-icon icon="person-circle" font-scale="2.5" style="color: white;"></b-icon>
        <span class="navbar-text text-white">{{ username }}</span>
        <button @click="logoutUser" variant="secondary" class="btn btn-outline-light btn-xs ml-3 custom-small-btn">ออกจากระบบ</button>
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
  margin-left: 10px;
  font-weight: bold;
}

.header-text {
  color: white;
}

.navbar-user {
  display: flex;
  align-items: center;
  margin-right: 30px;
}

.custom-small-btn {
  font-size: 13px;
  padding: 2px 6px;
  height: 28px;
}

</style>
