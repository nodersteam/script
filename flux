#!/bin/bash

while true
do

# Logo

echo "============================================================"
curl -s https://raw.githubusercontent.com/AlekseyMoskalev1/script/main/Noders.sh | bash
echo "============================================================"


PS3='Select an action: '
options=("Prepare the server for installation" "Actions outside server" "Create wallet" "Login near network" "Faucet" "Install node" "Check node status" "Exit")
select opt in "${options[@]}"
               do
                   case $opt in
                   
"Prepare the server for installation")
               echo "============================================================"
               echo "Preparation has begun"
               echo "============================================================"
               
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sleep 3
source $HOME/.cargo/env
rustup target add wasm32-unknown-unknown

sudo apt update
curl https://deb.nodesource.com/setup_16.x | sudo bash
sudo apt install -y nodejs gcc g++ make < "/dev/null"
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

npm install -g near-cli
npm install -g npm@8.3.0

               echo "============================================================"
               echo "The server is ready!"
               echo "============================================================"
break
;;
            
"Actions outside server")
USERNAME=$(whoami)
echo 'export USERNAME='${USERNAME} >> $HOME/.bash_profile
SERVER_IP=$(wget -qO- eth0.me)
echo 'export SERVER_IP='${SERVER_IP} >> $HOME/.bash_profile
. $HOME/.bash_profile

                echo "============================================================"
                echo "Next, you will need to work in the terminal of your desktop computer. 
Go to your terminal (if you are working under Windows - in the
search for the "Start" menu, type cmd and do the following)"
                echo "============================================================"
                echo "ssh -L 5000:127.0.0.1:5000 -C -N -l $USERNAME $SERVER_IP"
                echo "============================================================"
sleep 5
                echo "============================================================"
                echo "After you have inserted the displayed command into the terminal
of your PC - write "yes" and enter the password from the server
Nothing should be displayed in the terminal of your pc"
                echo "============================================================"
break
;;

"Create wallet")
                echo "============================================================"
                echo "Go to the guide page in a browser"
                echo "============================================================"

break
;;

"Login near network")                
                echo "============================================================"
                echo "Copy the link above, paste it into your browser window and allow the connection"
                echo "============================================================"
near login
break
;;

"Faucet")
                echo "============================================================"
                echo "Write the full name of your wallet in the format name.testnet"
                echo "============================================================"
read FLUX_WALLET
echo 'export FLUX_WALLET='${FLUX_WALLET} >> $HOME/.bash_profile
. $HOME/.bash_profile

near call v2.wnear.flux-dev storage_deposit '{"account_id": "$FLUX_WALLET"}' --accountId $FLUX_WALLET --amount 0.00125 --gas=300000000000000
near call v2.wnear.flux-dev near_deposit "{}" --accountId $FLUX_WALLET --amount 20 --gas=300000000000000
break
;;

"Install node")
apt install git -y
cd $HOME
git clone https://github.com/fluxprotocol/oracle-validator-node.git
cd oracle-validator-node
git fetch --all
git checkout tags/v2.4.0
echo "# Core options
DEBUG = true
# HTTP server options
HTTP_PORT = 28484
# Database
DB_PATH = ./
DB_NAME = flux_db
# Providers
ACTIVATED_PROVIDERS = near
# NEAR options
NEAR_CREDENTIALS_STORE_PATH = $HOME/.near-credentials/
NEAR_ACCOUNT_ID = $FLUX_WALLET
NEAR_RPC = https://rpc.testnet.near.org
NEAR_CONTRACT_ID = 07.oracle.flux-dev
NEAR_NETWORK_ID = testnet
NEAR_MAX_STAKE_AMOUNT = 15" > $HOME/oracle-validator-node/.env
yarn install

echo "[Unit]
Description=Flux Validator Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which yarn) --cwd $HOME/oracle-validator-node start
Restart=always
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
" > $HOME/fluxd.service
sudo mv $HOME/fluxd.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable fluxd
sudo systemctl restart fluxd
break
;;

"Check node status")
               echo "============================================================"
               echo "Your log"
               echo "============================================================"
journalctl -u fluxd | tail -n 10

break
;;



"Exit")
exit
;;

*) echo "invalid option $REPLY";;
esac
done
done
