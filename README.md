## Global context of the module

During various lab sessions, we will build a first a wrapper than an API which returns the weather forecast of a given location. 

Labs made in the context of a DevOps module, Efrei Paris, M1 Big Data and Machine Learning.

### TP1 

In this lab, we had to create a wrapper and a docker image associated for the weather reports. I chose to use nodejs, as I'm more used to manipulate APIs using JavaScript. The project therefore contains : 

- A `weather.js` file containing the GetWeather method, which calls the OpenWeather API using axios
- An `index.js` file to call the GetWeather method and return the forecast
- A Dockerfile to manage the dependencies of the docker image

The image was built using node:alpine3.19. 

**There was initially a .env file to store environment variables, but it's not needed for lab one considering that the instructions want the variables to be parsed as arguments.**

Main difficulty of the project : making sure that the image had no vulnerability. The only vulnerability left in my image is the CVE-2024-28863. The issue surfaced very recently and the fixing solution provided by Docker (updating tar to the latest version) doesn't seem to work. However, using the following lines in the dockerfile seemed to fix all the issues regarding vulnerabilities : 

```
RUN npm install -g npm@10.5.2 && npm cache clean --force

RUN apk update && apk upgrade && apk add --no-cache openssl
```


To run the code, use `docker run --env LAT="wanted_lat" --env LONG="wanted_long" --env API_KEY=**** weather-wrapper`

This will return something like this : 

![image](https://github.com/efrei-ADDA84/20200689/assets/75856103/21774b9a-5f6a-4e01-ace6-147ebe7639de)

Link to the docker image from dockerhub : https://hub.docker.com/r/sachalunae/weather-wrapper 

