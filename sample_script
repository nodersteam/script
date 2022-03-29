#!/bin/bash

while true
do

# Logo

echo "============================================================"
curl -s https://raw.githubusercontent.com/DenisRuziev/script/main/sample_script.sh | bash
echo "============================================================"


    
PS3='Select an action: '
options=(
"Prepare the server for installation"
"Install node"
"Set up your Incentive Program account"
"Show the Minima logs"
"Start the Minima service"
"Stop the Minima service"
"Exit")

select opt in "${options[@]}"
               do
                   case $opt in
                   
"Prepare the server for installation")
               echo "============================================================"
               echo "Preparation has begun"
               echo "============================================================"
sudo apt update && sudo apt upgrade && 
sudo apt install curl
               echo "============================================================"
               echo "The server is ready!"
               echo "============================================================"
break
;;
            
"Install node")

                echo "============================================================"
                echo "Set parameters"
                echo "============================================================"
                wget -O minima_cleanup_v98.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_cleanup_v98.sh && chmod +x minima_cleanup_v98.sh && sudo ./minima_cleanup_v98.sh
                wget -O minima_setup.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_setup.sh && chmod +x minima_setup.sh && sudo ./minima_setup.sh -r 9002 -p 9001
                echo "============================================================"
                echo "Installation complete!"
                echo "============================================================"
break
;;

"Set up your Incentive Program account")

               echo "============================================================"
               echo "Enter node id:"
               echo "============================================================"
read NODE_ID
echo 'export NODE_ID='${NODE_ID} >> $HOME/.bash_profile
source ~/.bash_profile
curl 127.0.0.1:9122/incentivecash%20uid:$NODE_ID
break
;;

"Show the Minima logs")
journalctl -u minima_9001 -f
break
;;



"Exit")
exit
;;

*) echo "invalid option $REPLY";;
esac
done
done
