<template>
    <div>
      <p style="text-align: center; font-weight: bold;">{{ $t("staticCrime") }}</p>
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
      this.fetchcrimeData();
    },
    methods: {
      fetchcrimeData() {
    axios
      .get("http://localhost:3000/api/crimedata/")
      .then((response) => {
        const crimes = response.data.data;
  
        const aggregatedData = {};
  
        crimes.forEach((crime) => {
          const numdeath = crime.numdeath || 0;
          const numinjur = crime.numinjur || 0;
  
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
  
        const sortedData = Object.entries(aggregatedData).sort(
          (a, b) => (b[1].numdeath + b[1].numinjur) - (a[1].numdeath + a[1].numinjur)
        );
  
        const top4 = sortedData.slice(0, 4); // 4 อันดับแรก
        const others = sortedData.slice(4); // ข้อมูลที่เหลือ
  
        // รวมข้อมูลของ "พื้นที่อื่นๆ"
        const othersData = others.reduce(
          (crime, data) => {
            crime.numdeath += data[1].numdeath;
            crime.numinjur += data[1].numinjur;
            return crime;
          },
          { numdeath: 0, numinjur: 0 }
        );
  
        // สร้าง Labels และ Data
        const labels = [...top4.map(([location]) => location), "พื้นที่อื่นๆ"];
        const deathData = [
          ...top4.map((data) => data[1].numdeath),
          othersData.numdeath,
        ];
        const injuryData = [
          ...top4.map((data) => data[1].numinjur),
          othersData.numinjur,
        ];
  
        this.crimeChartData.labels = labels;
        this.crimeChartData.datasets[0].data = deathData;
        this.crimeChartData.datasets[1].data = injuryData;
      })
      .catch((error) => {
        console.error("Error fetching crime data:", error);
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
  