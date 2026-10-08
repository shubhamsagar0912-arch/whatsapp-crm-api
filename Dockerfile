FROM node:20-bookworm-slim

# Install system dependencies for headless Chromium
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    chromium \
    ca-certificates \
    fonts-liberation \
    libapparmor1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    librender1 \
    libxss1 \
    libxtst6 \
    && rm -rf /var/lib/apt/lists/*

# Point Puppeteer / WhatsApp to Debian's installed Chromium
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
