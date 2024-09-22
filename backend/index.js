const express = require("express")
const app = express();
const cors = require('cors')

const allowedOrigins = ["http://localhost:8080", "http://10.203.70.225:8080"];
app.use(
    cors({
      origin: function (origin, callback) {
        if (allowedOrigins.indexOf(origin) !== -1 || !origin) { 
          callback(null, true);
        } else {
          callback(new Error("Not allowed by CORS"));
        }
      },
      methods: ["GET", "POST", "DELETE", "PUT"],
      allowedHeaders: ["Content-Type"],
      credentials: true,
    })
  );
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));


// routers
const dataRoutes = require("./routes/DataServer");
app.use("/api/data", dataRoutes);
// const LoginRoutes = require("./routes/Login");
// app.use("/login", LoginRoutes);


app.listen(8080, () => {
    console.log(`Server is running on port 8080`);
  });