const express = require("express");
const app = express();
const cors = require("cors");

const allowedOrigins = ["http://localhost:8080", "http://10.203.70.26:8080", "http://34.124.168.71:8080"];
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
    allowedHeaders: ["Content-Type", "Authorization"],
    credentials: true,
  })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const dataRoutes = require("./routes/AccidentData");
app.use("/api/accidentdata", dataRoutes);
const crimeRoutes = require("./routes/CrimeData");
app.use("/api/crimedata", crimeRoutes);
const unspecifiedRoutes = require("./routes/UnspecifiedData");
app.use("/api/unspecifieddata", unspecifiedRoutes);
const unapproveRoutes = require("./routes/UnapproveData");
app.use("/api/unapprovedata", unapproveRoutes);
const UserRoutes = require("./routes/User");
app.use("/users", UserRoutes);
const GeoRoutes = require("./routes/Geo");
app.use("/geocode", GeoRoutes);

app.listen(3000, '0.0.0.0/0', () => {
  console.log("Server is running on port 3000");
});
