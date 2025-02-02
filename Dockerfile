
# Step 1: Use an official Node.js base image
FROM node:alpine AS builder

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json (or pnpm-lock.yaml/yarn.lock)
COPY package.json package-lock.json* ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Build the React app using Vite and SWC
RUN npm run build

# Step 7: Use a lightweight web server to serve the built app
FROM nginx:alpine

# Step 8: Copy build output from the builder stage to Nginx's public directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
