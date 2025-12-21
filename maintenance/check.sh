#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
REPAIR_KIT="$SCRIPT_DIR/repair.sh"
ALL_PASS=true  # 상태 추적 변수 추가

echo -e "${BLUE}🛡️ [DTx Maintenance] SYSTEM PRECISION CHECK (v2.4 Logic Fix)${NC}"
echo "-------------------------------------------------------------"

# [1] System Utilities
echo -n "🛠️  System Tools   : "
if which ffmpeg > /dev/null 2>&1 && which git > /dev/null 2>&1; then
    echo -e "${GREEN}Pass${NC} (FFmpeg & Git Ready)"
else
    echo -e "${RED}Fail${NC} (Essential Tools Missing)"
    ALL_PASS=false
fi

# [2] AI & Data Science Core
echo -n "🧠 AI/Data Stack  : "
if python3 -c "import torch, cv2, pandas, sklearn, matplotlib.pyplot" 2>/dev/null; then
    VER=$(python3 -c "import torch; print(torch.__version__)")
    echo -e "${GREEN}Pass${NC} (PyTorch $VER + Full DS Stack)"
else
    echo -e "${RED}Fail${NC} (Python Libraries Incomplete)"
    ALL_PASS=false
fi

# [3] VS Code Extensions
echo -n "🧩 VS Extensions  : "
EXT_LIST=$(code-server --list-extensions)
if echo "$EXT_LIST" | grep -q "codeium" && echo "$EXT_LIST" | grep -q "python"; then
    echo -e "${GREEN}Pass${NC} (Codeium AI + Python Active)"
else
    echo -e "${RED}Fail${NC} (Essential Extensions Missing)"
    ALL_PASS=false
fi

# [4] Repair Kit Integrity
echo -n "🚑 Repair Kit     : "
if [ -x "$REPAIR_KIT" ]; then
    echo -e "${GREEN}Ready${NC}"
else
    echo -e "${RED}Missing${NC}"
    ALL_PASS=false
fi

echo "-------------------------------------------------------------"
# 최종 판단 로직 수정 (하나라도 실패하면 경고)
if [ "$ALL_PASS" = true ]; then
    echo -e "✅ All Systems Operational. Ready for Clinical Research."
else
    echo -e "⚠️ Issues Detected. SYSTEM IS NOT READY."
    echo -e "👉 Please run: $REPAIR_KIT"
    exit 1
fi
