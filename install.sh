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
echo "🔑 Menjalankan pairing WhatsApp (gunakan kode pairing)..."
echo "🕒 Tunggu sampai muncul '✅ Bot terhubung!', lalu proses akan lanjut otomatis..."
echo ""

# Jalankan bot pairing, setelah konek dia keluar otomatis karena ada process.exit()
node index.js

echo ""
echo "✅ Pairing sukses. Sekarang bot akan dijalankan otomatis di background dengan PM2..."

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