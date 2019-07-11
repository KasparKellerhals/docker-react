# Dockerfile for
# 2-Step Production Build

# Step 1: Build the App
# and create the /build folder

FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Extract the Container for Production
# Nginx-Default Container starts automatically.
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
