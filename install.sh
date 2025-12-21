#!/bin/bash
# DTx Empire: Immortal Boot Script (Ultimate Edition)
# Description: AI, CV, Data Science, System Utils - All in One.

echo "🚀 [Boot] Ultimate AI Environment 구축 시작..."

# [1] 시스템 기본 유틸리티 & 라이브러리 (모두 설치)
# ffmpeg(영상), graphviz(모델 시각화), cmake(빌드), libgl1(OpenCV) 추가
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y \
    git-lfs tree htop jq fontconfig build-essential \
    ffmpeg graphviz cmake libgl1 \
    > /dev/null

# [2] Pip 설치 (안전장치)
if ! command -v pip &> /dev/null; then
    curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --break-system-packages >/dev/null 2>&1 || python3 get-pip.py >/dev/null 2>&1
    rm get-pip.py
fi

# [3] 권한 복구
if [ -S /var/run/docker.sock ]; then chmod 666 /var/run/docker.sock; fi

# [4] Python AI & Data Science 'Full' Stack 설치
# (한 번 설치하면 재부팅 시 스킵되므로 시간 낭비 없음)
PIP_CMD="python3 -m pip"
$PIP_CMD install --upgrade pip --break-system-packages > /dev/null 2>&1

# opencv-python, pydantic, graphviz 등 추가 패키지 포함
$PIP_CMD install --no-cache-dir --break-system-packages \
    numpy pandas matplotlib seaborn scikit-learn \
    jupyterlab notebook \
    black isort flake8 mypy \
    tqdm rich pydantic requests \
    opencv-python-headless graphviz \
    > /dev/null 2>&1

# PyTorch (CPU)
if ! python3 -c "import torch" 2>/dev/null; then
    echo "🔥 PyTorch (CPU) 설치 중..."
    $PIP_CMD install --break-system-packages torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
fi

# [5] Zsh 설정 & 사용자 환경
mkdir -p /home/abc
if [ -f /config/.immortal_env/.zshrc ]; then
    ln -sf /config/.immortal_env/.zshrc /home/abc/.zshrc
    ln -sf /config/.immortal_env/.p10k.zsh /home/abc/.p10k.zsh
    chsh -s /usr/bin/zsh abc
fi

echo "✅ [Boot] DTx Empire Environment Ready."

# [6] VS Code 확장 프로그램 자동 설치 (Extensions)
echo "🧩 VS Code Extensions 설치 중..."
EXT_LIST=(
    "Codeium.codeium"           # AI 비서
    "ms-python.python"          # Python 필수
    "ms-toolsai.jupyter"        # Jupyter Notebook
    "kelvin.vscode-sshfs"       # SSH 파일 시스템
    "pkief.material-icon-theme" # 아이콘 테마
    "tamasfe.even-better-toml"  # 설정 파일 가독성
)

for ext in "${EXT_LIST[@]}"; do
    code-server --install-extension "$ext" --force > /dev/null 2>&1
done
echo "✅ Extensions Installed."
