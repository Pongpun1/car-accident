import "@babel/polyfill";
import "mutationobserver-shim";
import Vue from "vue";
import { BootstrapVue, BootstrapVueIcons } from "bootstrap-vue";
import "./plugins/bootstrap-vue";
import App from "./App.vue";
import axios from "axios";
import store from "./store";
import router from "./router";
import * as VueGoogleMaps from "vue2-google-maps";
import "@/styles/accident-data.css";

store.dispatch("initializeStore");

Vue.use(BootstrapVue);
Vue.use(BootstrapVueIcons);
Vue.config.productionTip = false;
Vue.use(VueGoogleMaps, {
  load: {
    key: "AIzaSyBpTaSCF5FB940suGM1mmn5oMhewau86PQ",
    libraries: "places",
  },
});

axios.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers["Authorization"] = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
