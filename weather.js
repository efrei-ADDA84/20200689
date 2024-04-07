const axios = require('axios');

const getWeather = async (lat, lon, apiKey) => {
  const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  console.log("Requesting URL:", baseUrl + "?lat=" + lat + "&lon=" + lon + "&exclude=minutely,hourly&appid=" + apiKey);
  try {
    const response = await axios.get(baseUrl, {
      params: {
        lat: lat,
        lon: lon,
        exclude: 'minutely,hourly,daily,alerts', // We only need the current weather
        appid: apiKey
      }
    });
    return response.data;
  } catch (error) {
    console.error(`Error fetching weather data: ${error}`);
    return null;
  }
};

module.exports = getWeather;
