# ===== Stage 1: Build stage =====
FROM node:20-alpine AS build

# Set working directory inside the container
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the code
COPY . .

# Optional build step (ignore if not needed)
RUN npm run build || true


# ===== Stage 2: Runtime stage =====
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Set environment variable
ENV NODE_ENV=production

# Copy everything from build stage
COPY --from=build /app ./

# Create a non-root user for security
RUN addgroup -S app && adduser -S app -G app
USER app

# Expose port 3000
EXPOSE 3000

# Start the app
CMD ["npm", "start"]

