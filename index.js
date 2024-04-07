const getWeather = require('./weather');
require('dotenv').config();

getWeather(process.env.LAT, process.env.LONG, process.env.API_KEY)
  .then(data => console.log(data))
  .catch(error => console.error(error));
