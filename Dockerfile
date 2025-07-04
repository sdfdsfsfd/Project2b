FROM node:24-slim
RUN apt-get update && apt-get purge -y zlib1g zlib1g-dev && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . . 
EXPOSE 8080
CMD ["node", "server.js"]


