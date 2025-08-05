#!/bin/bash

YELLOW='\e[33m'
NC='\e[0m' # No Color

echo -e "${YELLOW}🔧 Installing dependencies...${NC}"
apt update && apt install -y nodejs npm git jq

echo -e "${YELLOW}📥 Cloning bot...${NC}"
git clone https://github.com/script-vpn-premium/simplebot.git
cd simplebot || exit

echo -e "${YELLOW}📦 Installing npm packages...${NC}"
npm install

echo -e "${YELLOW}📦 Installing PM2 process manager...${NC}"
npm install -g pm2

read -p "$(echo -e "${YELLOW}📱 Masukkan nomor WhatsApp owner (cth: 6281234567890): ${NC}")" OWNER_NUMBER

# Ubah baris global.owner di settings.js
if grep -q "global\.owner *= *\"" settings.js; then
  sed -i "s/global\.owner *= *\"[^\"]*\"/global.owner = \"$OWNER_NUMBER\"/" settings.js
  echo -e "${YELLOW}✅ global.owner berhasil diatur ke: $OWNER_NUMBER${NC}"
  sleep 3
else
  echo -e "${YELLOW}❌ Tidak ditemukan baris global.owner di settings.js${NC}"
fi

echo ""
echo -e "${YELLOW}🔑 Menjalankan pairing WhatsApp (gunakan kode pairing)...${NC}"
echo -e "${YELLOW}🕒 Tunggu sampai muncul '✅ Bot terhubung!', lalu proses akan lanjut otomatis...${NC}"
echo ""

node index.js

echo ""
echo -e "${YELLOW}✅ Pairing sukses. Sekarang bot akan dijalankan otomatis di background dengan PM2...${NC}"

pm2 start index.js --name simplebot
pm2 save
pm2 startup

echo ""
echo -e "${YELLOW}✅ Instalasi selesai dan bot sudah berjalan dengan PM2!${NC}"
echo -e "${YELLOW}Gunakan perintah berikut untuk mengelola bot:${NC}"
echo -e "  🌐 ${YELLOW}Cek status:${NC} pm2 list"
echo -e "  🔁 ${YELLOW}Restart:${NC} pm2 restart simplebot"
echo -e "  🛑 ${YELLOW}Stop:${NC} pm2 stop simplebot"
echo -e "  ❌ ${YELLOW}Hapus:${NC} pm2 delete simplebot"

echo ""
echo -e "${YELLOW}🔁 Sistem akan reboot otomatis dalam 5 detik...${NC}"
sleep 5
reboot