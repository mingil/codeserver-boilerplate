#!/bin/bash
# DTx Empire: Immortal Boot Script (AI Pro Edition)

echo "🚀 [Boot] AI Data Science 환경 구축 시작..."

# [1] 시스템 기본 패키지 설치 (git-lfs, htop 등 추가)
if ! command -v git-lfs &> /dev/null; then
    echo "📦 System Utilities 설치 중..."
    apt-get update -qq
    apt-get install -y docker.io curl git zsh sudo procps git-lfs tree htop jq fontconfig > /dev/null
fi

# [2] 권한 및 설정 복구
if [ -S /var/run/docker.sock ]; then chmod 666 /var/run/docker.sock; fi

# [3] Python AI 라이브러리 설치 (부팅 시마다 체크)
# (이미 설치되어 있으면 빠르게 건너뜀)
echo "🐍 Python AI Library 동기화..."
pip install --upgrade pip > /dev/null
# 필수 데이터 사이언스 패키지
pip install --no-cache-dir \
    numpy pandas matplotlib seaborn scikit-learn \
    jupyterlab notebook \
    black isort flake8 mypy \
    tqdm rich > /dev/null 2>&1

# PyTorch (시놀로지 NAS용 CPU 버전 - 용량 절약 및 속도 최적화)
if ! python3 -c "import torch" 2>/dev/null; then
    echo "🔥 PyTorch (CPU) 설치 중 (시간이 조금 걸립니다)..."
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
fi

# [4] Zsh 및 환경설정 링크
if [ -f /config/.immortal_env/.zshrc ]; then
    ln -sf /config/.immortal_env/.zshrc /home/abc/.zshrc
    ln -sf /config/.immortal_env/.p10k.zsh /home/abc/.p10k.zsh
    chsh -s /usr/bin/zsh abc
fi

# [5] Docker 호환성
if ! grep -q "DOCKER_API_VERSION" /config/.immortal_env/.zshrc 2>/dev/null; then
    echo "export DOCKER_API_VERSION=1.43" >> /config/.immortal_env/.zshrc
fi

echo "✅ [Boot] AI Pro 환경 준비 완료."
