FROM python:3.11-slim

# Install Node.js dan tools build (dibutuhkan untuk npm dan tensorflow)
RUN apt-get update && apt-get install -y curl build-essential \
  && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

# Install Python dependencies
RUN pip install --no-cache-dir pandas tensorflow numpy

WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy seluruh kode
COPY . .

EXPOSE 8080

CMD ["node", "server.js"]
