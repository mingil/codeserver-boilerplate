#!/bin/bash
# DTx Empire: Immortal Boot Script (AI Pro Edition - Fixed)

echo "�� [Boot] AI Data Science 환경 구축 시작..."

# [1] 시스템 기본 패키지 및 PIP 설치 (관리자 권한 필수)
# (python3-pip와 python3-venv를 명시적으로 추가)
echo "📦 System Utilities & Pip 설치 중..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y docker.io curl git zsh sudo procps git-lfs tree htop jq fontconfig python3-pip python3-venv > /dev/null

# [2] 권한 및 설정 복구
if [ -S /var/run/docker.sock ]; then chmod 666 /var/run/docker.sock; fi

# [3] Python AI 라이브러리 설치
echo "🐍 Python AI Library 동기화..."
# pip 업그레이드 (Break System Packages 방지 옵션 추가)
python3 -m pip install --upgrade pip --break-system-packages > /dev/null

# 필수 패키지 설치
python3 -m pip install --no-cache-dir --break-system-packages \
    numpy pandas matplotlib seaborn scikit-learn \
    jupyterlab notebook \
    black isort flake8 mypy \
    tqdm rich > /dev/null 2>&1

# PyTorch (CPU 버전)
if ! python3 -c "import torch" 2>/dev/null; then
    echo "🔥 PyTorch (CPU) 설치 중 (최대 3분 소요)..."
    python3 -m pip install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
fi

# [4] Zsh 설정 (폴더가 없으면 생성)
mkdir -p /home/abc
if [ -f /config/.immortal_env/.zshrc ]; then
    ln -sf /config/.immortal_env/.zshrc /home/abc/.zshrc
    ln -sf /config/.immortal_env/.p10k.zsh /home/abc/.p10k.zsh
    chsh -s /usr/bin/zsh abc
fi

echo "✅ [Boot] AI Pro 환경 준비 완료."
