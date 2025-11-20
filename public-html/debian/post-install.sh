#!/bin/bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub > /tmp/linux_signing_key.pub
install -D -o root -g root -m 644 /tmp/linux_signing_key.pub /etc/apt/keyrings/linux_signing_key.pub
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/linux_signing_key.pub] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt update
DEBIAN_FRONTEND=noninteractive apt install google-chrome-stable
