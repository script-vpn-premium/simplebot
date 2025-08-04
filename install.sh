#!/bin/bash

echo "🔧 Installing dependencies..."
apt update && apt install -y nodejs npm git

echo "📥 Cloning bot..."
git clone https://github.com/script-vpn-premium/simplebot.git
cd simplebot || exit

echo "📦 Installing npm packages..."
npm install

echo "🚀 Starting bot (manual pairing code)..."
node index.js