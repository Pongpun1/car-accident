<template>
  <div>
    <Pie
      :key="chartData.labels.length"
      :data="chartData"
      :options="chartOptions"
      :width="400"
      :height="400"
    />
  </div>
</template>

<script>
import { Pie } from "vue-chartjs";
import { Chart as ChartJS, Title, Tooltip, Legend, ArcElement } from "chart.js";
import ChartDataLabels from "chartjs-plugin-datalabels";
import axios from "axios";
import { API_URL } from "@/config";

ChartJS.register(Title, Tooltip, Legend, ArcElement, ChartDataLabels);

export default {
  components: {
    Pie,
  },
  data() {
    return {
      chartData: {
        labels: [],
        datasets: [
          {
            label: "เปอร์เซ็นต์ผู้บาดเจ็บและผู้เสียชีวิตในสถานที่",
            data: [],
            backgroundColor: [
              "rgba(244, 67, 54, 0.6)",
              "rgba(33, 150, 243, 0.6)",
              "rgba(255, 152, 0, 0.6)",
              "rgba(76, 175, 80, 0.6)",
            ],
            borderColor: "#fff", // สีขอบเป็นสีขาว
            borderWidth: 2,
          },
        ],
      },
      chartOptions: {
        plugins: {
          datalabels: {
            formatter: (value) => {
              return value + "%";
            },
            color: "#fff",
            font: {
              weight: "bold",
              size: 18,
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
        .get(`${API_URL}/api/accidentdata/`)
        .then((response) => {
          const accidents = response.data.data;

          const locationData = accidents.reduce((acc, curr) => {
            const location = curr.acclocation;
            if (!acc[location]) {
              acc[location] = { numinjur: 0, numdeath: 0 };
            }
            acc[location].numinjur += curr.numinjur;
            acc[location].numdeath += curr.numdeath;
            return acc;
          }, {});

          const sortedLocations = Object.entries(locationData)
            .map(([location, data]) => ({
              location,
              total: data.numinjur + data.numdeath,
            }))
            .sort((a, b) => b.total - a.total);

          const topThreeLocations = sortedLocations.slice(0, 3);
          const otherTotal = sortedLocations
            .slice(3)
            .reduce((sum, loc) => sum + loc.total, 0);

          const labels = topThreeLocations.map((loc) => loc.location);
          const data = topThreeLocations.map((loc) => loc.total);

          // ตรวจสอบว่า otherTotal มีค่ามากกว่าศูนย์หรือไม่
          if (otherTotal > 0) {
            labels.push("อื่นๆ");
            data.push(otherTotal);
          }

          const totalInjuries = data.reduce((sum, value) => sum + value, 0);
          const percentages = data.map((value) =>
            ((value / totalInjuries) * 100).toFixed(2)
          );

          this.chartData.labels = labels;
          this.chartData.datasets[0].data = percentages;

          console.log("Updated Chart Data:", this.chartData);
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
  width: 400px !important;
  height: 400px !important;
}
</style>
