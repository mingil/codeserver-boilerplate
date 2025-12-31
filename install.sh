#!/bin/bash
# 🏥 DTx Empire: 시스템 설계도 (v4.0 - Universal AI Env)

echo "🚀 [Install] 코드서버 환경 구축 시작..."

# 1. 시스템 패키지 (OS 레벨)
# 기본 도구 및 멀티미디어/그래픽 처리를 위한 필수 패키지
sudo apt-get update && sudo apt-get install -y \
    build-essential python3-dev python3-venv \
    git curl wget unzip htop iputils-ping \
    ffmpeg libgl1

# 2. Python 필수 라이브러리 (Global Env)
# - 데이터 분석: numpy, pandas, scikit-learn, matplotlib
# - 컴퓨터 비전: opencv-python-headless
# - 인터랙티브: jupyter, ipympl
# - 딥러닝: torch, torchvision, torchaudio (CPU 버전)
# - [NEW] 웹 대시보드: streamlit, plotly (이제 기본 환경에 포함됨)
pip3 install --upgrade pip --break-system-packages
pip3 install --break-system-packages \
    numpy pandas scikit-learn matplotlib \
    opencv-python-headless jupyter ipympl \
    streamlit plotly \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# 3. VS Code 확장 프로그램 (Editor Env)
# - [NEW] bierner.markdown-mermaid: 인포그래픽 미리보기 지원
EXT_LIST=(
    "Codeium.codeium"
    "ms-python.python"
    "ms-toolsai.jupyter"
    "kelvin.vscode-sshfs"
    "pkief.material-icon-theme"
    "tamasfe.even-better-toml"
    "bierner.markdown-mermaid"
)

echo "🧩 확장 프로그램 확인 및 업데이트 중..."
for ext in "${EXT_LIST[@]}"; do
    code-server --install-extension "$ext" --force > /dev/null 2>&1
done

echo "✅ [Complete] 시스템 환경 업그레이드 완료."

# -----------------------------------------------------------
# 🗺️ [Alias] AI를 위한 프로젝트 지도(Map) 기능 추가
# -----------------------------------------------------------
# .zshrc에 이미 map 명령어가 있는지 확인하고, 없으면 추가합니다.
if ! grep -q "alias map=" "$HOME/.zshrc"; then
    echo "🗺️ 'map' 명령어(Tree Alias)를 .zshrc에 등록합니다..."
    echo "alias map=\"tree -a -I '.git|__pycache__|.venv|.DS_Store|*.png|*.jpg|node_modules' --dirsfirst -L 3\"" >> "$HOME/.zshrc"
fi