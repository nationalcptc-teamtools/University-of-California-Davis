#!/bin/bash
sudo apt update
sudo apt -y install enum4linux-ng netexec impacket impacket-scripts tmux flameshot xclip peass

# Download github resources
wget -P ~/ https://raw.githubusercontent.com/nationalcptc-teamtools/University-of-California-Davis/refs/heads/main/nuclearfizzler/.tmux.conf

wget -P ~/ https://raw.githubusercontent.com/61106960/adPEAS/refs/heads/main/adPEAS-Light.ps1

# Setup neo4j for bloodhound
sudo neo4j console 1>/dev/null &
sleep 5
firefox http://localhost:7474/browser/

