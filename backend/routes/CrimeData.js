const express = require("express");
const conn = require("../config");
const router = express.Router();
const { NlpManager } = require("node-nlp");

const manager = new NlpManager({ languages: ["th"] });

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
const convertDateFormat = (dateStr) => {
  if (!dateStr) return null;

  if (dateStr instanceof Date) {
    return dateStr.toISOString().split("T")[0];
  }

  if (!isNaN(Date.parse(dateStr))) {
    return new Date(dateStr).toISOString().split("T")[0];
  }

  const regex = /^(\d{2})\/(\d{2})\/(\d{4})$/;
  const match = dateStr.match(regex);

  if (!match) return dateStr;

  const day = match[1].padStart(2, "0");
  const month = match[2].padStart(2, "0");
  const year = match[3];

  return `${year}-${month}-${day}`;
};

router.post("/", async (req, res) => {
  const excelData = req.body;

  if (!Array.isArray(excelData) || excelData.length === 0) {
    return res.status(400).send({ message: "No data received" });
  }

  const filteredData = [];

  for (const row of excelData) {
    const crimeinfo = row.รายละเอียด || "";
    const language = "th";

    const response = await manager.process(language, crimeinfo);

    if (response.intent === "crime") {


      filteredData.push([
        row.สถานที่เกิดเหตุ,
        row.ละติจูด,
        row.ลองจิจูด,
        row.จำนวนผู้บาดเจ็บ,
        row.จำนวนผู้เสียชีวิต,
        convertDateFormat(row.วันเกิดเหตุ),
        crimeinfo,
      ]);
    }
  }

  if (filteredData.length === 0) {
    return res.status(400).send({ message: "No valid crime data to insert" });
  }

  const insertOrUpdateQuery = `
    INSERT INTO crimedata (crimelocation, latitude, longitude, numinjur, numdeath, crimedate, crimeinfo)
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
  const {
    crimelocation,
    latitude,
    longitude,
    numinjur,
    numdeath,
    crimedate,
    crimeinfo,
  } = req.body;

  if (!latitude || !longitude || !crimedate) {
    console.log("Missing required fields");
    return res.status(400).json({ message: "กรุณากรอกข้อมูลให้ครบถ้วน" });
  }

  const maxIdQuery = "SELECT MAX(id) as maxId FROM crimedata";

  conn.execute(maxIdQuery, (err, result) => {
    if (err) {
      console.error("Error fetching max ID:", err.message);
      return res.status(500).json({ message: "Error fetching max ID" });
    }

    const newId = result[0].maxId ? result[0].maxId + 1 : 1;

    const checkQuery = `
      SELECT * FROM crimedata 
      WHERE crimelocation = ? AND latitude = ? AND longitude = ? 
      AND numinjur = ? AND numdeath = ? AND crimedate = ?
    `;

    conn.execute(
      checkQuery,
      [
        crimelocation,
        latitude,
        longitude,
        numinjur,
        numdeath,
        crimedate,
      ],
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
          INSERT INTO crimedata 
          (id, crimelocation, latitude, longitude, numinjur, numdeath, crimedate, crimeinfo) 
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `;

        conn.execute(
          insertQuery,
          [
            newId,
            crimelocation,
            latitude,
            longitude,
            numinjur,
            numdeath,
            crimedate,
            crimeinfo || null,
          ],
          (err, result) => {
            if (err) {
              console.error("🚨 SQL Error:", err);
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
  let sql = "SELECT * FROM crimedata";
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

  const sql = "DELETE FROM crimedata WHERE id = ?";

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
  let sql = "SELECT * FROM crimedata WHERE id = ?";
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
  const {
    crimelocation,
    latitude,
    longitude,
    numinjur,
    numdeath,
    crimedate,
    crimeinfo,
  } = req.body;

  if (
    !crimelocation ||
    !latitude ||
    !longitude ||
    numinjur === undefined ||
    numdeath === undefined ||
    !crimedate
  ) {
    return res.status(400).json({
      message: "กรุณาให้ข้อมูลที่ครบถ้วน",
    });
  }
  const checkQuery = `
    SELECT * FROM crimedata WHERE latitude = ? AND longitude = ? AND crimedate = ? AND id != ?
  `;

  conn.execute(
    checkQuery,
    [latitude, longitude, crimedate, id],
    (err, results) => {
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
      UPDATE crimedata
      SET crimelocation = ?, latitude = ?, longitude = ?, numinjur = ?, numdeath = ?, crimedate = ?, crimeinfo = ?
      WHERE id = ?
    `;

      conn.execute(
        updateQuery,
        [
          crimelocation,
          latitude,
          longitude,
          numinjur,
          numdeath,
          crimedate,
          crimeinfo,
          id,
        ],
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
    }
  );
});

module.exports = router;
