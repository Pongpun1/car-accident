import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    username: localStorage.getItem("username") || "",
    token: localStorage.getItem("token") || "",
    isAuthenticated: !!localStorage.getItem("token"),
  },
  mutations: {
    setUser(state, payload) {
      state.username = payload.username;
      state.token = payload.token;
      state.isAuthenticated = true;
    },
    logout(state) {
      state.username = "";
      state.token = "";
      state.isAuthenticated = false;
    },
  },
  actions: {
    login({ commit }, user) {
      localStorage.setItem("username", user.username);
      localStorage.setItem("token", user.token);
      commit("setUser", user);
    },

    logout({ commit }) {
      commit("logout");
      localStorage.removeItem("token");
      localStorage.removeItem("username");
    },

    initializeStore({ commit }) {
      const token = localStorage.getItem("token");
      const username = localStorage.getItem("username");
      if (token && username) {
        commit("setUser", { username, token });
      } else {
        commit("logout");
      }
    },
  },
  getters: {
    username: (state) => state.username,
    token: (state) => state.token,
    isAuthenticated: (state) => state.isAuthenticated,
  },
});
