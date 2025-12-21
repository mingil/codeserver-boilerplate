#!/bin/bash
# 🏥 DTx Empire: Immortal Environment Setup Script
# 이 파일은 컨테이너가 생성될 때마다 자동으로 실행되어, 모든 환경을 원상복구합니다.

echo "🚀 [Install] DTx Empire 환경 구축을 시작합니다..."

# [1] 시스템 기본 패키지 업데이트 및 필수 도구 설치 (System Utils)
echo "📦 System Packages 업데이트 중..."
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    python3-dev \
    python3-venv \
    git \
    curl \
    wget \
    ffmpeg \
    libgl1 \
    htop \
    unzip

# [2] Python AI 라이브러리 설치 (AI Core)
# 주의: 최신 환경에서는 --break-system-packages 옵션이 필요할 수 있음
echo "🧠 Python AI Libraries 설치 중..."
pip3 install --upgrade pip --break-system-packages
pip3 install --break-system-packages \
    numpy \
    pandas \
    scikit-learn \
    matplotlib \
    opencv-python-headless \
    jupyter \
    ipympl

# PyTorch (CPU 버전 - 시놀로지 부하 방지용)
echo "🔥 PyTorch (CPU) 설치 중..."
pip3 install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# [3] VS Code 확장 프로그램 설치 (Extensions)
echo "🧩 VS Code Extensions 설치 중..."
EXT_LIST=(
    "Codeium.codeium"           # AI 비서
    "ms-python.python"          # Python 지원
    "ms-toolsai.jupyter"        # Jupyter Notebook
    "kelvin.vscode-sshfs"       # 원격 파일 관리
    "pkief.material-icon-theme" # 아이콘 테마
    "tamasfe.even-better-toml"  # 설정 파일 지원
)

for ext in "${EXT_LIST[@]}"; do
    code-server --install-extension "$ext" --force > /dev/null 2>&1
done

# [4] 정리 (Clean up)
sudo apt-get clean
rm -rf /var/lib/apt/lists/*

echo "✅ [Complete] 모든 환경 설정이 완료되었습니다."
