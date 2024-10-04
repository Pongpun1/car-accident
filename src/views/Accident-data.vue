<template>
  <div class="main-container">
    <div class="NavBar">
      <NavTopBar />
    </div>

    <div class="controls-container">
      <div class="left-controls">
        <b-button
          @click="addData"
          size="sm"
          variant="secondary"
          class="add-button"
        >
          เพิ่มข้อมูล
          <b-icon icon="plus-circle-fill"></b-icon>
        </b-button>
        <b-button
          v-if="selectedItems.length > 0"
          @click="deleteSelected"
          variant="danger"
          class="deleteAll"
        >
          ลบ {{ selectedItems.length }} รายการ
          <b-icon icon="trash" aria-hidden="true"></b-icon>
        </b-button>
      </div>

      <div class="right-controls">
        <b-button title="Export file" @click="exportToExcel" variant="warning">
          Export
          <b-icon icon="cloud-download" aria-hidden="true"></b-icon>
        </b-button>

        <b-button title="Import file" @click="triggerFileUpload" variant="info">
          Import
          <b-icon icon="cloud-upload" aria-hidden="true"></b-icon>
        </b-button>
        <input
          type="file"
          ref="fileInput"
          @change="onFileChange"
          class="file-input"
          style="display: none"
        />

        <span v-if="fileName" class="filename">{{ fileName }}</span>

        <b-button
          v-if="isFileLoaded"
          @click="uploadToServer"
          size="sm"
          variant="primary"
          class="save-data"
        >
          อัปโหลด
          <b-icon icon="upload"></b-icon>
        </b-button>
      </div>
    </div>

    <div class="table-container">
      <table class="table w-full">
        <thead>
          <tr>
            <th>
              <input
                type="checkbox"
                @change="toggleSelectAll"
                :checked="isAllSelected"
              />
            </th>
            <th>ลำดับ</th>
            <th>สถานที่เกิดเหตุ</th>
            <th>ละติจูด</th>
            <th>ลองจิจูด</th>
            <th @click="sortData('numinjur')">จำนวนผู้บาดเจ็บ</th>
            <th @click="sortData('numdeath')">จำนวนผู้เสียชีวิต</th>
            <th>วันเกิดเหตุ</th>
            <th>จัดการ</th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="(item, index) in paginatedData" :key="index">
            <td>
              <input type="checkbox" v-model="selectedItems" :value="item.id" />
            </td>
            <td>{{ (currentPage - 1) * rowsPerPage + index + 1 }}</td>
            <td>{{ item.acclocation }}</td>
            <td>{{ item.latitude }}</td>
            <td>{{ item.longitude }}</td>
            <td>{{ item.numinjur }}</td>
            <td>{{ item.numdeath }}</td>
            <td>{{ formatDate(item.accdate) }}</td>
            <td>
              <div class="btn-container">
                <button
                  @click="editData(item.id)"
                  class="btn btn-primary btn-sm mx-2"
                >
                  <b-icon icon="pencil-square" font-scale="1.5"></b-icon>
                </button>
                <button
                  @click="deleteData(item.id)"
                  class="btn btn-danger btn-sm mx-2"
                >
                  <b-icon icon="trash" font-scale="1.5"></b-icon>
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
  </div>
</template>

<script>
import NavTopBar from "../components/nav-bar.vue";
import * as XLSX from "xlsx";
import axios from "axios";
import { format } from "date-fns";
import { th } from "date-fns/locale";

