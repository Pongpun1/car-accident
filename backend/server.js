const express = require("express");
const cors = require("cors");
const app = express();
const port = 8080;

app.use(
  cors({
    origin: "http://10.203.70.225:8080",
    methods: ["GET", "POST"],
    allowedHeaders: ["Content-Type"],
    credentials: true,
  })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const mysql2 = require("mysql2");
const conn = mysql2.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "caraccident",
});

conn.connect((err) => {
  if (err) {
    console.error("Error connecting to MySQL:", err);
    return;
  }
  console.log("Connected to MySQL");
});

app.post("/api/data", (req, res) => {
  console.log("Received body:", req.body);

  const excelData = req.body;

  // ตรวจสอบโครงสร้างของ excelData
  console.log("Excel Data Type:", typeof excelData);
  console.log("Excel Data isArray:", Array.isArray(excelData));

  if (!Array.isArray(excelData) || excelData.length === 0) {
    return res.status(400).send({ message: "No data received" });
  }

  excelData.forEach((row, index) => {
    console.log(`Row ${index}:`, row);
  });

  const values = excelData.map((row) => [
    row.ลำดับ,
    row.สถานที่เกิดเหตุ,
    row.ละติจูด,
    row.ลองจิจูด,
    row.จำนวนผู้บาดเจ็บ,
    row.จำนวนผู้เสียชีวิต,
    row.วันเกิดเหตุ,
  ]);

  console.log("Values to insert:", values);

  const insertQuery =
    "INSERT INTO `accidentdata`(`id`, `acclocation`, `latitude`, `longitude`, `numinjur`, `numdeath`, `accdate`) VALUES ?";

  conn.query(insertQuery, [values], (err, result) => {
    if (err) {
      console.error("Error inserting data:", err.code, err.message);
      return res.status(500).send({ message: "Error inserting data" });
    }
    res.status(200).send({ message: "Data saved successfully!" });
  });
});


app.get('/api/data', async (req, res) => {
    let sql = "SELECT * FROM accidentdata"  
    await conn.execute(sql,
        (err, result) => {
            if (err) {
                res.status(500).json({
                    message : err.message
                })
                return
            }
            res.status(200).json({
                message : "เรียกข้อมูลสำเร็จ",
                data : result
            })    
        }
    )
})

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
