# Use official Node.js 18 image as base
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the app
COPY . .

# Build the app
RUN npm run build

# Expose the port (adjust if your app uses a different one)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
