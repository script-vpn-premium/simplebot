#!/bin/bash

echo "🔧 Installing dependencies..."
apt update && apt install -y nodejs npm git

echo "📥 Cloning bot..."
git clone https://github.com/script-vpn-premium/simplebot.git
cd simplebot || exit

echo "📦 Installing npm packages..."
npm install

echo "📦 Installing PM2 process manager..."
npm install -g pm2

echo "🚀 Starting bot with PM2 (manual pairing code)..."
pm2 start index.js --name simplebot
pm2 save
pm2 startup

echo ""
echo "✅ Bot sudah berjalan di PM2. Gunakan perintah berikut untuk mengelola:"
echo "  🌐 Cek status: pm2 list"
echo "  🔁 Restart: pm2 restart simplebot"
echo "  🛑 Stop: pm2 stop simplebot"
echo "  ❌ Hapus: pm2 delete simplebot"