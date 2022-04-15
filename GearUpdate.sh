#!/bin/bash

while true
do

# Logo

echo "============================================================"
*logo* | bash
echo "============================================================"


    
PS3='Select an action: '
options=(
"Update Gear"
"Exit")

select opt in "${options[@]}"
               do
                   case $opt in
                   
"Update Gear")
               echo "============================================================"
               echo "Update has begun"
               echo "============================================================"
rm gear-node
wget https://builds.gear.rs/gear-nightly-linux-x86_64.tar.xz && \ tar xvf gear-nightly-linux-x86_64.tar.xz && \ rm gear-nightly-linux-x86_64.tar.xz && \ chmod +x gear-node
sudo apt install -y clang build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup toolchain add nightly 
rustup target add wasm32-unknown-unknown --toolchain nightly
git clone https://github.com/gear-tech/gear.git
cd gear
cargo build -p gear-node --release
sudo systemctl restart gear-node
               echo "============================================================"
               echo "Update complete!"
               echo "============================================================"
break
;;

"Exit")
exit
;;

*) echo "invalid option $REPLY";;
esac
done
done
