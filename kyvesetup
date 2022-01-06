#!/bin/bash

while true
do
echo "============================================================"
curl -s https://raw.githubusercontent.com/AlekseyMoskalev1/script/main/Noders.sh | bash
echo "============================================================"
PS3='Select an action: '
options=(
"Install Docker"
"Update ATP"
"Run MoonRiver"
"Run Cosmos"
"Run Celo"
"Run Solana"
"Run Evmos EVM"
"Run Evmos Tendermint"
"Run Near"
"Run Aurora")
select opt in "${options[@]}"
do
case $opt in
"Install Docker")
echo "============================================================"
echo "Docker installation started"
echo "============================================================"
sudo apt-get install curl gnupg apt-transport-https ca-certificates \
lsb-release -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
echo "deb [arch=$(dpkg --print-architecture) \
signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
sudo apt-get update && \
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version
echo "============================================================"
echo "Docker installed"
echo "============================================================"
break
;;
"Update ATP")
echo "============================================================"
echo "ATP update started"
echo "============================================================"
sudo apt update && sudo apt upgrade -y
echo "============================================================"
echo "ATP updated"
echo "============================================================"
break
;;
