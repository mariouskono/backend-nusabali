# Pakai base image Python slim (sudah ada Python)
FROM python:3.11-slim

# Install Node.js 18 dan npm
RUN apt-get update && apt-get install -y curl \
  && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

# Set working directory di dalam container
WORKDIR /app

# Copy package.json dan package-lock.json (jika ada)
COPY package*.json ./

# Install dependencies Node.js
RUN npm install

# Copy semua file project ke container
COPY . .

# Expose port yang Railway gunakan (biasanya 8080)
EXPOSE 8080

# Jalankan aplikasi node
CMD ["node", "server.js"]
