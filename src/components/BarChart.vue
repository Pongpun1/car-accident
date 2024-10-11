<template>
  <div>
    <Bar :data="chartData" :width="600" :height="400" />
  </div>
</template>

<script>
import { Bar } from "vue-chartjs";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);

export default {
  components: {
    Bar,
  },
  data() {
    return {
      chartData: {
        labels: ["Red", "Blue", "Yellow"],
        datasets: [
          {
            label: "Votes",
            data: [12, 19, 3],
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
  width: 600px !important;
  height: 400px !important;
}
</style>
