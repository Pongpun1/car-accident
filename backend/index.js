const express = require("express");
const app = express();
const cors = require("cors");

app.use(cors());

app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
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

app.listen(3000, "0.0.0.0", () => {
  console.log("Server is running on port 3000");
});
