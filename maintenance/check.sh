#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
REPAIR_KIT="$SCRIPT_DIR/repair.sh"

echo -e "${BLUE}🛡️ [DTx Maintenance] SYSTEM PRECISION CHECK (v2.3 Sync)${NC}"
echo "-------------------------------------------------------------"

# [1] System Utilities (FFmpeg 등 필수 도구 확인)
echo -n "🛠️  System Tools   : "
if which ffmpeg > /dev/null 2>&1 && which git > /dev/null 2>&1; then
    echo -e "${GREEN}Pass${NC} (FFmpeg & Git Ready)"
else
    echo -e "${RED}Fail${NC} (Essential Tools Missing)"
fi

# [2] AI & Data Science Core (라이브러리 정밀 검사)
echo -n "🧠 AI/Data Stack  : "
# PyTorch, OpenCV, Pandas, Scikit-learn, Matplotlib 일괄 임포트 테스트
if python3 -c "import torch, cv2, pandas, sklearn, matplotlib.pyplot" 2>/dev/null; then
    VER=$(python3 -c "import torch; print(torch.__version__)")
    echo -e "${GREEN}Pass${NC} (PyTorch $VER + Full DS Stack)"
else
    echo -e "${RED}Fail${NC} (Python Libraries Incomplete)"
fi

# [3] VS Code Extensions (확장 프로그램 확인)
echo -n "🧩 VS Extensions  : "
EXT_LIST=$(code-server --list-extensions)
if echo "$EXT_LIST" | grep -q "codeium" && echo "$EXT_LIST" | grep -q "python"; then
    echo -e "${GREEN}Pass${NC} (Codeium AI + Python Active)"
else
    echo -e "${RED}Fail${NC} (Essential Extensions Missing)"
fi

# [4] Repair Kit Integrity
echo -n "🚑 Repair Kit     : "
if [ -x "$REPAIR_KIT" ]; then
    echo -e "${GREEN}Ready${NC}"
else
    echo -e "${RED}Missing${NC}"
fi

echo "-------------------------------------------------------------"
if [ $? -eq 0 ]; then
    echo -e "✅ All Systems Operational. Ready for Clinical Research."
else
    echo -e "⚠️ Issues Detected. Run '$REPAIR_KIT' to fix."
fi
