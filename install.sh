#!/bin/bash
# 🏥 DTx Empire: Immortal Environment Setup Script (v3.0 Final)
# 부팅 시 또는 복구 시 실행되어 시스템을 원래대로 되돌립니다.

echo "🚀 [Install] DTx Empire 환경 구축을 시작합니다..."

# [1] System Packages (FFmpeg, Git 등 필수 도구)
echo "📦 System Packages 업데이트 및 설치..."
sudo apt-get update
sudo apt-get install -y \
    build-essential python3-dev python3-venv \
    git curl wget unzip htop iputils-ping \
    ffmpeg libgl1  # 멀티미디어 및 OpenCV 필수 의존성

# [2] Python AI Libraries (기본 AI 엔진 탑재)
echo "🧠 Python AI Libraries 설치 중..."
pip3 install --upgrade pip --break-system-packages
# CPU 버전 PyTorch 및 데이터 분석 스택
pip3 install --break-system-packages \
    numpy pandas scikit-learn matplotlib \
    opencv-python-headless jupyter ipympl \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# [3] VS Code Extensions (플러그인 자동 복구 목록)
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

# [4] 정리
sudo apt-get clean
rm -rf /var/lib/apt/lists/*

echo "✅ [Complete] 시스템 설계도 적용 완료."
