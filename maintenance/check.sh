#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
REPAIR_KIT="$SCRIPT_DIR/repair.sh"
ALL_PASS=true

echo -e "${BLUE}🛡️ [DTx Maintenance] SYSTEM DIAGNOSTIC REPORT (v3.0)${NC}"
echo "-------------------------------------------------------------"

# [Item 1] System Tools (FFmpeg, Git)
echo -n "🛠️  System Tools   : "
if which ffmpeg > /dev/null 2>&1 && which git > /dev/null 2>&1; then
    echo -e "${GREEN}Pass${NC} (FFmpeg & Git Ready)"
else
    echo -e "${RED}Fail${NC} (Missing FFmpeg or Git)"
    ALL_PASS=false
fi

# [Item 2] AI Core (Python Libraries)
echo -n "🧠 AI/Data Stack  : "
if python3 -c "import torch, cv2, pandas, sklearn" 2>/dev/null; then
    VER=$(python3 -c "import torch; print(torch.__version__)")
    echo -e "${GREEN}Pass${NC} (PyTorch $VER + Full Stack)"
else
    echo -e "${RED}Fail${NC} (Libraries Damaged/Missing)"
    ALL_PASS=false
fi

# [Item 3] IDE Extensions
echo -n "🧩 VS Extensions  : "
EXT_LIST=$(code-server --list-extensions)
if echo "$EXT_LIST" | grep -q "codeium"; then
    echo -e "${GREEN}Pass${NC} (AI Assistant Active)"
else
    echo -e "${RED}Fail${NC} (Codeium Missing)"
    ALL_PASS=false
fi

# [Item 4] Recovery System
echo -n "🚑 Repair Kit     : "
if [ -x "$REPAIR_KIT" ]; then
    echo -e "${GREEN}Ready${NC}"
else
    echo -e "${RED}Missing${NC}"
    ALL_PASS=false
fi

echo "-------------------------------------------------------------"
if [ "$ALL_PASS" = true ]; then
    echo -e "✅ All Systems Operational. Infrastructure is Healthy."
else
    echo -e "⚠️ Issues Detected. Please run repair script immediately."
    echo -e "👉 Command: $REPAIR_KIT"
    exit 1
fi
