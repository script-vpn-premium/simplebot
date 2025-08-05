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
else
  echo -e "${YELLOW}❌ Tidak ditemukan baris global.owner di settings.js${NC}"
fi

echo ""
echo -e "${YELLOW}🔑 Menjalankan pairing WhatsApp di background...${NC}"
echo -e "${YELLOW}🕒 Tunggu sampai pairing berhasil (${NC}✅ Bot terhubung!${YELLOW})...${NC}"
echo ""

# Jalankan node index.js di background & redirect output ke file
node index.js > log.txt 2>&1 &
PAIR_PID=$!

# Tunggu sampai muncul log "✅ Bot terhubung!"
while ! grep -q "✅ Bot terhubung!" log.txt; do
    sleep 2
done

# Hentikan proses pairing
kill $PAIR_PID
sleep 1

echo ""
echo -e "${YELLOW}✅ Pairing sukses. Menjalankan bot dengan PM2...${NC}"
pm2 start index.js --name simplebot
pm2 save

echo ""
echo -e "${YELLOW}⚙️ Mengatur PM2 agar otomatis saat VPS menyala...${NC}"
pm2 startup

echo ""
echo -e "${YELLOW}♻️ Reboot diperlukan agar PM2 auto-start aktif saat booting.${NC}"
read -p "$(echo -e "${YELLOW}Ingin reboot VPS sekarang? (y/n): ${NC}")" jawab

if [[ "$jawab" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}🔁 Rebooting VPS...${NC}"
    reboot
else
    echo -e "${YELLOW}🚀 Instalasi selesai. Silakan reboot VPS secara manual untuk menyelesaikan setup.${NC}"
fi