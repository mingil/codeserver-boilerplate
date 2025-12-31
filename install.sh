#!/bin/bash
# 🏥 DTx Empire: 시스템 설계도 (v4.1 - Persistence & AI Map)

echo "🚀 [Install] 코드서버 환경 구축 시작..."

# 1. 시스템 패키지 (OS 레벨)
# tree 패키지 추가 (Map 기능용)
sudo apt-get update && sudo apt-get install -y \
    build-essential python3-dev python3-venv \
    git curl wget unzip htop iputils-ping \
    ffmpeg libgl1 tree

# 2. Python 필수 라이브러리 (Persistent Env)
# 도커가 리빌드되어도 사라지지 않는 /config 폴더에 저장합니다.
PERSISTENT_LIB_DIR="/config/python_packages"
mkdir -p "$PERSISTENT_LIB_DIR"

echo "📦 라이브러리를 영구 저장소($PERSISTENT_LIB_DIR)에 설치합니다..."

# --target 옵션: 시스템 폴더가 아닌 지정된 폴더에 설치함
pip3 install --upgrade --target="$PERSISTENT_LIB_DIR" \
    pip setuptools wheel

pip3 install --upgrade --target="$PERSISTENT_LIB_DIR" \
    numpy pandas scikit-learn matplotlib \
    opencv-python-headless jupyter ipympl \
    streamlit plotly \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# 3. VS Code 확장 프로그램 (Editor Env)
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

# -----------------------------------------------------------
# 🔌 [Link] 파이썬이 영구 저장소를 인식하도록 설정
# -----------------------------------------------------------
# .zshrc에 PYTHONPATH가 없으면 추가합니다.
TARGET_PATH="/config/python_packages"

if ! grep -q "export PYTHONPATH=$TARGET_PATH" "$HOME/.zshrc"; then
    echo "🔗 PYTHONPATH를 .zshrc에 등록합니다..."
    echo "" >> "$HOME/.zshrc"
    echo "# 🐍 Python Custom Library Path (Persistent)" >> "$HOME/.zshrc"
    echo "export PYTHONPATH=$TARGET_PATH:\$PYTHONPATH" >> "$HOME/.zshrc"
    echo "export PATH=$TARGET_PATH/bin:\$PATH" >> "$HOME/.zshrc"
fi

# -----------------------------------------------------------
# 🗺️ [Function] AI Context Map (v3.0 - Auto Save)
# -----------------------------------------------------------
sed -i '/alias map=/d' "$HOME/.zshrc"

if ! grep -q "function map()" "$HOME/.zshrc"; then
    echo "🗺️ 자동 저장 기능이 탑재된 'map' 함수를 등록합니다..."
    cat <<EOT >> "$HOME/.zshrc"

# 🌳 Project Structure Mapper
function map() {
    local TARGET="\${1:-.}"
    local SAVE_PATH="/config/workspace/tree_map" # 📍 고정 경로
    
    # 명령어 정의
    local CMD="tree -a -I '.git|__pycache__|.venv|.DS_Store|*.png|*.jpg|node_modules' --dirsfirst -L 3"

    echo "🗺️  Mapping structure of '\$TARGET'..."
    
    {
        echo "Updated: \$(date)"
        echo "Project Root: \$TARGET"
        echo "========================================"
        eval "\$CMD \"\$TARGET\""
        echo "========================================"
    } | tee "\$SAVE_PATH"
    
    echo ""
    echo "✅ Saved to: \$SAVE_PATH"
}
EOT
fi

echo "✅ [Complete] 시스템 환경 구축 완료 (영구 저장소 적용됨)."