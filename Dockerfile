FROM node:alpine3.19
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g npm@10.5.2 && npm cache clean --force
RUN npm install axios
RUN apk update && apk upgrade && apk add --no-cache openssl
COPY . .
CMD ["node", "index.js"]
