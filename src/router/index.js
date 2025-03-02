import Vue from "vue";
import VueRouter from "vue-router";
import Login from "../views/LoginUser.vue";
import Data from "../views/Accident-data.vue";
import EditAccident from "../views/EditAccidentData.vue";
import EditCrime from "../views/EditCrimeData.vue";
import EditUnspecified from "../views/EditUnspecData.vue";
import Add from "../views/AddData.vue";
import StatisticsAccident from "../views/Statistics-Accident.vue";
import StatisticsCrime from "../views/Statistics-Crime.vue";

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
    path: "/data/editaccident/:id",
    name: "editaccident",
    component: EditAccident,
    props: true,
    meta: { requiresAuth: true },
  },
  {
    path: "/data/editcrime/:id",
    name: "editcrime",
    component: EditCrime,
    props: true,
    meta: { requiresAuth: true },
  },
  {
    path: "/data/editunspecified/:id",
    name: "editunspecified",
    component: EditUnspecified,
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
  {
    path: "/statistics/accidents",
    name: "statistics-accidents",
    component: StatisticsAccident,
    props: true,
    meta: { requiresAuth: true },
  },
  {
    path: "/statistics/crimes",
    name: "statistics-crimes",
    component: StatisticsCrime,
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
