FROM node:alpine3.21
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . . 
EXPOSE 8080
CMD ["node", "server.js"]
