const express = require("express");
const conn = require("../config");
const router = express.Router();

// ------------------------------------------เพิ่มข้อมูลแบบไฟล์---------------------------------------
router.post("/", (req, res) => {
  console.log("Received body:", req.body);
  const excelData = req.body;

  if (!Array.isArray(excelData) || excelData.length === 0) {
    return res.status(400).send({ message: "No data received" });
  }
  const values = excelData.map((row) => [
    row.ลำดับ,
    row.สถานที่เกิดเหตุ,
    row.ละติจูด,
    row.ลองจิจูด,
    row.จำนวนผู้บาดเจ็บ,
    row.จำนวนผู้เสียชีวิต,
    row.วันเกิดเหตุ,
  ]);

  const insertOrUpdateQuery = `
      INSERT INTO accidentdata (id, acclocation, latitude, longitude, numinjur, numdeath, accdate)
      VALUES (?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE
        numinjur = VALUES(numinjur),
        numdeath = VALUES(numdeath)
    `;

  const queryPromises = values.map((value) => {
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
  console.log("Received request body:", req.body); // Log request body
  const { acclocation, latitude, longitude, numinjur, numdeath, accdate } =
    req.body;

  if (!acclocation || !latitude || !longitude || !accdate) {
    console.log("Missing required fields");
    return res.status(400).json({ message: "กรุณากรอกข้อมูลให้ครบถ้วน" });
  }

  const checkQuery = `
      SELECT * FROM accidentdata WHERE acclocation = ? AND latitude = ? AND longitude = ? AND numinjur = ? AND numdeath = ?  AND accdate = ?
    `;

  conn.execute(
    checkQuery,
    [acclocation, latitude, longitude, numinjur, numdeath, accdate],
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
        INSERT INTO accidentdata (acclocation, latitude, longitude, numinjur, numdeath, accdate)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

      conn.execute(
        insertQuery,
        [acclocation, latitude, longitude, numinjur, numdeath, accdate],
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

// ------------------------------------------แสดงข้อมูล-------------------------------------------
router.get("/", async (req, res) => {
  let sql = "SELECT * FROM accidentdata";
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

  // Check if ID is provided and is a valid number
  if (!id || isNaN(id)) {
    return res.status(400).json({
      message: "Invalid ID provided",
    });
  }

  const sql = "DELETE FROM accidentdata WHERE id = ?";

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
  let sql = "SELECT * FROM accidentdata WHERE id = ?";
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
  const { acclocation, latitude, longitude, numinjur, numdeath, accdate } = req.body;

  if (!acclocation || !latitude || !longitude || numinjur === undefined || numdeath === undefined || !accdate) {
    return res.status(400).json({
      message: "กรุณาให้ข้อมูลที่ครบถ้วน",
    });
  }
  const checkQuery = `
    SELECT * FROM accidentdata WHERE latitude = ? AND longitude = ? AND accdate = ? AND id != ?
  `;

  conn.execute(checkQuery, [latitude, longitude, accdate, id], (err, results) => {
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
      UPDATE accidentdata
      SET acclocation = ?, latitude = ?, longitude = ?, numinjur = ?, numdeath = ?, accdate = ?
      WHERE id = ?
    `;

    conn.execute(updateQuery, [acclocation, latitude, longitude, numinjur, numdeath, accdate, id], (err, result) => {
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

      // ส่งข้อความว่าอัปเดตข้อมูลสำเร็จ
      res.status(200).json({
        message: `อัปเดตข้อมูลของ id ${id} สำเร็จแล้ว`,
      });
    });
  });
});

module.exports = router;
