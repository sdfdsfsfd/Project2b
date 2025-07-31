# FROM node:24
# WORKDIR /usr/src/app
# COPY package*.json ./
# RUN npm install
# COPY . . 
# EXPOSE 8080
# CMD ["node", "server.js"]

# Use Ubuntu 22.04 LTS as the base image
FROM ubuntu:24.04

# Set environment variables to avoid user interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Add NodeSource repository for Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -

# Install Node.js
RUN apt-get update && apt-get install -y nodejs

# Verify installation
RUN node -v && npm -v

# Set working directory
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . . 
EXPOSE 8080
CMD ["node", "server.js"]