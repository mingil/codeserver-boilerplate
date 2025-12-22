#!/bin/bash
GREEN='\033[0;32m'; RED='\033[0;31m'; NC='\033[0m'
REPAIR_KIT=$(dirname "$(readlink -f "$0")")/repair.sh
ALL_PASS=true

echo "🛡️ [DTx Maintenance] SYSTEM DIAGNOSTIC (v3.0)"
echo "---------------------------------------------------"

# [1] System Tools Check
echo -n "🛠️  System Tools   : "
if which ffmpeg >/dev/null && which git >/dev/null; then
    echo -e "${GREEN}Pass${NC}"
else
    echo -e "${RED}Fail${NC} (FFmpeg/Git Missing)"; ALL_PASS=false
fi

# [2] AI Engine Check
echo -n "🧠 AI/Data Stack  : "
if python3 -c "import torch, cv2, pandas" 2>/dev/null; then
    echo -e "${GREEN}Pass${NC}"
else
    echo -e "${RED}Fail${NC} (Libs Missing)"; ALL_PASS=false
fi

# [3] Extensions Check
echo -n "🧩 VS Extensions  : "
if code-server --list-extensions | grep -q "codeium"; then
    echo -e "${GREEN}Pass${NC}"
else
    echo -e "${RED}Fail${NC} (Plugins Missing)"; ALL_PASS=false
fi

echo "---------------------------------------------------"
if [ "$ALL_PASS" = true ]; then
    echo -e "✅ All Systems Operational."
else
    echo -e "⚠️ Issues Detected. Run: $REPAIR_KIT"
    exit 1
fi
