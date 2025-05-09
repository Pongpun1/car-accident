<template>
  <div>
    <div class="NavBar">
      <NavTopBar />
    </div>

    <div class="chart-container">
      <div class="charts">
        <BarChart />
        <PieChart />
      </div>
    </div>

    <div class="statistics-container">
      <div class="stat-box red-box">
        <h3>{{ $t("maleCrimePercent") }}</h3>
        <img src="../assets/man.png" class="logo1" alt="man" />
        <span>{{ malePercentage }}%</span>
      </div>
      <div class="stat-box orange-box">
        <h3>{{ $t("femaleCrimePercent") }}</h3>
        <img src="../assets/woman.png" class="logo1" alt="woman" />
        <span>{{ femalePercentage }}%</span>
      </div>
      <div class="stat-box blue-box">
        <h3>{{ $t("totalDeath") }}</h3>
        <img src="../assets/risk-skull.png" class="logo1" alt="risk-skull" />
        <span>{{ $t("total", { count: totalDeaths2024 }) }}</span>
      </div>
      <div class="stat-box green-box">
        <h3>{{ $t("totalInjured") }}</h3>
        <img src="../assets/injury.png" class="logo1" alt="injury" />
        <span>{{ $t("total", { count: totalInjuries2024 }) }}</span>
      </div>
    </div>
  </div>
</template>

<script>
import NavTopBar from "../components/TopNavBar.vue";
import BarChart from "../components/CrimeBarChart.vue";
import PieChart from "../components/CrimePieChart.vue";
import axios from "axios";
import { API_URL } from "../config"; // Import API_URL

export default {
  components: {
    NavTopBar,
    PieChart,
    BarChart,
  },
  data() {
    return {
      deathMean: 0,
      deathMax: 0,
      injuryMean: 0,
      injuryMax: 0,
      totalDeaths2024: 0,
      totalInjuries2024: 0,
      maleCount: 0,
      femaleCount: 0,
      malePercentage: 0,
      femalePercentage: 0,
      totalCrimes2024: 0,
      mostFrequentGender: "",
    };
  },
  mounted() {
    this.fetchStatistics();
  },
  methods: {
    fetchStatistics() {
      axios
        .get(`${API_URL}/api/crimedata/`)
        .then((response) => {
          const crimes = response.data.data;
          const crimes2024 = crimes.filter((crime) => {
            const crimeYear = new Date(crime.crimedate).getFullYear();
            return crimeYear === 2024;
          });

          let maleInjuries = 0,
            femaleInjuries = 0;
          let maleDeaths = 0,
            femaleDeaths = 0;

          const regex1 =
            /(ผู้ชาย|ชาย|เพศชาย|เด็กผู้ชาย|เด็กชาย|หนุ่ม|ผู้หญิง|เพศหญิง|เด็กผู้หญิง|เด็กหญิง|หญิง|สาว)(?:.*?)(ผู้เสียชีวิต|เสียชีวิต|ตาย|ดับ|ผู้บาดเจ็บ|บาดเจ็บ|เจ็บ|ได้รับบาดเจ็บ|สาหัส)(?:.*?)(\d+)/g;
          const regex2 =
            /(ผู้เสียชีวิต|เสียชีวิต|ตาย|ดับ|ผู้บาดเจ็บ|บาดเจ็บ|เจ็บ|ได้รับบาดเจ็บ|สาหัส)(?:.*?)(ผู้ชาย|ชาย|เพศชาย|เด็กผู้ชาย|เด็กชาย|หนุ่ม|ผู้หญิง|เพศหญิง|เด็กผู้หญิง|เด็กหญิง|หญิง|สาว)(?:.*?)(\d+)/g;

          crimes2024.forEach((crime) => {
            const crimeInfo = crime.crimeinfo.toLowerCase();
            let match;

            while ((match = regex1.exec(crimeInfo)) !== null) {
              processMatch(match);
            }

            while ((match = regex2.exec(crimeInfo)) !== null) {
              processMatch([match[0], match[2], match[1], match[3]]);
            }
          });

          function processMatch(match) {
            const gender = match[1];
            const event = match[2];
            const count = parseInt(match[3]);

            if (gender.includes("ชาย")) {
              if (
                ["ผู้เสียชีวิต", "เสียชีวิต", "ตาย", "ดับ"].some((e) =>
                  event.includes(e)
                )
              ) {
                maleDeaths += count;
              } else if (
                [
                  "ผู้บาดเจ็บ",
                  "บาดเจ็บ",
                  "เจ็บ",
                  "ได้รับบาดเจ็บ",
                  "สาหัส",
                ].some((e) => event.includes(e))
              ) {
                maleInjuries += count;
              }
            } else if (gender.includes("หญิง") || gender.includes("สาว")) {
              if (
                ["ผู้เสียชีวิต", "เสียชีวิต", "ตาย", "ดับ"].some((e) =>
                  event.includes(e)
                )
              ) {
                femaleDeaths += count;
              } else if (
                [
                  "ผู้บาดเจ็บ",
                  "บาดเจ็บ",
                  "เจ็บ",
                  "ได้รับบาดเจ็บ",
                  "สาหัส",
                ].some((e) => event.includes(e))
              ) {
                femaleInjuries += count;
              }
            }
          }

          this.totalDeaths2024 = maleDeaths + femaleDeaths;
          this.totalInjuries2024 = maleInjuries + femaleInjuries;

          const total = this.totalInjuries2024 + this.totalDeaths2024;
          if (total > 0) {
            this.malePercentage = (
              ((maleInjuries + maleDeaths) / total) *
              100
            ).toFixed(2);
            this.femalePercentage = (
              ((femaleInjuries + femaleDeaths) / total) *
              100
            ).toFixed(2);
          }

          this.maleCount = maleInjuries + maleDeaths;
          this.femaleCount = femaleInjuries + femaleDeaths;
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
        });
    },
  },
};
</script>

