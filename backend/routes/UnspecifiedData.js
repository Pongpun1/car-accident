const express = require("express");
const conn = require("../config");
const router = express.Router();
const { NlpManager } = require("node-nlp");

const manager = new NlpManager({ languages: ["th"] });

manager.addDocument("th", "อุบัติเหตุ", "accident");
manager.addDocument("th", "รถชน", "accident");
manager.addDocument("th", "รถล้ม", "accident");
manager.addDocument("th", "รถคว่ำ", "accident");
manager.addDocument("th", "ประสานงา", "accident");
manager.addDocument("th", "ชนท้าย", "accident");
manager.addDocument("th", "เสียหลัก", "accident");
manager.addDocument("th", "อาชญากรรม", "crime");
manager.addDocument("th", "ปล้น", "crime");
manager.addDocument("th", "ชิงทรัพย์", "crime");
manager.addDocument("th", "โจร", "crime");
manager.addDocument("th", "จี้", "crime");
manager.addDocument("th", "ขโมย", "crime");
manager.addDocument("th", "คนร้าย", "crime");
manager.addDocument("th", "ฆ่า", "crime");
manager.addDocument("th", "ข่มขืน", "crime");
manager.addDocument("th", "อนาจาร", "crime");
manager.addDocument("th", "ยาเสพติด", "crime");
manager.addDocument("th", "ลักพาตัว", "crime");
manager.addDocument("th", "ฆาตกรรม", "crime");

(async () => {
  await manager.train();
  manager.save();
})();

// ------------------------------------------เพิ่มข้อมูลแบบไฟล์---------------------------------------
router.post("/", async (req, res) => {
  console.log("Received body:", req.body);
  const excelData = req.body;

  if (!Array.isArray(excelData) || excelData.length === 0) {
    return res.status(400).send({ message: "No data received" });
  }

  const filteredData = [];
  for (const row of excelData) {
    const info = row.รายละเอียด || "";

    const response = await manager.process("th", info);

    if (response.intent !== "accident" && response.intent !== "crime") {

      let date = row.วันเกิดเหตุ;
      if (date) {
        let [day, month, year] = date.split("-");
        year = parseInt(year) - 543;
        date = `${year}-${month}-${day}`;
      }

      filteredData.push([
        row.สถานที่เกิดเหตุ,
        row.ละติจูด,
        row.ลองจิจูด,
        row.จำนวนผู้บาดเจ็บ,
        row.จำนวนผู้เสียชีวิต,
        date,
        info,
      ]);
    }
  }

  if (filteredData.length === 0) {
    return res.status(400).send({ message: "No valid data to insert" });
  }

  const insertOrUpdateQuery = `
    INSERT INTO unspecified_data (location, latitude, longitude, numinjur, numdeath, date, info)
    VALUES (?, ?, ?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE
      numinjur = VALUES(numinjur),
      numdeath = VALUES(numdeath)
  `;

  const queryPromises = filteredData.map((value) => {
    return new Promise((resolve, reject) => {
      conn.execute(insertOrUpdateQuery, value, (err, result) => {
        if (err) {
          reject(err);
        } else {
          resolve(result);
        }
      });
    });
  });

  Promise.all(queryPromises)
    .then(() => {
      res.status(200).send({ message: "Data processed successfully!" });
    })
    .catch((err) => {
      console.error("Error inserting or updating data:", err.message);
      res.status(500).send({ message: "Error inserting or updating data" });
    });
});

// ------------------------------------------เพิ่มข้อมูลแยกตัว---------------------------------------
router.post("/single", (req, res) => {
  const { location, latitude, longitude, numinjur, numdeath, date, info } =
    req.body;

  if (!latitude || !longitude || !date) {
    console.log("Missing required fields");
    return res.status(400).json({ message: "กรุณากรอกข้อมูลให้ครบถ้วน" });
  }

  const maxIdQuery = "SELECT MAX(id) as maxId FROM unspecified_data";

  conn.execute(maxIdQuery, (err, result) => {
    if (err) {
      console.error("Error fetching max ID:", err.message);
      return res.status(500).json({ message: "Error fetching max ID" });
    }

    const newId = result[0].maxId ? result[0].maxId + 1 : 1;

    const checkQuery = `
      SELECT * FROM unspecified_data 
      WHERE location = ? AND latitude = ? AND longitude = ? 
      AND numinjur = ? AND numdeath = ? AND date = ?
    `;

    conn.execute(
      checkQuery,
      [location, latitude, longitude, numinjur, numdeath, date],
      (err, results) => {
        if (err) {
          console.error("Error checking data:", err.message);
          return res
            .status(500)
            .json({ message: "เกิดข้อผิดพลาดในการตรวจสอบข้อมูล" });
        }

        if (results.length > 0) {
          return res.status(400).json({ message: "ข้อมูลนี้มีอยู่แล้วในระบบ" });
        }

        const insertQuery = `
          INSERT INTO unspecified_data 
          (id, location, latitude, longitude, numinjur, numdeath, date, info) 
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `;

        conn.execute(
          insertQuery,
          [
            newId,
            location,
            latitude,
            longitude,
            numinjur,
            numdeath,
            date,
            info || null,
          ],
          (err, result) => {
            if (err) {
              console.error("Error inserting data:", err.message);
              return res.status(500).json({ message: "Error inserting data" });
            }
            res.status(200).json({ message: "บันทึกข้อมูลสำเร็จ" });
          }
        );
      }
    );
  });
});

