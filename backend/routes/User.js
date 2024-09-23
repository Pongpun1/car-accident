const express = require("express");
const conn = require("../config");
const router = express.Router();

const bcrypt = require("bcrypt");

// ------------------------------------------เพิ่มบัญชี---------------------------------------
router.post("/", async (req, res) => {
  const { id, email, username, password } = req.body;

  if (!id || !email || !username || !password) {
    return res.status(400).json({
      message: "กรุณากรอกข้อมูลให้ครบถ้วน",
    });
  }

  try {
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    let sql =
      "INSERT INTO user (id, email, username, password) VALUES (?, ?, ?, ?)";
    await conn.execute(
      sql,
      [id, email, username, hashedPassword],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            message: err.message,
          });
        }
        res.status(201).json({
          message: "เพิ่มข้อมูลผู้ใช้สำเร็จ",
          data: result,
        });
      }
    );
  } catch (error) {
    res.status(500).json({
      message: "เกิดข้อผิดพลาดในการเพิ่มข้อมูลผู้ใช้",
      error: error.message,
    });
  }
});

// ------------------------------------------เข้าสู่ระบบ (Login)---------------------------------------
router.post("/login", async (req, res) => {
    const { username, password } = req.body;
  
    if (!username || !password) {
      return res.status(400).json({
        message: "กรุณากรอกข้อมูลให้ครบถ้วน",
      });
    }
  
    try {
      let sql = "SELECT * FROM user WHERE username = ?";
      await conn.execute(sql, [username], async (err, result) => {
        if (err) {
          return res.status(500).json({
            message: err.message,
          });
        }
  
        if (result.length === 0) {
          return res.status(400).json({
            message: "ไม่พบผู้ใช้ในระบบ",
          });
        }
  
        const user = result[0];
        const isMatch = await bcrypt.compare(password, user.password);
  
        if (!isMatch) {
          return res.status(400).json({
            message: "รหัสผ่านไม่ถูกต้อง",
          });
        }
  
        res.status(200).json({
          message: "เข้าสู่ระบบสำเร็จ",
          user: {
            id: user.id,
            email: user.email,
            username: user.username,
          },
        });
      });
    } catch (error) {
      res.status(500).json({
        message: "เกิดข้อผิดพลาดในการเข้าสู่ระบบ",
        error: error.message,
      });
    }
  });

module.exports = router;
