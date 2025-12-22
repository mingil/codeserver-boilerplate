#!/bin/bash
# 🏥 DTx Empire: Deep Diagnostic Tool (v3.2)
# 시스템의 모든 혈관(설정)을 검사하여 문제를 찾아냅니다.

# [Color Codes]
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}   �� DTx Empire System Diagnostic Report (v3.2)      ${NC}"
echo -e "${BLUE}======================================================${NC}"

FAIL_COUNT=0

# 함수: 상태 출력
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

# ---------------------------------------------------
# [1] Zsh & Terminal (최근 가장 문제였던 부분)
# ---------------------------------------------------
echo -e "\n${YELLOW}🕵️  [1] Shell & Terminal Diagnostic${NC}"

# 1.1 .zshrc 존재 여부
if [ -f ~/.zshrc ]; then
    check_status ".zshrc file" "OK" "Found"
else
    check_status ".zshrc file" "FAIL" "File missing!"
fi

# 1.2 Instant Prompt (터미널 꼬임의 주범)
if grep -q "POWERLEVEL9K_INSTANT_PROMPT=off" ~/.zshrc; then
    check_status "Instant Prompt Fix" "OK" "Disabled (Safe Mode)"
else
    check_status "Instant Prompt Fix" "FAIL" "Enabled (Risk of terminal freeze)"
fi

# 1.3 .zshrc 문법 오류 검사 (zsh -n)
if zsh -n ~/.zshrc 2>/dev/null; then
    check_status ".zshrc Syntax" "OK" "Valid syntax"
else
    check_status ".zshrc Syntax" "FAIL" "Syntax Error detected!"
fi

# 1.4 Oh My Zsh 설치 여부
if [ -d "$HOME/.oh-my-zsh" ]; then
    check_status "Oh My Zsh" "OK" "Installed"
else
    check_status "Oh My Zsh" "FAIL" "Not Installed"
fi

# ---------------------------------------------------
# [2] VS Code Settings (숨겨진 범인 찾기)
# ---------------------------------------------------
echo -e "\n${YELLOW}⚙️  [2] VS Code Configuration${NC}"
SETTINGS_FILE="/config/data/User/settings.json"

if [ -f "$SETTINGS_FILE" ]; then
    # 2.1 강제 경로 이동 설정 (범인)
    if grep -q "terminal.integrated.cwd" "$SETTINGS_FILE"; then
        check_status "Terminal CWD Lock" "FAIL" "Found 'cwd' setting (Blocks folder open)"
    else
        check_status "Terminal CWD Lock" "OK" "Clean (No hardcoded path)"
    fi
    
    # 2.2 로그인 쉘 해제 설정 (해결사)
    # JSON 파싱이 어려우므로 args: [] 패턴을 단순 검색
    if grep -q '"args": \[\]' "$SETTINGS_FILE" || grep -q '"args": \[\s*\]' "$SETTINGS_FILE"; then
        check_status "Login Shell Fix" "OK" "Applied (args: [])"
    else
        check_warn "Login Shell Fix" "Not found (Consider applying if path issues persist)"
    fi
else
    check_warn "Settings.json" "Not found (Fresh install?)"
fi

# ---------------------------------------------------
# [3] AI & Python Engine
# ---------------------------------------------------
echo -e "\n${YELLOW}🧠 [3] AI Environment Check${NC}"

# 3.1 Python Version
PY_VER=$(python3 --version 2>&1)
check_status "Python Engine" "OK" "$PY_VER"

# 3.2 Key Libraries Import Test
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

# ---------------------------------------------------
# [4] Permissions & System
# ---------------------------------------------------
echo -e "\n${YELLOW}🛡️  [4] System Permissions${NC}"

# 4.1 User Check
CURRENT_USER=$(whoami)
if [ "$CURRENT_USER" == "abc" ]; then
    check_status "User Identity" "OK" "Running as 'abc'"
else
    check_status "User Identity" "FAIL" "Running as '$CURRENT_USER' (Should be 'abc')"
fi

# 4.2 Workspace Permission
if [ -w ~/workspace ]; then
    check_status "Workspace Write" "OK" "Writable"
else
    check_status "Workspace Write" "FAIL" "Read-only (Permission Error)"
fi

# 4.3 Internet Connectivity
if ping -c 1 google.com >/dev/null 2>&1; then
    check_status "Internet" "OK" "Online"
else
    check_status "Internet" "FAIL" "Offline"
fi

# ---------------------------------------------------
# [5] Final Summary
# ---------------------------------------------------
echo -e "\n${BLUE}======================================================${NC}"
if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "✅  ${GREEN}SYSTEM HEALTHY. All Diagnostics Passed.${NC}"
else
    echo -e "❌  ${RED}SYSTEM ISSUES DETECTED: $FAIL_COUNT failures.${NC}"
    echo -e "    👉 Run: ${YELLOW}./maintenance/repair.sh${NC} to fix automatically."
fi
echo -e "${BLUE}======================================================${NC}"
