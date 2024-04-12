FROM node:alpine3.19

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install -g npm@10.5.2 && npm cache clean --force

RUN npm install express@4.17.1 axios@0.27.2

RUN apk update && apk upgrade && \
    apk add --no-cache \
    curl=7.83.1-r3 \
    openssl=1.1.1q-r0

COPY . .

CMD ["node", "index.js"]