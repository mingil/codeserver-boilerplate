#!/bin/bash
echo "🔄 [System Hook] 개발 환경 복구 및 권한 강제 탈취 중..."

# A. 패키지 설치 (기존 유지)
apt-get update -qq
apt-get install -y -qq \
    zsh git curl wget fontconfig locales \
    htop jq net-tools iputils-ping \
    python3 python3-pip python3-dev build-essential python3-venv > /dev/null
locale-gen en_US.UTF-8 > /dev/null

# B. [핵심] /etc/sudoers 파일 직접 수정
# 중복 추가 방지를 위해 grep으로 확인 후 없으면 추가
if ! grep -q "abc ALL=(ALL) NOPASSWD: ALL" /etc/sudoers; then
    echo "" >> /etc/sudoers
    echo "# FORCE NOPASSWD FOR ABC USER" >> /etc/sudoers
    echo "abc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    echo "🔓 메인 sudoers 파일에 권한 강제 주입 완료"
fi

# C. 기본 쉘 변경
usermod -s /bin/zsh abc

echo "✅ 시스템 초기화 완료"
