#!/bin/bash
# DTx Empire: Immortal Boot Script (AI Pro Edition - Final Fix)

echo "🚀 [Boot] AI Data Science 환경 재구축 시작..."

# [1] 시스템 기본 유틸리티 설치
echo "📦 System Utilities 설치 중..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y git-lfs tree htop jq fontconfig > /dev/null

# [2] Pip 설치 (파일로 다운로드 후 실행 - 가장 확실한 방법)
if ! command -v pip &> /dev/null; then
    echo "💉 Pip 설치 파일 다운로드 중..."
    curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    
    echo "💉 Pip 설치 실행..."
    # 1차 시도: 최신 방식 (시스템 패키지 보호 해제)
    python3 get-pip.py --break-system-packages >/dev/null 2>&1
    
    # 2차 시도: 실패 시 구형 방식 (옵션 없이)
    if [ $? -ne 0 ]; then
        python3 get-pip.py >/dev/null 2>&1
    fi
    rm get-pip.py
fi

# [3] 권한 복구
if [ -S /var/run/docker.sock ]; then chmod 666 /var/run/docker.sock; fi

# [4] Python AI 라이브러리 설치
echo "🐍 Python AI Library 설치 중..."

# Pip 명령어 정의 (python3 -m pip가 더 안전함)
PIP_CMD="python3 -m pip"

# 필수 패키지 설치
$PIP_CMD install --upgrade pip --break-system-packages > /dev/null 2>&1
$PIP_CMD install --no-cache-dir --break-system-packages \
    numpy pandas matplotlib seaborn scikit-learn \
    jupyterlab notebook \
    black isort flake8 mypy \
    tqdm rich > /dev/null 2>&1

# PyTorch (CPU 버전)
if ! python3 -c "import torch" 2>/dev/null; then
    echo "🔥 PyTorch (CPU) 설치 중 (최대 3분 소요)..."
    $PIP_CMD install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
fi

# [5] Zsh 설정
mkdir -p /home/abc
if [ -f /config/.immortal_env/.zshrc ]; then
    ln -sf /config/.immortal_env/.zshrc /home/abc/.zshrc
    ln -sf /config/.immortal_env/.p10k.zsh /home/abc/.p10k.zsh
    chsh -s /usr/bin/zsh abc
fi

echo "✅ [Boot] AI Pro 환경 준비 완료."
