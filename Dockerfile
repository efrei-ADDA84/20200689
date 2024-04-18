FROM node:alpine3.19
WORKDIR /usr/src/app

COPY package*.json ./

RUN apk update && \
    apk add --no-cache curl=8.5.0-r0 openssl=3.1.4-r6 && \
    npm install express@4.17.1 axios@0.21.4 && \
    npm cache clean --force

COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
