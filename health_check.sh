#!/bin/bash

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}🏥 [DTx Empire] System Health Diagnostic Tool v1.0${NC}"
echo -e "${BLUE}======================================================${NC}"
echo "Diagnosing system components..."
echo ""

# 1. SHELL Check (Zsh 여부)
if [[ "$SHELL" == *"zsh"* ]] || [[ "$0" == *"zsh"* ]]; then
    echo -e "${GREEN}✅ [SHELL]   Pass${NC} : Zsh is active"
else
    echo -e "${RED}❌ [SHELL]   Fail${NC} : Current shell is not Zsh ($SHELL)"
fi

# 2. SUDO Check (비밀번호 없는 권한)
if sudo -n true 2>/dev/null; then
    echo -e "${GREEN}✅ [SUDO]    Pass${NC} : Root access without password"
else
    echo -e "${RED}❌ [SUDO]    Fail${NC} : Password required or permission denied"
fi

# 3. GIT Check (계정 설정 및 연결)
GIT_NAME=$(git config --global user.name)
if [ -n "$GIT_NAME" ]; then
    echo -e "${GREEN}✅ [GIT]     Pass${NC} : User configured as '$GIT_NAME'"
else
    echo -e "${RED}❌ [GIT]     Fail${NC} : Git user identity not set"
fi

# 4. PYTHON Check (가상환경 및 도구)
if command -v black &> /dev/null; then
    BLACK_VER=$(black --version | head -n 1 | awk '{print $2}')
    echo -e "${GREEN}✅ [PYTHON]  Pass${NC} : Black formatter installed ($BLACK_VER)"
else
    echo -e "${RED}❌ [PYTHON]  Fail${NC} : Black formatter not found"
fi

# 5. DOCKER Check (핵심: 소켓 권한 및 버전 호환성)
if docker ps &> /dev/null; then
    echo -e "${GREEN}✅ [DOCKER]  Pass${NC} : Docker CLI & Socket connected"
    
    # API 버전 체크 (시놀로지 호환성)
    if [[ "$DOCKER_API_VERSION" == "1.43" ]]; then
        echo -e "${GREEN}✅ [COMPAT]  Pass${NC} : API Version Fixed to 1.43 (Synology Safe)"
    else
        echo -e "${RED}❌ [COMPAT]  Fail${NC} : API Version mismatch (Current: $DOCKER_API_VERSION)"
        echo -e "   -> Hint: export DOCKER_API_VERSION=1.43 needed"
    fi
else
    echo -e "${RED}❌ [DOCKER]  Fail${NC} : Cannot connect to Docker Daemon"
fi

# 6. PERSISTENCE Check (부팅 스크립트 존재 여부)
if [ -f "/config/custom-cont-init.d/99-install-packages.sh" ]; then
    echo -e "${GREEN}✅ [HOOK]    Pass${NC} : Boot script exists (Immortal enabled)"
else
    echo -e "${RED}❌ [HOOK]    Fail${NC} : Boot script missing! (Risk of data loss)"
fi

echo ""
echo -e "${BLUE}======================================================${NC}"
echo -e "Diagnosis Complete."
