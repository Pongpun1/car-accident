import Vue from "vue";
import VueRouter from "vue-router";
import Login from "../views/LoginUser.vue";
import Data from "../views/Accident-data.vue";
import Edit from "../views/EditData.vue";
import Add from "../views/AddData.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "login",
    component: Login,
    meta: { requiresGuest: true },
  },
  {
    path: "/data",
    name: "data",
    component: Data,
    meta: { requiresAuth: true },
  },
  {
    path: "/data/edit/:id",
    name: "edit",
    component: Edit,
    props: true,
    meta: { requiresAuth: true },
  },
  {
    path: "/data/add",
    name: "add",
    component: Add,
    props: true,
    meta: { requiresAuth: true },
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

router.beforeEach((to, from, next) => {
  const isAuthenticated = localStorage.getItem("token");
  if (
    to.matched.some((record) => record.meta.requiresAuth) &&
    !isAuthenticated
  ) {
    next("/");
  } 
  else if (
    to.matched.some((record) => record.meta.requiresGuest) &&
    isAuthenticated
  ) {
    next("/data");
  } 
  else {
    next();
  }
});

export default router;
