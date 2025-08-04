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
echo "🔑 Sekarang akan dijalankan pairing WhatsApp secara manual..."
echo "🕒 Tunggu sampai muncul kode pairing, lalu masukkan ke WhatsApp kamu."
echo "📲 Setelah berhasil pairing, tekan CTRL + C untuk melanjutkan."
echo ""
read -p "Tekan [ENTER] untuk mulai pairing..." enterKey

# Jalankan bot secara manual untuk pairing
node index.js

echo ""
echo "✅ Pairing selesai. Sekarang bot akan dijalankan otomatis di background dengan PM2..."

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