export default {
  components: {
    NavTopBar,
  },

  data() {
    return {
      currentPage: 1,
      rowsPerPage: 14,
      excelData: [],
      selectedItems: [],
      isUploading: false,
      isFileLoaded: false,
      sortKey: "",
      sortOrder: "asc",
      fileName: "",
    };
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

    isAllSelected() {
      return this.selectedItems.length === this.excelData.length;
    },
  },

  methods: {
    fetchData() {
      axios
        .get("http://localhost:3000/api/data")
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
        this.fileName = "";
        return;
      }

      this.isFileLoaded = true;
      this.fileName = file.name;

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
        alert("กรุณาอัปโหลดไฟล์");
        return;
      }

      if (this.excelData.length === 0) {
        alert("ไม่มีข้อมูลในไฟล์ที่จะอัปโหลด");
        this.fetchData();
        return;
      }
      axios
        .post("http://localhost:3000/api/data", this.excelData, {
          withCredentials: true,
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then(() => {
          alert(`อัปโหลดข้อมูลเสร็จสิ้น`);
          this.fetchData();
          this.clearFileInput();
          this.fileName = "";
        })
        .catch((error) => {
          console.error("There was an error uploading the data!", error);
        });
    },

    clearFileInput() {
      this.$refs.fileInput.value = null;
      this.isFileLoaded = false;
    },

    exportToExcel() {
      const worksheet = XLSX.utils.json_to_sheet(this.excelData);
      const workbook = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(workbook, worksheet, "Data");

      XLSX.writeFile(workbook, "data.xlsx");
    },

    deleteData(id) {
      if (confirm("คุณต้องการลบข้อมูลนี้จริงหรือไม่?")) {
        axios
          .delete(`http://localhost:3000/api/data/${id}`)
          .then(() => {
            this.fetchData();
          })
          .catch((error) => {
            console.error("There was an error deleting the data!", error);
          });
      }
    },

    deleteSelected() {
      if (
        confirm(
          `คุณต้องการลบ ${this.selectedItems.length} รายการนี้จริงหรือไม่?`
        )
      ) {
        const deletePromises = this.selectedItems.map((id) =>
          axios.delete(`http://localhost:3000/api/data/${id}`)
        );

        Promise.all(deletePromises)
          .then(() => {
            this.fetchData();
            this.selectedItems = [];
          })
          .catch((error) => {
            console.error("There was an error deleting the data!", error);
          });
      }
    },

    editData(id) {
      this.$router.push(`/data/edit/${id}`);
    },

    addData() {
      this.$router.push("/data/add");
    },

    formatDate(date) {
      return format(new Date(date), "d MMMM yyyy", { locale: th });
    },

    triggerFileUpload() {
      this.$refs.fileInput.click();
    },

    sortData(key) {
      this.sortKey = key;
      this.sortOrder = this.sortOrder === "asc" ? "desc" : "asc";
      this.excelData.sort((a, b) => {
        if (this.sortOrder === "asc") {
          return a[key] > b[key] ? 1 : -1;
        } else {
          return a[key] < b[key] ? 1 : -1;
        }
      });
    },

    toggleSelectAll(event) {
      if (event.target.checked) {
        this.selectedItems = this.excelData.map((item) => item.id);
      } else {
        this.selectedItems = [];
      }
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
  margin-top: 10px;
  width: 100%;
  max-width: 1200px;
}

.table {
  width: 100%;
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

.controls-container {
  display: flex;
  justify-content: space-between;
  width: 100%;
  max-width: 1200px;
  margin-top: 10px;
  padding: 0 15px;
  box-sizing: border-box;
}

.left-controls {
  display: flex;
  align-items: center;
}

.right-controls {
  display: flex;
  gap: 10px;
  align-items: center;
  justify-content: space-between;
}

.file-input {
  width: 250px;
}

.filename {
  flex-grow: 1;
  text-align: center;
  font-size: 14px;
  color: #333;
}

.save-data {
  font-size: 0.8rem;
  width: 90px;
  height: 30px;
  top: 30px;
  z-index: 1000;
}

.add-button {
  font-size: 1rem;
  width: 130px;
  height: 30px;
  padding-bottom: 25px;
}

.deleteAll {
  margin-left: 10px;
  font-size: 1rem;
  width: 150px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.pagination-controls {
  margin-top: 8px;
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

@media (max-width: 768px) {
  .controls-container {
    flex-direction: column;
    align-items: center;
  }
  .left-controls,
  .right-controls {
    width: 100%;
    justify-content: space-around;
  }
  .file-input,
  .add-button,
  .save-data {
    width: 100%;
    margin-bottom: 10px;
  }
}
</style>
