const getWeather = require('./weather');

const apiKey = process.env.API_KEY;
const latitude = process.env.LAT;
const longitude = process.env.LONG;

if (!apiKey || !latitude || !longitude) {
    console.error("Please provide LAT, LONG, and API_KEY environment variables.");
    process.exit(1);
}

getWeather(latitude, longitude, apiKey)
.then(data => {

  const country = data.sys.country;
  const weatherMain = data.weather[0].main;
  const tempMin = (data.main.temp_min - 273.15).toFixed(2); // From Kelvin to Celcius
  const tempMax = (data.main.temp_max - 273.15).toFixed(2);
  const description = data.weather[0].description;

  const message = `The current weather in ${data.name}, ${country} (Latitude: ${latitude}, Longitude: ${longitude}) is characterized by ${description}. The temperature is fluctuating between ${tempMin}°C and ${tempMax}°C.`;

  console.log(message);
})
  .catch(error => console.error(error));
