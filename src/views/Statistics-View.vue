<template>
  <div>
    <div class="NavBar">
      <NavTopBar />
    </div>
    <div class="charts">
      <BarChart />
      <PieChart />
    </div>
  </div>
</template>

<script>
import NavTopBar from "../components/nav-bar.vue";
import PieChart from "../components/PieChart.vue";
import BarChart from "../components/BarChart.vue";

export default {
  components: {
    NavTopBar,
    PieChart,
    BarChart,
  },
  data() {
    return {
    };
  }
};
</script>

<style>
.charts {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100vw;
  height: 100vh;

}

.charts > div {
  flex: 1; 
  max-width: 600px;
  margin: 0 5px;
  background-color: #000000;
}
</style>
