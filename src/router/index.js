import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/LoginUser.vue'
import Data from '../views/Accident-data.vue'
import Edit from '../views/EditData.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'login',
    component: Login
  },
  {
    path: '/data',
    name: 'data',
    component: Data
  },
  {
    path: '/data/edit/:id',
    name: 'edit',
    component: Edit,
    props: true,
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
