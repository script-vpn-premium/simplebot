# 🤖 SimpleBot - WhatsApp VPN Bot Installer

SimpleBot adalah bot WhatsApp otomatis untuk membuat akun VPN (SSH, VMess, VLESS, Trojan, Shadowsocks) melalui perintah WhatsApp. Bot ini dibangun menggunakan Node.js dan `@mengkodingan/ckptw`.

---

## 🚀 Install Otomatis

Kamu bisa menginstal SimpleBot secara otomatis dengan satu baris perintah:

```bash
bash <(curl -s https://raw.githubusercontent.com/script-vpn-premium/simplebot/main/install.sh)
```
---
## AGAR BOT TETEP AKTIP
```bash
pm2 start index.js --name simplebot
pm2 save
pm2 startup
```
---

## HAPUS BOT

```bash
rm -rf simplebot
```
