#!/bin/bash
echo "🔧 Memulai install bot WhatsApp..."

# Update sistem dan install Node.js + git
apt update && apt install -y git nodejs npm

# Clone repo
git clone https://github.com/script-vpn-premium/simplebot.git
cd simplebot

# Install dependensi
npm install

# Jalankan bot WhatsApp
echo "🚀 Menjalankan bot... silakan scan QR WhatsApp"
node index.js