#!/bin/bash
apt update && apt install git nodejs npm -y
git clone https://github.com/script-vpn-premium/scriptbot.git
cd scriptbot
npm install
node index.js