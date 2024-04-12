const express = require('express');
const getWeather = require('./weather');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

// Code used for TP1. Now using the api call directly for LAT and LONG, using github secrets for the apikey (cf the yaml file)
// const apiKey = process.env.API_KEY;
// const latitude = process.env.LAT;
// const longitude = process.env.LONG;

app.get('/weather', async (req, res) => {
  const { lat, lon } = req.query;

  if (!lat || !lon) {
      return res.status(400).json({ error: 'Latitude and longitude query parameters are required.' });
  }

  try {
      const apiKey = process.env.API_KEY;
      if (!apiKey) {
          throw new Error("API_KEY environment variable is required.");
      }

      const data = await getWeather(lat, lon, apiKey);
      const country = data.sys.country;
      const description = data.weather[0].description;
      const tempMin = (data.main.temp_min - 273.15).toFixed(2); // Convert from Kelvin to Celsius
      const tempMax = (data.main.temp_max - 273.15).toFixed(2);

      const message = `The current weather in ${data.name}, ${country} (Latitude: ${lat}, Longitude: ${lon}) is characterized by ${description}. The temperature is fluctuating between ${tempMin}°C and ${tempMax}°C.`;

      res.json({ message: message });
  } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Failed to fetch weather data', details: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});