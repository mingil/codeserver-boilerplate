#!/bin/bash
# DTx Empire: Immortal Boot Script (AI Pro Edition - Fixed v2)

echo "🚀 [Boot] AI Data Science 환경 재구축 시작..."

# [1] 시스템 유틸리티 설치 (Python 관련 패키지는 제외하여 충돌 방지)
echo "📦 System Utilities 설치 중..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y git-lfs tree htop jq fontconfig > /dev/null

# [2] Pip 수동 설치 (시스템 패키지 관리자 우회)
if ! command -v pip &> /dev/null; then
    echo "💉 Pip 강제 주입 중..."
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3 --break-system-packages
fi

# [3] 권한 복구
if [ -S /var/run/docker.sock ]; then chmod 666 /var/run/docker.sock; fi

# [4] Python AI 라이브러리 설치
echo "🐍 Python AI Library 동기화..."

# 필수 패키지 설치 (에러 무시 옵션 추가)
pip install --upgrade pip --break-system-packages > /dev/null 2>&1
pip install --no-cache-dir --break-system-packages \
    numpy pandas matplotlib seaborn scikit-learn \
    jupyterlab notebook \
    black isort flake8 mypy \
    tqdm rich > /dev/null 2>&1

# PyTorch (CPU 버전) - 설치 확인 후 진행
if ! python3 -c "import torch" 2>/dev/null; then
    echo "🔥 PyTorch (CPU) 설치 중 (최대 3분 소요)..."
    pip install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
fi

# [5] Zsh 설정 (재확인)
mkdir -p /home/abc
if [ -f /config/.immortal_env/.zshrc ]; then
    ln -sf /config/.immortal_env/.zshrc /home/abc/.zshrc
    ln -sf /config/.immortal_env/.p10k.zsh /home/abc/.p10k.zsh
    chsh -s /usr/bin/zsh abc
fi

echo "✅ [Boot] AI Pro 환경 준비 완료 (진짜)."
