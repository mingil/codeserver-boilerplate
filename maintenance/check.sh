#!/bin/bash
# 🏥 DTx Empire: Deep Diagnostic Tool (v3.2.1)
# 시스템의 모든 혈관(설정)을 검사하여 문제를 찾아냅니다.

# [Color Codes]
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}   🏥 DTx Empire System Diagnostic Report (v3.2.1)    ${NC}"
echo -e "${BLUE}======================================================${NC}"

FAIL_COUNT=0

check_status() {
    local name="$1"
    local status="$2"
    local detail="$3"
    
    if [ "$status" == "OK" ]; then
        printf "%-30s [${GREEN}PASS${NC}] %s\n" "$name" "$detail"
    else
        printf "%-30s [${RED}FAIL${NC}] %s\n" "$name" "$detail"
        ((FAIL_COUNT++))
    fi
}

check_warn() {
    printf "%-30s [${YELLOW}WARN${NC}] %s\n" "$1" "$2"
}

# [1] Shell & Terminal
echo -e "\n${YELLOW}🕵️  [1] Shell & Terminal Diagnostic${NC}"
[ -f ~/.zshrc ] && check_status ".zshrc file" "OK" "Found" || check_status ".zshrc file" "FAIL" "Missing"

if grep -q "POWERLEVEL9K_INSTANT_PROMPT=off" ~/.zshrc; then
    check_status "Instant Prompt Fix" "OK" "Disabled (Safe Mode)"
else
    check_status "Instant Prompt Fix" "FAIL" "Enabled (Risk)"
fi

if zsh -n ~/.zshrc 2>/dev/null; then
    check_status ".zshrc Syntax" "OK" "Valid syntax"
else
    check_status ".zshrc Syntax" "FAIL" "Syntax Error!"
fi

[ -d "$HOME/.oh-my-zsh" ] && check_status "Oh My Zsh" "OK" "Installed" || check_status "Oh My Zsh" "FAIL" "Not Installed"

# [2] VS Code
echo -e "\n${YELLOW}⚙️  [2] VS Code Configuration${NC}"
SETTINGS_FILE="/config/data/User/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
    if grep -q "terminal.integrated.cwd" "$SETTINGS_FILE"; then
        check_status "Terminal CWD Lock" "FAIL" "Found 'cwd' (Blocks folder open)"
    else
        check_status "Terminal CWD Lock" "OK" "Clean"
    fi
else
    check_warn "Settings.json" "Not found"
fi

# [3] AI & Python
echo -e "\n${YELLOW}�� [3] AI Environment Check${NC}"
PY_VER=$(python3 --version 2>&1)
check_status "Python Engine" "OK" "$PY_VER"

if python3 -c "import torch" 2>/dev/null; then
    TORCH_VER=$(python3 -c "import torch; print(torch.__version__)")
    check_status "PyTorch" "OK" "v$TORCH_VER Loaded"
else
    check_status "PyTorch" "FAIL" "Import Failed"
fi

if python3 -c "import cv2" 2>/dev/null; then
    check_status "OpenCV" "OK" "Loaded"
else
    check_status "OpenCV" "FAIL" "Import Failed"
fi

# [4] Permissions & Network
echo -e "\n${YELLOW}🛡️  [4] System Permissions${NC}"
[ "$(whoami)" == "abc" ] && check_status "User Identity" "OK" "abc" || check_status "User Identity" "FAIL" "Wrong User"
[ -w ~/workspace ] && check_status "Workspace Write" "OK" "Writable" || check_status "Workspace Write" "FAIL" "Read-only"

# [수정된 부분] Ping 대신 Curl 사용 (방화벽 우회 테스트)
if curl -s --head https://www.google.com | head -n 1 | grep "200\|301\|302" > /dev/null; then
    check_status "Internet (HTTP)" "OK" "Online"
else
    check_status "Internet (HTTP)" "FAIL" "Offline (Check Network)"
fi

echo -e "\n${BLUE}======================================================${NC}"
if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "✅  ${GREEN}SYSTEM HEALTHY. All Diagnostics Passed.${NC}"
else
    echo -e "❌  ${RED}SYSTEM ISSUES DETECTED: $FAIL_COUNT failures.${NC}"
    echo -e "    👉 Run: ${YELLOW}./maintenance/repair.sh${NC} to fix."
fi
echo -e "${BLUE}======================================================${NC}"
