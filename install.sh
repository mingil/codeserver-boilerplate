#!/bin/bash
# 🏥 DTx Empire: Immortal Environment Setup Script (v3.0 Final)
# 이 스크립트는 컨테이너 부팅 시 또는 repair.sh 실행 시 호출되어 시스템을 복구합니다.

echo "🚀 [Install] DTx Empire 환경 구축을 시작합니다..."

# [Step 1] 시스템 필수 도구 (System Utils)
echo "📦 System Packages 업데이트 및 설치..."
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
    unzip \
    iputils-ping

# [Step 2] Python AI 라이브러리 (Global AI Core)
# 편의성을 위해 기본 시스템 파이썬에 Data Science 스택을 탑재합니다.
echo "🧠 Python AI Libraries 설치 중..."
pip3 install --upgrade pip --break-system-packages
pip3 install --break-system-packages \
    numpy \
    pandas \
    scikit-learn \
    matplotlib \
    opencv-python-headless \
    jupyter \
    ipympl \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# [Step 3] VS Code 확장 프로그램 (Extensions)
echo "🧩 VS Code Extensions 복구 중..."
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

# [Step 4] 정리 (Clean up)
sudo apt-get clean
rm -rf /var/lib/apt/lists/*

echo "✅ [Complete] 시스템이 설계도대로 완벽하게 복구되었습니다."
