<template>
  <div>
    <b-navbar
      fixed="top"
      expand="lg"
      variant="faded"
      type="light"
      class="bg-blue d-flex justify-content-between"
    >
      <b-navbar-brand class="d-flex align-items-center">
        <span class="navbar-text ml-3 text-white">
          <strong>ระบบจัดการเหตุการณ์และอุบัติเหตุ</strong>
        </span>

        <!-- ปุ่มจัดการข้อมูล -->
        <span
          @click="$router.push('/data')"
          class="ml-4 navbar-link"
          :style="navStyle('/data')"
        >
          จัดการข้อมูล
          <b-icon icon="house-door-fill" class="ml-1" font-scale="1.2"></b-icon>
        </span>

        <b-dropdown
          variant="link"
          toggle-class="text-white navbar-link ml-3"
          no-caret
          class="custom-dropdown"
        >
          <template #button-content>
            <span :style="navStyle('/statistics')">
              สถิติ
              <b-icon icon="bar-chart-line-fill" class="ml-1" font-scale="1.2"></b-icon>
            </span>
          </template>
          <b-dropdown-item @click="$router.push('/statistics/accidents')">
            <b-icon icon="cone" class="mr-2"></b-icon> สถิติอุบัติเหตุ
          </b-dropdown-item>
          <b-dropdown-item @click="$router.push('/statistics/crimes')">
            <b-icon icon="people-fill" class="mr-2"></b-icon> สถิติอาชญากรรม
          </b-dropdown-item>
        </b-dropdown>
      </b-navbar-brand>

      <div v-if="isAuthenticated" class="navbar-user">
        <b-icon icon="person-circle" font-scale="2.5" style="color: white"></b-icon>
        <span class="navbar-text text-white">{{ username }}</span>
        <b-button
          @click="logoutUser"
          variant="danger"
          class="btn btn-xs ml-3 custom-small-btn"
          ><strong>ออกจากระบบ</strong></b-button
        >
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
    navStyle(path) {
      return {
        backgroundColor: this.$route.path.includes(path) ? "white" : "transparent",
        color: this.$route.path.includes(path) ? "#9a7b4f" : "white",
        borderRadius: this.$route.path.includes(path) ? "10px" : "0",
        padding: "5px 10px",
      };
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
  font-size: 20px;
  margin-left: 10px;
  font-weight: bold;
}

.navbar-user {
  display: flex;
  align-items: center;
  margin-right: 30px;
}

.custom-small-btn {
  font-size: 12px;
  padding: 2px 6px;
  height: 28px;
  transition: transform 0.3s ease;
}

.custom-small-btn:hover {
  transform: scale(1.05);
}

.navbar-link {
  cursor: pointer;
  font-size: 18px;
  font-weight: bold;
  padding: 5px;
}
.navbar-link:hover {
  text-decoration: underline;
}

/* ปรับสไตล์ Dropdown */
.custom-dropdown .dropdown-menu {
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.custom-dropdown .dropdown-item {
  font-size: 16px;
  font-weight: bold;
  color: #333;
  padding: 10px 20px;
}

.custom-dropdown .dropdown-item:hover {
  background-color: #f1f1f1;
}

</style>
