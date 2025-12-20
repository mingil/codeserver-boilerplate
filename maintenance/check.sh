#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}🛡️ [DTx Empire] FINAL SYSTEM AUDIT REPORT${NC}"
echo -e "${BLUE}======================================================${NC}"

# 1. 시스템 기초 (Shell)
if [[ "$SHELL" == *"zsh"* ]]; then echo -e "${GREEN}✅ [SHELL]   Pass${NC} : Zsh Active"; else echo -e "${RED}❌ [SHELL]   Fail${NC}"; fi

# 2. 보안 점검 (Sudo 비밀번호 필수)
if ! sudo -n true 2>/dev/null; then
    echo -e "${GREEN}✅ [SECURE]  Pass${NC} : Password Protection Active (Safe)"
else
    echo -e "${RED}❌ [SECURE]  Fail${NC} : Password-less access detected (Risky)"
fi

# 3. 도커 인프라
if docker ps &> /dev/null; then
    if [[ "$DOCKER_API_VERSION" == "1.43" ]]; then
        echo -e "${GREEN}✅ [DOCKER]  Pass${NC} : Daemon Connected (API v1.43)"
    else
        echo -e "${RED}❌ [DOCKER]  Fail${NC} : API Version Mismatch"
    fi
else
    echo -e "${RED}❌ [DOCKER]  Fail${NC} : Daemon Down"
fi

# 4. 불멸성 (부팅 스크립트)
if [ -x "/config/custom-cont-init.d/99-install-packages.sh" ]; then
    echo -e "${GREEN}✅ [HOOK]    Pass${NC} : Boot Script Ready"
else
    echo -e "${RED}❌ [HOOK]    Fail${NC} : Boot Script Missing"
fi

# 5. 개발 도구 (Python & VS Code)
if command -v python3 &>/dev/null; then
    echo -e "${GREEN}✅ [PYTHON]  Pass${NC} : $(python3 --version)"
else
    echo -e "${RED}❌ [PYTHON]  Fail${NC} : Python Missing"
fi

echo -n "Checking Extensions... "
if code-server --list-extensions 2>/dev/null | grep -q "ms-python.python"; then
    echo -e "${GREEN}✅ [VSCODE]  Pass${NC} : Python Extension Installed"
else
    echo -e "${YELLOW}⚠️ [VSCODE]  Warn${NC} : Python Extension Not Found (Install via GUI recommended)"
fi

# 6. 백업 상태 (Git)
cd ~/workspace/codeserver-boilerplate
if git status &>/dev/null; then
    if git diff --quiet && git diff --staged --quiet; then
        echo -e "${GREEN}✅ [GIT]     Pass${NC} : Repository Clean (Synced)"
    else
        echo -e "${YELLOW}⚠️ [GIT]     Warn${NC} : Uncommitted changes exist"
    fi
else
    echo -e "${RED}❌ [GIT]     Fail${NC} : Not a Git Repository"
fi

echo -e "${BLUE}======================================================${NC}"
echo -e "모든 항목이 ${GREEN}Pass${NC} (또는 Git Warn)라면 완벽합니다."
