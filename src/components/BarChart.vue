<template>
  <div>
    <Bar
      :key="chartData.labels.length"
      :data="chartData"
      :options="chartOptions"
      :width="600"
      :height="400"
    />
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
import ChartDataLabels from "chartjs-plugin-datalabels";
import axios from "axios";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  ChartDataLabels,
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
        labels: [],
        datasets: [
          {
            label: "จำนวนผู้เสียชีวิต",
            data: [],
            backgroundColor: "rgba(255, 0, 0, 0.6)",
          },
          {
            label: "จำนวนผู้บาดเจ็บ",
            data: [],
            backgroundColor: "rgba(76, 175, 80, 0.6)",
          },
        ],
      },

      chartOptions: {
        plugins: {
          datalabels: {
            color: "white",
            anchor: "end",
            align: "start",
            font: {
              weight: "bold",
            },
            formatter: (value) => {
              return value;
            },
          },
        },
        responsive: true,
        scales: {
          x: {
            ticks: {
              color: "black",
              font: {
                weight: "bold",
                size: "14",
              },
            },
          },
          y: {
            ticks: {
              color: "black",
              font: {
                weight: "bold",
                size: "13",
              },
            },
          },
        },
      },
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      axios
        .get("http://localhost:3000/api/data/")
        .then((response) => {
          const accidents = response.data.data;

          const aggregatedData = {};

          accidents.forEach((accident) => {
            if (aggregatedData[accident.acclocation]) {
              aggregatedData[accident.acclocation].numdeath +=
                accident.numdeath;
              aggregatedData[accident.acclocation].numinjur +=
                accident.numinjur;
            } else {
              aggregatedData[accident.acclocation] = {
                numdeath: accident.numdeath,
                numinjur: accident.numinjur,
              };
            }
          });

          const labels = Object.keys(aggregatedData);
          const deathData = labels.map(
            (location) => aggregatedData[location].numdeath
          );
          const injuryData = labels.map(
            (location) => aggregatedData[location].numinjur
          );

          this.chartData.labels = labels;
          this.chartData.datasets[0].data = deathData;
          this.chartData.datasets[1].data = injuryData;
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
        });
    },
  },
};
</script>

<style scoped>
canvas {
  max-width: 100% !important;
  height: auto !important;
}
</style>
