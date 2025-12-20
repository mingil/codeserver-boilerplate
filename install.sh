#!/bin/bash
echo "🚀 [Boot] 부팅 스크립트 시작..."

# [1] 프로그램 설치 (먼저 실행해서 초기화 이슈 방지)
if ! command -v docker &> /dev/null; then
    echo "🔧 프로그램 설치 중..."
    apt-get update -qq
    apt-get install -y docker.io curl git zsh sudo nano procps > /dev/null
fi

# [2] Docker 소켓 권한
if [ -S /var/run/docker.sock ]; then
    chmod 666 /var/run/docker.sock
fi

# [3] 시놀로지 호환성 패치
if ! grep -q "DOCKER_API_VERSION" /home/abc/.zshrc 2>/dev/null; then
    echo "export DOCKER_API_VERSION=1.43" >> /config/.immortal_env/.zshrc
fi

# [4] Zsh 설정 복구
if [ -f /config/.immortal_env/.zshrc ]; then
    ln -sf /config/.immortal_env/.zshrc /home/abc/.zshrc
    ln -sf /config/.immortal_env/.p10k.zsh /home/abc/.p10k.zsh
    chsh -s /usr/bin/zsh abc
fi

# [5] Sudo 권한 강제 주입 (★핵심: 맨 마지막에 실행★)
echo "abc ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/abc
chmod 0440 /etc/sudoers.d/abc
echo "✅ [Boot] Sudo 비밀번호 제거 완료 (Final)"

echo "✨ [Boot] 환경 구축 종료"
