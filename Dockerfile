FROM node:24-slim
FROM debian:bullseye

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and build zlib 1.3.1
WORKDIR /usr/local/src
RUN wget https://zlib.net/zlib-1.3.1.tar.gz && \
    tar -xzf zlib-1.3.1.tar.gz && \
    cd zlib-1.3.1 && \
    ./configure && \
    make && \
    make install

# Verify installation
RUN ldconfig && ldconfig -p | grep libz

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . . 
EXPOSE 8080
CMD ["node", "server.js"]


