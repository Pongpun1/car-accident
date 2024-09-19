<template>
  <div class="main-container">
    <div class="NavBar">
      <NavTopBar />
    </div>
    <div class="table-container">
      <table class="table w-full">
        <!-- head -->
        <thead>
          <tr>
            <th>ลำดับ</th>
            <th>สถานที่เกิดเหตุ</th>
            <th>ละติจูด</th>
            <th>ลองจิจูด</th>
            <th>จำนวนผู้บาดเจ็บ</th>
            <th>จำนวนผู้เสียชีวิต</th>
            <th>วันและเวลาเกิดเหตุ</th>
            <th>จัดการ</th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="(item, index) in paginatedData" :key="index">
            <td>{{ (currentPage - 1) * rowsPerPage + index + 1 }}</td>
            <td>{{ item.acclocation }}</td>
            <td>{{ item.latitude }}</td>
            <td>{{ item.longitude }}</td>
            <td>{{ item.numinjur }}</td>
            <td>{{ item.numdeath }}</td>
            <td>{{ item.accdate }}</td>
            <td>
              <div class="btn-container">
                <button
                  @click="editData(item.id)"
                  class="btn btn-primary btn-sm mx-2"
                >
                  แก้ไข
                </button>
                <button
                  @click="deleteData(item.id)"
                  class="btn btn-danger btn-sm mx-2"
                >
                  ลบ
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="pagination-controls">
      <b-pagination
        v-model="currentPage"
        :total-rows="totalRows"
        :per-page="rowsPerPage"
        first-number
        last-number
        pills
      ></b-pagination>
    </div>

    <div class="file-upload-container">
      <b-form-file @change="onFileChange" class="file-input" />
    </div>
    <b-button
      @click="uploadToServer"
      size="sm"
      variant="secondary"
      class="save-data"
    >
      บันทึกข้อมูล
    </b-button>
  </div>
</template>

<script>
import NavTopBar from "../components/nav-bar.vue";
import * as XLSX from "xlsx";
import axios from "axios";

export default {
  components: {
    NavTopBar,
  },

  data() {
    return {
      currentPage: 1,
      rowsPerPage: 14,
      excelData: [],
      isUploading: false,
      isFileLoaded: false,
    };
  },

  methods: {
    fetchData() {
      axios
        .get("http://localhost:8080/api/data")
        .then((response) => {
          this.excelData = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching data from API:", error);
        });
    },

    onFileChange(event) {
      const file = event.target.files[0];
      if (!file) {
        this.excelData = [];
        this.isFileLoaded = false;
        return;
      }

      this.isFileLoaded = true;

      const reader = new FileReader();

      reader.onload = (e) => {
        const data = new Uint8Array(e.target.result);
        const workbook = XLSX.read(data, { type: "array", cellDates: true });
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const jsonData = XLSX.utils.sheet_to_json(worksheet);
        this.excelData = jsonData;
      };

      reader.readAsArrayBuffer(file);
    },

    uploadToServer() {
      if (!this.isFileLoaded) {
        alert("ไฟล์ยังไม่ถูกอัปโหลด");
        return;
      }

      if (this.excelData.length === 0) {
        alert("ไม่มีข้อมูลในไฟล์ที่จะอัปโหลด");
        return;
      }
      axios
        .post("http://localhost:8080/api/data", this.excelData, {
          withCredentials: true,
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((response) => {
          alert(`อัปโหลดข้อมูลเสร็จสิ้น: ${response}`);
          window.location.reload();
          this.isUploading = false;
        })
        .catch((error) => {
          console.error("There was an error uploading the data!", error);
          this.isUploading = false;
        });
    },

    deleteData(id) {
      if (confirm("คุณต้องการลบข้อมูลนี้จริงหรือไม่?")) {
        axios
          .delete(`http://localhost:8080/api/data/${id}`)
          .then(() => {
            alert("ลบข้อมูลเสร็จสิ้น");
            this.fetchData();
          })
          .catch((error) => {
            console.error("There was an error deleting the data!", error);
          });
      }
    },

    editData(id) {
      this.$router.push(`/data/edit/${id}`);
    },
  },

  computed: {
    paginatedData() {
      const start = (this.currentPage - 1) * this.rowsPerPage;
      const end = start + this.rowsPerPage;
      return this.excelData.slice(start, end);
    },
    totalRows() {
      return this.excelData.length;
    },
  },

  mounted() {
    this.fetchData();
  },
};
</script>

<style>
body {
  background-color: #f9efdf;
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
}

.main-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 70px;
  width: 100vw;
  height: 100vh;
  box-sizing: border-box;
}

.NavBar {
  width: 100%;
}

.table-container {
  width: 100%;
  height: 90%;
  margin-top: 15px;
  max-width: 1200px;
  padding-left: 15px;
  padding-right: 15px;
  box-sizing: border-box;
  display: flex;
  justify-content: center;
}

.table {
  width: 100%;
  border-collapse: collapse;
  text-align: center;
}

.table th,
.table td {
  padding: 8px;
}

.table td {
  text-align: center;
  vertical-align: middle;
}

.table .btn-container {
  display: flex;
  justify-content: center;
}

.table th {
  background-color: #f2f2f2;
}

.file-upload-container {
  position: fixed;
  bottom: 30px;
  right: 470px;
}

.file-input {
  width: 250px;
  font-size: 0.8rem;
}

.save-data {
  position: fixed;
  bottom: 30px;
  right: 370px;
}

.pagination-controls {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  gap: 10px;
}

.pagination-controls button {
  padding: 5px 10px;
  font-size: 0.9rem;
}

.pagination-controls span {
  font-size: 0.9rem;
}
</style>
