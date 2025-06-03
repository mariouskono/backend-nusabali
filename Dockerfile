FROM python:3.11-slim

# Install Node.js dan tools build (npm, build-essential)
RUN apt-get update && apt-get install -y curl build-essential \
  && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

# Install Python dependencies
RUN pip install --no-cache-dir pandas tensorflow numpy

# Debug cek lokasi python dan python3 (bisa dihapus setelah yakin)
RUN which python && which python3 || echo "python3 not found"

# Buat alias python3 ke python agar spawn python3 bisa jalan
RUN ln -sf $(which python) /usr/local/bin/python3

WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies Node.js
RUN npm install

# Copy seluruh source code
COPY . .

EXPOSE 8080

CMD ["node", "server.js"]
