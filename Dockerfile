# Step 1: Use Node.js base image
FROM node:18

# Step 2: Set working directory
WORKDIR /app

# Step 3: Upgrade npm globally
RUN npm install -g npm@11.6.2

# Step 4: Copy package.json and package-lock.json
COPY package*.json ./

# Step 5: Install dependencies
RUN npm install

# Step 6: Copy the rest of the project
COPY . .

# Step 7: Build the app
RUN npm run build

# Step 8: Expose port (if needed) and run
EXPOSE 3000
CMD ["npm", "start"]
