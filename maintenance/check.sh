#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

echo "🛡️ [DTx Maintenance] SYSTEM CHECK (v2.2 Final)"
echo "---------------------------------------------------"
# [1] 인프라
echo -n "🖥️  System Infra : "
[[ "$SHELL" == *"zsh"* ]] && [ -S /var/run/docker.sock ] && echo -e "${GREEN}Pass${NC}" || echo -e "${RED}Fail${NC}"

# [2] AI 엔진
echo -n "🧠 AI Engine    : "
python3 -c "import torch, cv2" 2>/dev/null && echo -e "${GREEN}Pass${NC}" || echo -e "${RED}Fail${NC}"

# [3] Codeium (확장 프로그램)
echo -n "🧩 Extensions   : "
code-server --list-extensions | grep -q "codeium" && echo -e "${GREEN}Pass${NC}" || echo -e "${RED}Fail${NC}"

echo "---------------------------------------------------"
