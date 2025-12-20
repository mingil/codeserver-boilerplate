#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🚑 [DTx Maintenance] 시스템 자가 복구(Repair)를 시작합니다...${NC}"

# 1. Sudo 권한 상실 시 복구 시도
# (현재 사용자가 sudo를 못 쓰면, su root를 시도하거나 안내함)
if ! sudo -n true 2>/dev/null; then
    echo -e "${RED}⚠️ Sudo 권한 문제 감지!${NC}"
    echo "관리자(Root) 비밀번호를 입력하면 권한을 복구합니다."
    su -c "
        echo 'abc ALL=(ALL) ALL' > /etc/sudoers.d/abc
        chmod 0440 /etc/sudoers.d/abc
        echo '${GREEN}✅ Sudo 권한 파일 재생성 완료${NC}'
    "
else
    echo -e "${GREEN}✅ Sudo 권한 정상${NC}"
fi

# 2. Docker 소켓 권한 복구
if [ -S /var/run/docker.sock ]; then
    CURRENT_PERM=$(stat -c "%a" /var/run/docker.sock)
    if [ "$CURRENT_PERM" != "666" ]; then
        echo -e "${YELLOW}🔧 Docker 소켓 권한 수정 중...${NC}"
        sudo chmod 666 /var/run/docker.sock
        echo -e "${GREEN}✅ Docker 소켓 복구 완료${NC}"
    else
        echo -e "${GREEN}✅ Docker 소켓 정상${NC}"
    fi
else
    echo -e "${RED}❌ Docker 소켓이 없습니다. 호스트의 /var/run/docker.sock이 마운트되었는지 확인하세요.${NC}"
fi

# 3. Git 사용자 설정 복구 (없으면 다시 묻기)
if [ -z "$(git config --global user.name)" ]; then
    echo -e "${YELLOW}🔧 Git 사용자 정보가 없습니다.${NC}"
    read -p "GitHub 사용자명(User Name) 입력: " GIT_USER
    read -p "GitHub 이메일(Email) 입력: " GIT_EMAIL
    git config --global user.name "$GIT_USER"
    git config --global user.email "$GIT_EMAIL"
    echo -e "${GREEN}✅ Git 설정 완료${NC}"
fi

echo -e "${GREEN}✨ 모든 복구 작업이 완료되었습니다. maintenance/check.sh를 실행해 보세요.${NC}"
