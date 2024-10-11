<template>
  <div>
    <Pie :data="chartData" :width="400" :height="400" />
  </div>
</template>

<script>
import { Pie } from "vue-chartjs";
import { Chart as ChartJS, Title, Tooltip, Legend, ArcElement } from "chart.js";

ChartJS.register(Title, Tooltip, Legend, ArcElement);

export default {
  components: {
    Pie,
  },
  data() {
    return {
      chartData: {
        labels: ["Red", "Blue", "Yellow"],
        datasets: [
          {
            label: "My First Dataset",
            data: [300, 50, 100],
            backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56"],
          },
        ],
      },
    };
  },
};
</script>

<style scoped>
canvas {
  width: 400px !important;
  height: 400px !important;
}
</style>
