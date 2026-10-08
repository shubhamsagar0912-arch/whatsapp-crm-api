FROM node:20-bookworm-slim

# Install Chromium and Git
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    chromium \
    fonts-liberation \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

EXPOSE 7860

ENV PORT=7860
ENV NODE_OPTIONS="--max-old-space-size=512"

CMD ["node", "server.js"]
