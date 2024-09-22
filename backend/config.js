const mysql2 = require("mysql2");

const conn = mysql2.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "caraccident",
  waitForConnections: true
});

conn.connect((err) => {
  if (err) {
    console.error("Error connecting to MySQL:", err);
    return;
  }
  console.log("Connected to MySQL");
});

module.exports = conn;