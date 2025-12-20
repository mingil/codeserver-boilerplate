#!/bin/bash
echo "Code-Server Boilerplate Setup..."

mkdir -p /config/custom-cont-init.d
mkdir -p /config/.immortal_env
mkdir -p /config/data/User

cp ./scripts/init_hook.sh /config/custom-cont-init.d/99-install-packages.sh
chmod +x /config/custom-cont-init.d/99-install-packages.sh

cp ./config/.zshrc /config/.immortal_env/.zshrc
cp ./config/.p10k.zsh /config/.immortal_env/.p10k.zsh
ln -sf /config/.immortal_env/.zshrc ~/.zshrc
ln -sf /config/.immortal_env/.p10k.zsh ~/.p10k.zsh

cp ./config/settings.json /config/data/User/settings.json

echo "Complete. Please restart container."
