#!/bin/bash

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}🏥 [DTx Empire] Final System Integrity Check${NC}"
echo -e "${BLUE}======================================================${NC}"

# 1. SHELL (Zsh 엔진)
if [[ "$SHELL" == *"zsh"* ]]; then
    echo -e "${GREEN}✅ [SHELL]   Pass${NC} : Zsh Active"
else
    echo -e "${RED}❌ [SHELL]   Fail${NC} : Not running Zsh"
fi

# 2. PYTHON (버전 및 포매터)
if command -v python3 &>/dev/null && command -v black &>/dev/null; then
    PY_VER=$(python3 --version)
    echo -e "${GREEN}✅ [PYTHON]  Pass${NC} : $PY_VER & Black Installed"
else
    echo -e "${RED}❌ [PYTHON]  Fail${NC} : Python or Black missing"
fi

# 3. DOCKER (연결 확인)
if docker ps &> /dev/null; then
    echo -e "${GREEN}✅ [DOCKER]  Pass${NC} : Daemon Connected"
else
    echo -e "${RED}❌ [DOCKER]  Fail${NC} : Cannot connect to Docker"
fi

# 4. COMPATIBILITY (시놀로지 버전 패치)
if [[ "$DOCKER_API_VERSION" == "1.43" ]]; then
    echo -e "${GREEN}✅ [COMPAT]  Pass${NC} : API v1.43 (Synology Optimized)"
else
    echo -e "${RED}❌ [COMPAT]  Fail${NC} : API Version Mismatch ($DOCKER_API_VERSION)"
fi

# 5. PERSISTENCE (부팅 스크립트 생존 여부)
if [ -x "/config/custom-cont-init.d/99-install-packages.sh" ]; then
    echo -e "${GREEN}✅ [HOOK]    Pass${NC} : Boot Script Found & Executable"
else
    echo -e "${RED}❌ [HOOK]    Fail${NC} : Boot Script Missing or Not Executable"
fi

# 6. SECURITY (Sudo 비밀번호 활성화 확인)
# 비밀번호 없이 sudo를 시도해서 '실패'해야 정상(Pass)입니다.
if ! sudo -n true 2>/dev/null; then
    echo -e "${GREEN}✅ [SECURE]  Pass${NC} : Password Protection Active (Standard)"
else
    echo -e "${YELLOW}⚠️ [SECURE]  Warn${NC} : Password-less access still active (Check /etc/sudoers)"
fi

# 7. GIT (사용자 설정)
if [ -n "$(git config --global user.name)" ]; then
    echo -e "${GREEN}✅ [GIT]     Pass${NC} : Identity Set ($(git config --global user.name))"
else
    echo -e "${RED}❌ [GIT]     Fail${NC} : User identity missing"
fi

echo -e "${BLUE}======================================================${NC}"
echo -e "검사 완료. 모든 항목이 ${GREEN}Pass${NC}라면 환경 구축 종료입니다."
