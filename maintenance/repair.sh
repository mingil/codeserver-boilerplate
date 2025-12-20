#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
echo -e "${YELLOW}🚑 [DTx Maintenance] REPAIR SYSTEM...${NC}"
# Sudo 복구
if sudo -n true 2>/dev/null; then
    echo "✅ Sudo 정상"
else
    echo "🔧 Sudo 권한 복구 시도 (Root 비번 필요)..."
    su -c "echo 'abc ALL=(ALL) ALL' > /etc/sudoers.d/abc && chmod 0440 /etc/sudoers.d/abc"
fi
# Docker 소켓 복구
if [ -S /var/run/docker.sock ]; then
    sudo chmod 666 /var/run/docker.sock && echo "✅ Docker 소켓 권한 복구"
fi
echo -e "${GREEN}✨ 복구 완료${NC}"
