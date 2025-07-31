# FROM node:24
# WORKDIR /usr/src/app
# COPY package*.json ./
# RUN npm install
# COPY . . 
# EXPOSE 8080
# CMD ["node", "server.js"]

# Use Ubuntu 22.04 LTS as the base image
# FROM ubuntu:24.04

# # Set environment variables to avoid user interaction during installation
# ENV DEBIAN_FRONTEND=noninteractive

# # Update and install required packages
# RUN apt-get update && apt-get install -y \
#     curl \
#     gnupg \
#     ca-certificates \
#     build-essential \
#     && rm -rf /var/lib/apt/lists/*

# # Add NodeSource repository for Node.js 24
# RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -

# # Install Node.js
# RUN apt-get update && apt-get install -y nodejs

# # Verify installation
# RUN node -v && npm -v

# # Set working directory
# WORKDIR /usr/src/app
# COPY package*.json ./
# RUN npm install
# COPY . . 
# EXPOSE 8080
# CMD ["node", "server.js"]

# -------- Stage 1: Build Stage --------
FROM ubuntu:24.04.2 AS build

ENV DEBIAN_FRONTEND=noninteractive
    
# Install dependencies for building the app
RUN apt-get update && apt-get install -y \
        curl \
        gnupg \
        ca-certificates \
        build-essential \
        && rm -rf /var/lib/apt/lists/*
    
# Add NodeSource repository and install Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
        && apt-get update && apt-get install -y nodejs
    
# Set working directory
WORKDIR /usr/src/app
# Copy package files and install dependencies
COPY package*.json ./
RUN npm install
    
# Copy the rest of the application
COPY . .
    
# -------- Stage 2: Runtime Stage --------
FROM ubuntu:24.04
    
ENV DEBIAN_FRONTEND=noninteractive
    
# Install minimal runtime dependencies
RUN apt-get update && apt-get install -y \
        curl \
        gnupg \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*
    
# Add NodeSource repository and install Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
        && apt-get update && apt-get install -y nodejs
    
# Set working directory
WORKDIR /usr/src/app
    
# Copy only the built app and node_modules from build stage
COPY --from=build /usr/src/app /usr/src/app
    
EXPOSE 8080
CMD ["node", "server.js"]
    