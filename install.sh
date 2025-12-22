#!/bin/bash
# 🏥 DTx Empire: 시스템 설계도 (v3.1)

echo "🚀 [Install] 환경 구축 시작..."

# 시스템 패키지
sudo apt-get update && sudo apt-get install -y \
    build-essential python3-dev python3-venv \
    git curl wget unzip htop iputils-ping \
    ffmpeg libgl1

# Python 필수 라이브러리
pip3 install --upgrade pip --break-system-packages
pip3 install --break-system-packages \
    numpy pandas scikit-learn matplotlib \
    opencv-python-headless jupyter ipympl \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# VS Code 확장 프로그램 (좀비처럼 부활할 목록)
EXT_LIST=(
    "Codeium.codeium"
    "ms-python.python"
    "ms-toolsai.jupyter"
    "kelvin.vscode-sshfs"
    "pkief.material-icon-theme"
    "tamasfe.even-better-toml"
)
for ext in "${EXT_LIST[@]}"; do
    code-server --install-extension "$ext" --force > /dev/null 2>&1
done

echo "✅ [Complete] 설계도 적용 완료."
