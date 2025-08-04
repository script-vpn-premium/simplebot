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

echo ""
echo "🔑 Menjalankan proses pairing WhatsApp..."
echo "🕒 Tunggu hingga pairing berhasil (maks 2 menit)..."
echo ""

# Jalankan bot di background untuk pairing
node index.js &

# Tunggu hingga pairing berhasil
for i in {1..60}; do
    if [ -f "session-ready.txt" ]; then
        echo "✅ Pairing berhasil!"
        break
    fi
    sleep 2
done

# Matikan proses sementara
pkill -f "node index.js"

echo ""
echo "🚀 Menjalankan bot secara permanen dengan PM2..."
pm2 start index.js --name simplebot
pm2 save
pm2 startup

echo ""
echo "✅ Instalasi selesai dan bot sudah berjalan dengan PM2!"
echo "Gunakan perintah berikut untuk mengelola bot:"
echo "  🌐 Cek status: pm2 list"
echo "  🔁 Restart: pm2 restart simplebot"
echo "  🛑 Stop: pm2 stop simplebot"
echo "  ❌ Hapus: pm2 delete simplebot"