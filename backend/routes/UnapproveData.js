const express = require("express");
const conn = require("../config");
const router = express.Router();

// ------------------------------------------แสดงข้อมูล-------------------------------------------
router.get("/", async (req, res) => {
  let sql = "SELECT * FROM unapprove_data";
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
// ------------------------------------------เพิ่มข้อมูลแยกตัว---------------------------------------
router.post("/single", (req, res) => {
  const { unapprove_location, latitude, longitude, numinjur, numdeath, unapprove_date, unapprove_info} =
    req.body;

  if (!latitude || !longitude || !unapprove_date) {
    console.log("Missing required fields");
    return res.status(400).json({ message: "กรุณากรอกข้อมูลให้ครบถ้วน" });
  }

  const maxIdQuery = "SELECT MAX(id) as maxId FROM unapprove_data";

  conn.execute(maxIdQuery, (err, result) => {
    if (err) {
      console.error("Error fetching max ID:", err.message);
      return res.status(500).json({ message: "Error fetching max ID" });
    }

    const newId = result[0].maxId ? result[0].maxId + 1 : 1;

    const checkQuery = `
      SELECT * FROM unapprove_data 
      WHERE unapprove_location = ? AND latitude = ? AND longitude = ? 
      AND numinjur = ? AND numdeath = ? AND unapprove_date = ?
    `;

    conn.execute(
      checkQuery,
      [unapprove_location, latitude, longitude, numinjur, numdeath, unapprove_date],
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
          INSERT INTO unapprove_data 
          (id, unapprove_location, latitude, longitude, numinjur, numdeath, unapprove_date, unapprove_info) 
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `;

        conn.execute(
          insertQuery,
          [
            newId,
            unapprove_location,
            latitude,
            longitude,
            numinjur,
            numdeath,
            unapprove_date,
            unapprove_info || null,
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
  let sql = "SELECT * FROM unapprove_data";
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

  const sql = "DELETE FROM unapprove_data WHERE id = ?";

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
  let sql = "SELECT * FROM unapprove_data WHERE id = ?";
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


module.exports = router;
