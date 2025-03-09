#!/bin/bash
sudo apt update
sudo apt -y install enum4linux-ng netexec python3-impacket impacket-scripts tmux flameshot xclip peass

# Download github resources
wget -P ~/ https://raw.githubusercontent.com/nationalcptc-teamtools/University-of-California-Davis/refs/heads/main/nuclearfizzler/.tmux.conf

wget -P ~/ https://raw.githubusercontent.com/61106960/adPEAS/refs/heads/main/adPEAS-Light.ps1

# hehehaha i love open source
sudo wget -O /usr/share/doc/python3-impacket/examples/GetNPUsers.py https://raw.githubusercontent.com/NuclearFizzler/impacket/refs/heads/getnpuser-file-output/examples/GetNPUsers.py

# Setup neo4j for bloodhound
sudo neo4j console 1>/dev/null &
sleep 5
firefox http://localhost:7474/browser/