// ------------------------------------------แสดงข้อมูล-------------------------------------------
router.get("/", async (req, res) => {
  let sql = "SELECT * FROM unspecified_data";
  await conn.execute(sql, (err, result) => {
    if (err) {
      res.status(500).json({
        message: err.message,
      });
      return;
    }
    res.status(200).json({
      message: "เรียกข้อมูลสำเร็จ",
      data: result,
    });
  });
});

// ------------------------------------------ลบข้อมูล-------------------------------------------
router.delete("/:id", async (req, res) => {
  const { id } = req.params;

  if (!id || isNaN(id)) {
    return res.status(400).json({
      message: "Invalid ID provided",
    });
  }

  const sql = "DELETE FROM unspecified_data WHERE id = ?";

  conn.execute(sql, [id], (err, result) => {
    if (err) {
      console.error("Error deleting data:", err.message);
      return res.status(500).json({
        message: "Error deleting data",
        error: err.message,
      });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({
        message: `No record found with id ${id}`,
      });
    }

    res.status(200).json({
      message: `Record with id ${id} deleted successfully`,
    });
  });
});

// ------------------------------------------แสดงข้อมูลแยกตัว-------------------------------------------
router.get("/:id", async (req, res) => {
  const { id } = req.params;
  let sql = "SELECT * FROM unspecified_data WHERE id = ?";
  conn.execute(sql, [id], (err, result) => {
    if (err) {
      res.status(500).json({
        message: err.message,
      });
      return;
    }
    res.status(200).json({
      message: "เรียกข้อมูลสำเร็จ",
      data: result,
    });
  });
});

// ------------------------------------------อัพเดทข้อมูล-------------------------------------------
router.put("/:id", (req, res) => {
  const { id } = req.params;
  const { location, latitude, longitude, numinjur, numdeath, date, info } =
    req.body;

  if (
    !location ||
    !latitude ||
    !longitude ||
    numinjur === undefined ||
    numdeath === undefined ||
    !date
  ) {
    return res.status(400).json({
      message: "กรุณาให้ข้อมูลที่ครบถ้วน",
    });
  }
  const checkQuery = `
    SELECT * FROM identdata WHERE latitude = ? AND longitude = ? AND date = ? AND id != ?
  `;

  conn.execute(checkQuery, [latitude, longitude, date, id], (err, results) => {
    if (err) {
      console.error("Error checking data:", err.message);
      return res.status(500).json({
        message: "เกิดข้อผิดพลาดในการตรวจสอบข้อมูล",
      });
    }

    if (results.length > 0) {
      return res.status(400).json({
        message: "ข้อมูลนี้มีอยู่แล้ว",
      });
    }

    const updateQuery = `
      UPDATE identdata
      SET location = ?, latitude = ?, longitude = ?, numinjur = ?, numdeath = ?, date = ?, info = ?
      WHERE id = ?
    `;

    conn.execute(
      updateQuery,
      [location, latitude, longitude, numinjur, numdeath, date, info, id],
      (err, result) => {
        if (err) {
          console.error("Error updating data:", err.message);
          return res.status(500).json({
            message: "เกิดข้อผิดพลาดในการอัปเดตข้อมูล",
            error: err.message,
          });
        }

        if (result.affectedRows === 0) {
          return res.status(404).json({
            message: `ไม่พบข้อมูลที่มี id ${id}`,
          });
        }

        res.status(200).json({
          message: `อัปเดตข้อมูลของ id ${id} สำเร็จแล้ว`,
        });
      }
    );
  });
});

module.exports = router;
