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
          <strong>เพิ่ม</strong>
          <b-icon icon="plus-lg" class="ml-1" font-scale="1.2"></b-icon>
        </b-button>

        <b-button @click="refreshData" class="refresh-btn-hover">
          <b-icon icon="arrow-clockwise" font-scale="1.4"></b-icon>
        </b-button>

        <b-input-group style="width: 400px">
          <b-input-group-prepend is-text>
            <b-icon icon="search"></b-icon>
          </b-input-group-prepend>
          <b-form-input
            id="filter-input"
            v-model="filter"
            type="search"
            placeholder="ค้นหา"
            @input="handleFilterInput"
            style="border-radius: 0px 20px 20px 0px"
          ></b-form-input>
        </b-input-group>

        <b-form-datepicker
          v-model="selectedDate"
          locale="th"
          placeholder="เลือกวันที่เกิดเหตุ"
          reset-button
          today-button
          reset-value=""
          class="ml-2"
           style="width: 330px; border-radius: 20px 20px 20px 20px;"
        ></b-form-datepicker>


        <b-button
          v-if="selectedItemCount > 0"
          @click="deleteSelected"
          variant="danger"
          class="deleteAll"
        >
          <strong> ลบ {{ selectedItemCount }} รายการ </strong>
        </b-button>
      </div>

      <div class="right-controls">
        <b-button
          title="Import file"
          @click="triggerFileUpload"
          variant="info"
          class="import-btn"
        >
          <strong>Import</strong>
          <b-icon icon="cloud-upload" aria-hidden="true" class="ml-1"></b-icon>
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
          <strong>อัปโหลด</strong>
          <b-icon icon="upload" class="ml-1"></b-icon>
        </b-button>

        <b-button
          title="Export file"
          @click="exportToExcel"
          variant="warning"
          class="export-btn"
        >
          <strong>Export</strong>
          <b-icon
            icon="cloud-download"
            aria-hidden="true"
            class="ml-1"
          ></b-icon>
        </b-button>
      </div>
    </div>

    <div class="table-container">
      <b-skeleton-table
        v-if="isLoading"
        :rows="19"
        :columns="9"
        animation="Fade"
      ></b-skeleton-table>

      <table v-else class="table">
        <b-tabs
          pills
          vertical
          nav-class="vertical-tabs"
          card
          nav-wrapper-class="h-50"
          v-model="activeTab"
        >
          <b-tab ref="accidentTab" title="อุบัติเหตุ">
            <thead>
              <tr>
                <th>
                  <input
                    type="checkbox"
                    @change="toggleSelectAllAccident"
                    :checked="isAllAccidentSelected"
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
              <tr v-for="(item, index) in paginatedAccidentData" :key="index">
                <td>
                  <input
                    type="checkbox"
                    v-model="selectedAccidentItems"
                    :value="item.id"
                  />
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
                      @click="showInfoModal(item)"
                      class="btn btn-info btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="info-circle" font-scale="1.5"></b-icon>
                    </button>
                    <button
                      @click="editAccidentData(item.id)"
                      class="btn btn-primary btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="pencil-square" font-scale="1.5"></b-icon>
                    </button>
                    <button
                      @click="deleteData(item.id)"
                      class="btn btn-danger btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="trash" font-scale="1.5"></b-icon>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </b-tab>

          <b-tab ref="crimeTab" title="อาชญากรรม">
            <thead>
              <tr>
                <th>
                  <input
                    type="checkbox"
                    @change="toggleSelectAllCrime"
                    :checked="isAllCrimeSelected"
                  />
                </th>
                <th>ลำดับ</th>
                <th>สถานที่เกิดเหตุ</th>
                <th>ละติจูด</th>
                <th>ลองจิจูด</th>
                <th>จำนวนผู้บาดเจ็บ</th>
                <th>จำนวนผู้เสียชีวิต</th>
                <th>วันเกิดเหตุ</th>
                <th>จัดการ</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in paginatedCrimeData" :key="index">
                <td>
                  <input
                    type="checkbox"
                    v-model="selectedCrimeItems"
                    :value="item.id"
                  />
                </td>
                <td>{{ (currentPage - 1) * rowsPerPage + index + 1 }}</td>
                <td>{{ item.crimelocation }}</td>
                <td>{{ item.latitude }}</td>
                <td>{{ item.longitude }}</td>
                <td>{{ item.numinjur }}</td>
                <td>{{ item.numdeath }}</td>
                <td>{{ formatDate(item.crimedate) }}</td>
                <td>
                  <div class="btn-container">
                    <button
                      @click="showInfoModal(item)"
                      class="btn btn-info btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="info-circle" font-scale="1.5"></b-icon>
                    </button>
                    <button
                      @click="editCrimeData(item.id)"
                      class="btn btn-primary btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="pencil-square" font-scale="1.5"></b-icon>
                    </button>
                    <button
                      @click="deleteCrimeData(item.id)"
                      class="btn btn-danger btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="trash" font-scale="1.5"></b-icon>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </b-tab>

          <b-tab ref="undefinedTab" title="ไม่ระบุรายละเอียด">
            <thead>
              <tr>
                <th>
                  <input
                    type="checkbox"
                    @change="toggleSelectAllUnspecified"
                    :checked="isAllUnspecifiedSelected"
                  />
                </th>
                <th>ลำดับ</th>
                <th>สถานที่เกิดเหตุ</th>
                <th>ละติจูด</th>
                <th>ลองจิจูด</th>
                <th>จำนวนผู้บาดเจ็บ</th>
                <th>จำนวนผู้เสียชีวิต</th>
                <th>วันเกิดเหตุ</th>
                <th>จัดการ</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(item, index) in paginatedUnspecifiedData"
                :key="index"
              >
                <td>
                  <input
                    type="checkbox"
                    v-model="selectedUnspecifiedItems"
                    :value="item.id"
                  />
                </td>
                <td>{{ (currentPage - 1) * rowsPerPage + index + 1 }}</td>
                <td>{{ item.location }}</td>
                <td>{{ item.latitude }}</td>
                <td>{{ item.longitude }}</td>
                <td>{{ item.numinjur }}</td>
                <td>{{ item.numdeath }}</td>
                <td>{{ formatDate(item.date) }}</td>
                <td>
                  <div class="btn-container">
                    <button
                      @click="showInfoModal(item)"
                      class="btn btn-info btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="info-circle" font-scale="1.5"></b-icon>
                    </button>
                    <button
                      @click="editUnspecifiedData(item.id)"
                      class="btn btn-primary btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="pencil-square" font-scale="1.5"></b-icon>
                    </button>
                    <button
                      @click="deleteUnspecifiedData(item.id)"
                      class="btn btn-danger btn-sm mx-1 btn-hover"
                    >
                      <b-icon icon="trash" font-scale="1.5"></b-icon>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </b-tab>

          <b-tab ref="crimeTab" title="รออนุมัติ">
            <thead>
              <tr>
                <th>
                  <input type="checkbox" />
                </th>
                <th>ลำดับ</th>
                <th>สถานที่เกิดเหตุ</th>
                <th>ละติจูด</th>
                <th>ลองจิจูด</th>
                <th>จำนวนผู้บาดเจ็บ</th>
                <th>จำนวนผู้เสียชีวิต</th>
                <th>วันเกิดเหตุ</th>
                <th>จัดการ</th>
              </tr>
            </thead>
            <tbody></tbody>
          </b-tab>
        </b-tabs>
      </table>
    </div>

    <b-modal
      scrollable
      hide-footer
      v-model="isInfoModalVisible"
      title="รายละเอียดเหตุการณ์"
      class="InfoModal"
    >
      <p>
        <strong>สถานที่เกิดเหตุ:</strong>
        {{
          selectedItem.acclocation ||
          selectedItem.crimelocation ||
          selectedItem.location
        }}
      </p>
      <p><strong>ละติจูด:</strong> {{ selectedItem.latitude }}</p>
      <p><strong>ลองจิจูด:</strong> {{ selectedItem.longitude }}</p>
      <p><strong>จำนวนผู้บาดเจ็บ:</strong> {{ selectedItem.numinjur }} คน</p>
      <p>
        <strong>จำนวนผู้เสียชีวิต:</strong>
        {{ selectedItem.numdeath }} คน
      </p>
      <p>
        <strong>วันเกิดเหตุ:</strong>
        {{
          selectedItem.accdate
            ? formatDate(selectedItem.accdate)
            : selectedItem.crimedate
            ? formatDate(selectedItem.crimedate)
            : selectedItem.date
            ? formatDate(selectedItem.date)
            : "ไม่ทราบวันที่"
        }}
      </p>
      <p>
        <strong>รายละเอียด: </strong
        ><span>{{
          selectedItem.accinfo ||
          selectedItem.crimeinfo ||
          selectedItem.info ||
          "ไม่ระบุ"
        }}</span>
      </p>
    </b-modal>

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
import NavTopBar from "../components/TopNavBar.vue";
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
      rowsPerPage: 10,
      activeTab: 0,
      isUploading: false,
      isFileLoaded: false,
      isInfoModalVisible: false,
      selectedItemIndex: null,
      isLoading: true,
      sortOrder: "asc",
      filter: "",
      sortKey: "",
      fileName: "",
      selectedDate: "",
      accidentData: [],
      crimeData: [],
      UnspecifiedData: [],
      selectedAccidentItems: [],
      selectedCrimeItems: [],
      selectedUnspecifiedItems: [],
      selectedItem: {},
    };
  },

  computed: {
    paginatedAccidentData() {
      const start = (this.currentPage - 1) * this.rowsPerPage;
      const end = start + this.rowsPerPage;
      return this.filterAccidentData.slice(start, end);
    },

    paginatedCrimeData() {
      const start = (this.currentPage - 1) * this.rowsPerPage;
      const end = start + this.rowsPerPage;
      return this.filterCrimeData.slice(start, end);
    },

    paginatedUnspecifiedData() {
      const start = (this.currentPage - 1) * this.rowsPerPage;
      const end = start + this.rowsPerPage;
      return this.filterUnspecifiedData.slice(start, end);
    },

    totalRows() {
      if (this.activeTab === 0) {
        return this.filterAccidentData.length;
      } else if (this.activeTab === 1) {
        return this.filterCrimeData.length;
      } else {
        return this.filterUnspecifiedData.length;
      }
    },

    isAllAccidentSelected() {
      return this.selectedAccidentItems.length === this.accidentData.length;
    },
    isAllCrimeSelected() {
      return this.selectedCrimeItems.length === this.crimeData.length;
    },
    isAllUnspecifiedSelected() {
      return (
        this.selectedUnspecifiedItems.length === this.UnspecifiedData.length
      );
    },

    selectedItemCount() {
      return this.activeTab === 0
        ? this.selectedAccidentItems.length
        : this.activeTab === 1
        ? this.selectedCrimeItems.length
        : this.activeTab === 2
        ? this.selectedUnspecifiedItems.length
        : 0;
    },

    filterAccidentData() {
      return this.accidentData.filter((item) => {
        const formattedDate = this.formatDate(item.accdate);

        const matchesFilter =
          !this.filter ||
          item.acclocation.toLowerCase().includes(this.filter.toLowerCase()) ||
          item.latitude.toString().includes(this.filter) ||
          item.longitude.toString().includes(this.filter) ||
          item.numinjur.toString().includes(this.filter) ||
          item.numdeath.toString().includes(this.filter) ||
          formattedDate.includes(this.filter);

        const matchesDate =
          !this.selectedDate ||
          formattedDate === this.formatDate(this.selectedDate);

        return matchesFilter && matchesDate;
      });
    },

    filterCrimeData() {
      return this.crimeData.filter((item) => {
        const formattedDate = this.formatDate(item.crimedate);

        const matchesFilter =
          !this.filter ||
          item.crimelocation
            .toLowerCase()
            .includes(this.filter.toLowerCase()) ||
          item.latitude.toString().includes(this.filter) ||
          item.longitude.toString().includes(this.filter) ||
          item.numinjur.toString().includes(this.filter) ||
          item.numdeath.toString().includes(this.filter) ||
          formattedDate.includes(this.filter);

        const matchesDate =
          !this.selectedDate ||
          formattedDate === this.formatDate(this.selectedDate);

        return matchesFilter && matchesDate;
      });
    },

    filterUnspecifiedData() {
      return this.UnspecifiedData.filter((item) => {
        const formattedDate = this.formatDate(item.date);
        const matchesFilter =
          !this.filter ||
          item.location.toLowerCase().includes(this.filter.toLowerCase()) ||
          item.latitude.toString().includes(this.filter) ||
          item.longitude.toString().includes(this.filter) ||
          item.numinjur.toString().includes(this.filter) ||
          item.numdeath.toString().includes(this.filter) ||
          formattedDate.includes(this.filter);

        const matchesDate =
          !this.selectedDate ||
          formattedDate === this.formatDate(this.selectedDate);

        return matchesFilter && matchesDate;
      });
    },
  },

  methods: {
    showInfoModal(item) {
      if (this.activeTab === 0) {
        this.selectedItem = item;
        this.selectedItemIndex = this.accidentData.indexOf(item) + 1;
      } else if (this.activeTab === 1) {
        this.selectedItem = item;
        this.selectedItemIndex = this.crimeData.indexOf(item) + 1;
      } else if (this.activeTab === 2) {
        this.selectedItem = item;
        this.selectedItemIndex = this.UnspecifiedData.indexOf(item) + 1;
      }
      this.isInfoModalVisible = true;
    },
    // --------------------------------- ดูข้อมูล --------------------------------
    fetchAccidentData() {
      this.isLoading = true;
      axios
        .get("http://localhost:3000/api/accidentdata")
        .then((response) => {
          this.accidentData = response.data.data;
          this.isLoading = false;
        })
        .catch((error) => {
          console.error("Error fetching data from API:", error);
          this.isLoading = false;
        });
    },

    fetchCrimeData() {
      this.isLoading = true;
      axios
        .get("http://localhost:3000/api/crimedata")
        .then((response) => {
          this.crimeData = response.data.data;
          this.isLoading = false;
        })
        .catch((error) => {
          console.error("Error fetching Crime Data:", error);
          this.isLoading = false;
        });
    },

    fetchUnspecifiedData() {
      this.isLoading = true;
      axios
        .get("http://localhost:3000/api/Unspecifieddata")
        .then((response) => {
          this.UnspecifiedData = response.data.data;
          this.isLoading = false;
        })
        .catch((error) => {
          console.error("Error fetching Unspecified Data:", error);
          this.isLoading = false;
        });
    },
    // --------------------------------- เพิ่มข้อมูล --------------------------------
    onFileChange(event) {
      const file = event.target.files[0];
      if (!file) {
        this.accidentData = [];
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
        this.accidentData = jsonData;
      };

      reader.readAsArrayBuffer(file);
    },

    uploadToServer() {
      if (!this.isFileLoaded) {
        alert("กรุณาอัปโหลดไฟล์");
        return;
      }

      if (this.accidentData.length === 0) {
        alert("ไม่มีข้อมูลในไฟล์ที่จะอัปโหลด");
        this.fetchAccidentData();
        return;
      }
      axios
        .post("http://localhost:3000/api/accidentdata", this.accidentData, {
          withCredentials: true,
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then(() => {
          alert("อัปโหลดข้อมูลเสร็จสิ้น");
          this.fetchAccidentData();
          this.fetchCrimeData();
          this.fetchUnspecifiedData();
          this.clearFileInput();
          this.fileName = "";
        })
        .catch((error) => {
          console.error("There was an error uploading the data!", error);
        });

      axios
        .post("http://localhost:3000/api/crimedata", this.accidentData, {
          withCredentials: true,
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then(() => {
          this.fetchCrimeData();
          this.clearFileInput();
          this.fileName = "";
        })
        .catch((error) => {
          console.error("There was an error uploading to Crimedata!", error);
        });

      axios
        .post("http://localhost:3000/api/unspecifieddata", this.accidentData, {
          withCredentials: true,
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then(() => {
          this.fetchCrimeData();
          this.clearFileInput();
          this.fileName = "";
        })
        .catch((error) => {
          console.error(
            "There was an error uploading to UnspecifiedData!",
            error
          );
        });
    },

    clearFileInput() {
      this.$refs.fileInput.value = null;
      this.isFileLoaded = false;
    },

    exportToExcel() {
      let dataToExport = [];

      if (this.activeTab === 0) {
        dataToExport = this.accidentData;
      } else if (this.activeTab === 1) {
        dataToExport = this.crimeData;
      } else if (this.activeTab === 2) {
        dataToExport = this.UnspecifiedData;
      }
      if (dataToExport.length === 0) {
        alert("ไม่มีข้อมูลในแท็บนี้สำหรับนำออก");
        return;
      }

      const worksheet = XLSX.utils.json_to_sheet(dataToExport);
      const workbook = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(workbook, worksheet, "Data");

      XLSX.writeFile(workbook, "สถิติ.xlsx");
    },

    // --------------------------------- ลบข้อมูล --------------------------------

    deleteData(id) {
      if (confirm("คุณต้องการลบข้อมูลนี้จริงหรือไม่?")) {
        axios
          .delete(`http://localhost:3000/api/accidentdata/${id}`)
          .then(() => {
            this.fetchAccidentData();
          })
          .catch((error) => {
            console.error("There was an error deleting the data!", error);
          });
      }
    },

    deleteCrimeData(id) {
      if (confirm("คุณต้องการลบข้อมูลนี้จริงหรือไม่?")) {
        axios
          .delete(`http://localhost:3000/api/crimedata/${id}`)
          .then(() => {
            this.fetchCrimeData();
          })
          .catch((error) => {
            console.error("There was an error deleting the data!", error);
          });
      }
    },

    deleteUnspecifiedData(id) {
      if (confirm("คุณต้องการลบข้อมูลนี้จริงหรือไม่?")) {
        axios
          .delete(`http://localhost:3000/api/Unspecifieddata/${id}`)
          .then(() => {
            this.fetchUnspecifiedData();
          })
          .catch((error) => {
            console.error("There was an error deleting the data!", error);
          });
      }
    },

    toggleSelectAllAccident(event) {
      if (event.target.checked) {
        this.selectedAccidentItems = this.accidentData.map((item) => item.id);
      } else {
        this.selectedAccidentItems = [];
      }
    },

    toggleSelectAllCrime(event) {
      if (event.target.checked) {
        this.selectedCrimeItems = this.crimeData.map((item) => item.id);
      } else {
        this.selectedCrimeItems = [];
      }
    },

    toggleSelectAllUnspecified(event) {
      if (event.target.checked) {
        this.selectedUnspecifiedItems = this.UnspecifiedData.map(
          (item) => item.id
        );
      } else {
        this.selectedUnspecifiedItems = [];
      }
    },

    deleteSelected() {
      const isCrimeTab = this.activeTab === 1;
      const isUnspecifiedTab = this.activeTab === 2;

      const selectedItems = isCrimeTab
        ? this.selectedCrimeItems
        : isUnspecifiedTab
        ? this.selectedUnspecifiedItems
        : this.selectedAccidentItems;

      if (selectedItems.length === 0) {
        alert("กรุณาเลือกข้อมูลที่ต้องการลบก่อน");
        return;
      }

      if (
        confirm(`คุณต้องการลบ ${selectedItems.length} รายการนี้จริงหรือไม่?`)
      ) {
        const deletePromises = selectedItems.map((id) =>
          axios.delete(
            isCrimeTab
              ? `http://localhost:3000/api/crimedata/${id}`
              : isUnspecifiedTab
              ? `http://localhost:3000/api/unspecifieddata/${id}`
              : `http://localhost:3000/api/accidentdata/${id}`
          )
        );

        Promise.all(deletePromises)
          .then(() => {
            if (isCrimeTab) {
              this.fetchCrimeData();
              this.selectedCrimeItems = [];
            } else if (isUnspecifiedTab) {
              this.fetchUnspecificData();
              this.selectedUnspecificItems = [];
            } else {
              this.fetchAccidentData();
              this.selectedAccidentItems = [];
            }
          })
          .catch((error) => {
            console.error("เกิดข้อผิดพลาดในการลบข้อมูล!", error);
          });
      }
    },

    editAccidentData(id) {
      this.$router.push(`/data/editaccident/${id}`);
    },
    editCrimeData(id) {
      this.$router.push(`/data/editcrime/${id}`);
    },
    editUnspecifiedData(id) {
      this.$router.push(`/data/editunspecified/${id}`);
    },

    addData() {
      this.$router.push("/data/add");
    },

    formatDate(date) {
      const year = new Date(date).getFullYear() + 543;
      return format(new Date(date), `d MMMM ${year}`, { locale: th });
    },

    triggerFileUpload() {
      this.$refs.fileInput.click();
    },

    sortData(key) {
      this.sortKey = key;
      this.sortOrder = this.sortOrder === "asc" ? "desc" : "asc";
      this.accidentData.sort((a, b) => {
        if (this.sortOrder === "asc") {
          return a[key] > b[key] ? 1 : -1;
        } else {
          return a[key] < b[key] ? 1 : -1;
        }
      });
    },

    refreshData() {
      this.isLoading = true;
      this.fetchAccidentData();
    },

    handleFilterInput() {
      this.filter = this.filter.trim();
    },
  },

  mounted() {
    this.fetchAccidentData();
    this.fetchCrimeData();
    this.fetchUnspecifiedData();
  },
};
</script>

<style>
@import "@/styles/accident-data.css";
</style>
