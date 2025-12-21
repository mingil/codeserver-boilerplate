#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 스크립트가 위치한 실제 경로 파악 (어디서 실행하든 유지보수 폴더 위치를 찾음)
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
REPAIR_KIT="$SCRIPT_DIR/repair.sh"

echo -e "${BLUE}🛡️ [DTx Maintenance] SYSTEM STATUS CHECK (v2.1 Final)${NC}"
echo "---------------------------------------------------"

# [1] 시스템 인프라
echo -n "🖥️  System Infra : "
if [[ "$SHELL" == *"zsh"* ]] && [ -S /var/run/docker.sock ]; then
    echo -e "${GREEN}Pass${NC} (Zsh + Docker)"
else
    echo -e "${RED}Fail${NC} (Check Shell or Docker Socket)"
fi

# [2] 보안 설정
echo -n "🔒 Security     : "
if ! sudo -n true 2>/dev/null; then
    echo -e "${GREEN}Pass${NC} (Sudo Password Active)"
else
    echo -e "${RED}Fail${NC} (Insecure: Password-less Sudo)"
fi

# [3] AI 엔진 (Python & PyTorch)
echo -n "🧠 AI Engine    : "
if python3 -c "import torch, pandas, sklearn" 2>/dev/null; then
    VER=$(python3 -c "import torch; print(torch.__version__)")
    echo -e "${GREEN}Pass${NC} (PyTorch $VER Ready)"
else
    echo -e "${RED}Fail${NC} (AI Libraries Missing)"
fi

# [4] 복구 키트 존재 여부 (절대 경로로 확인)
echo -n "🚑 Repair Kit   : "
if [ -x "$REPAIR_KIT" ]; then
    echo -e "${GREEN}Ready${NC}"
else
    echo -e "${YELLOW}Missing${NC} (Path: $REPAIR_KIT)"
fi

echo "---------------------------------------------------"
if [ $? -eq 0 ]; then
    echo -e "✅ System is healthy. Ready for Research."
else
    echo -e "⚠️ Issues found. Run '$REPAIR_KIT'"
fi
