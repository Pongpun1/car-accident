<template>
  <div>
    <p style="text-align: center; font-weight: bold;">สถิติอุบัติเหตุ</p>
    <Bar
      :key="'accident-' + accidentChartData.labels.join('-')"
      :data="accidentChartData"
      :options="chartOptions"
      :width="600"
      :height="400"
    />
    <p style="text-align: center; font-weight: bold;">สถิติอาชญากรรม</p>
    <Bar
      :key="'crime-' + crimeChartData.labels.join('-')"
      :data="crimeChartData"
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
      accidentChartData: {
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

      crimeChartData: {
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
    this.fetchAccidentData();
    this.fetchCrimeData();
  },
  methods: {
    fetchAccidentData() {
      axios
        .get("http://localhost:3000/api/accidentdata/")
        .then((response) => {
          const accidents = response.data.data;

          const aggregatedData = {};

          accidents.forEach((accident) => {
            // ตรวจสอบว่า `numdeath` และ `numinjur` มีค่าหรือไม่
            const numdeath = accident.numdeath || 0; // ถ้าไม่มีกำหนดค่าเป็น 0
            const numinjur = accident.numinjur || 0; // ถ้าไม่มีกำหนดค่าเป็น 0

            if (aggregatedData[accident.acclocation]) {
              aggregatedData[accident.acclocation].numdeath += numdeath;
              aggregatedData[accident.acclocation].numinjur += numinjur;
            } else {
              aggregatedData[accident.acclocation] = {
                numdeath: numdeath,
                numinjur: numinjur,
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

          this.accidentChartData.labels = labels;
          this.accidentChartData.datasets[0].data = deathData;
          this.accidentChartData.datasets[1].data = injuryData;
        })
        .catch((error) => {
          console.error("Error fetching accident data:", error);
        });
    },

    fetchCrimeData() {
      axios
        .get("http://localhost:3000/api/crimedata/")
        .then((response) => {
          const crimes = response.data.data;

          const aggregatedData = {};

          crimes.forEach((crime) => {
            // ตรวจสอบว่า `numdeath` และ `numinjur` มีค่าหรือไม่
            const numdeath = crime.numdeath || 0; // ถ้าไม่มีกำหนดค่าเป็น 0
            const numinjur = crime.numinjur || 0; // ถ้าไม่มีกำหนดค่าเป็น 0

            if (aggregatedData[crime.crimelocation]) {
              aggregatedData[crime.crimelocation].numdeath += numdeath;
              aggregatedData[crime.crimelocation].numinjur += numinjur;
            } else {
              aggregatedData[crime.crimelocation] = {
                numdeath: numdeath,
                numinjur: numinjur,
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

          this.crimeChartData.labels = labels;
          this.crimeChartData.datasets[0].data = deathData;
          this.crimeChartData.datasets[1].data = injuryData;
        })
        .catch((error) => {
          console.error("Error fetching accident data:", error);
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
