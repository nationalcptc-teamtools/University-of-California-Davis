#!/bin/bash

# Switch mirror to Berkeley OCF because it's faster
for f in /etc/apt/sources.list /etc/apt/sources.list.d/kali.sources; do
  [ -f "$f" ] && sudo sed -i 's#https\?://http\.kali\.org#https://mirrors.ocf.berkeley.edu#g' "$f"
done

sudo apt update
sudo apt -y install enum4linux-ng netexec python3-impacket impacket-scripts tmux flameshot xclip peass bloodhound

# Download github resources
wget -P ~/ https://raw.githubusercontent.com/nationalcptc-teamtools/University-of-California-Davis/refs/heads/main/nuclearfizzler/.tmux.conf

wget -P ~/ https://raw.githubusercontent.com/61106960/adPEAS/refs/heads/main/adPEAS-Light.ps1

# Setup bloodhound
sudo bloodhound-setup
sudo bloodhound-start   