<style>
.chart-container {
  background-color: #ffffff;
  margin: 0 180px 0 180px;
  border-radius: 20px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.charts {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 60vh;
}

.charts > div {
  flex: 1;
  max-width: 600px;
  margin: 0 5px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.statistics-container {
  display: flex;
  justify-content: space-around;
  align-items: center;
  margin: 20px 180px;
}

.stat-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: #ffffff;
  padding: 20px;
  border-radius: 15px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  flex: 1;
  margin: 0 10px;
  font-size: 1.2rem;
  background-size: 200% 200%;
}

.logo1 {
  width: 100px;
  height: auto;
  margin: 10px;
}

.stat-box h3 {
  margin: 0;
  font-size: 1.5rem;
  font-weight: bold;
  color: #141414;
  text-align: center;
  width: 100%;
}

.stat-box span {
  font-size: 1.7rem;
  font-weight: bold;
  color: #141414;
}

.red-box {
  background: linear-gradient(to right, #ff9999, #ff2525);
  transition: background-position 0.6s ease, transform 0.4s ease;
  background-size: 200% 100%;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.red-box:hover {
  background-position: left center;
  transform: scale(1.05);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.orange-box {
  background: linear-gradient(to right, #ffd28f, #ffa114);
  transition: background-position 0.6s ease, transform 0.4s ease;
  background-size: 200% 100%;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.orange-box:hover {
  background-position: left center;
  transform: scale(1.05);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.blue-box {
  background: linear-gradient(to right, #a0c5fc, #3b89ff);
  transition: background-position 0.6s ease, transform 0.4s ease;
  background-size: 200% 100%;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.blue-box:hover {
  background-position: left center;
  transform: scale(1.05);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.green-box {
  background: linear-gradient(to right, #b3e6b3, #4ed04e);
  transition: background-position 0.6s ease, transform 0.4s ease;
  background-size: 200% 100%;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.green-box:hover {
  background-position: left center;
  transform: scale(1.05);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}
</style>
