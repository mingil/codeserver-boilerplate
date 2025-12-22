#!/bin/bash
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
INSTALL_SCRIPT="$SCRIPT_DIR/../install.sh"
echo "🚑 [Repair] 시스템 자가 복구 (v3.1 Final) 시작..."
[ -S /var/run/docker.sock ] && sudo chmod 666 /var/run/docker.sock
sudo find /config/workspace -name "#snapshot" -prune -o -exec chown -h abc:abc {} + 2>/dev/null
echo "⚡ Zsh 설정 보정 (Instant Prompt Off)..."
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    if ! grep -q "POWERLEVEL9K_INSTANT_PROMPT=off" "$ZSHRC"; then
        sed -i '1i typeset -g POWERLEVEL9K_INSTANT_PROMPT=off' "$ZSHRC"
    fi
    if ! grep -q "ZSH_DISABLE_COMPFIX" "$ZSHRC"; then
        sed -i '1i ZSH_DISABLE_COMPFIX=\"true\"' "$ZSHRC"
    fi
fi
if [ -f "$INSTALL_SCRIPT" ]; then
    bash "$INSTALL_SCRIPT" > /dev/null 2>&1
fi
git config --global credential.helper store
unset GIT_ASKPASS
echo "✅ [완료] 시스템 정상화."
