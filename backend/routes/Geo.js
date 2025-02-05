const express = require("express");
const axios = require("axios");
const router = express.Router();

router.get("/", async (req, res) => {
  const { lat, lng, address } = req.query;

  let geocodeUrl = "";
  if (address) {
    geocodeUrl = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(
      address
    )}&language=th&key=AIzaSyBpTaSCF5FB940suGM1mmn5oMhewau86PQ`;
  } else if (lat && lng) {
    geocodeUrl = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&language=th&key=AIzaSyBpTaSCF5FB940suGM1mmn5oMhewau86PQ`;
  } else {
    return res.status(400).json({ error: "Missing lat, lng or address parameters" });
  }

  try {
    const response = await axios.get(geocodeUrl);
    res.json(response.data);
  } catch (error) {
    console.error("Error fetching location:", error);
    res.status(500).send("Error fetching location");
  }
});


module.exports = router;
