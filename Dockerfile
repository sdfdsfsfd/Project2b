FROM node:24-slim


RUN apt-get purge -y zlib1g-dev && \
    find / -name '*minizip*' -exec rm -rf {} + || true


WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . . 
EXPOSE 8080
CMD ["node", "server.js"]


