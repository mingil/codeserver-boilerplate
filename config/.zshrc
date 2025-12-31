# --- Powerlevel10k Instant Prompt ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/config/.immortal_env/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# 플러그인 설정
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# 사용자 편의 설정
alias ll='ls -alF'
alias cls='clear'
alias python='python3'
alias pip='pip3'

# --- 🐍 Python Persistence Architecture (Phase 3 추가) ---
export PIP_TARGET="/config/python_packages"
export PYTHONPATH="/config/python_packages:$PYTHONPATH"
export PATH="/config/python_packages/bin:$PATH"

# p10k 설정 로드
[[ ! -f /config/.immortal_env/.p10k.zsh ]] || source /config/.immortal_env/.p10k.zsh
#cd /config/workspace

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export SHELL=/bin/zsh
export DOCKER_API_VERSION=1.43

# 🌳 AI에게 보여줄 프로젝트 구조 추출 (사용법: map [폴더명])
function map() {
    # 폴더명이 없으면 현재 폴더를 대상으로 함
    TARGET="${1:-.}"
    
    echo "🗺️  Project Structure for AI Context:"
    echo "========================================"
    # 3단계 깊이까지만 표시 (-L 3), 불필요한 파일 제외
    tree "$TARGET" -L 3 -a -I '.git|__pycache__|.venv|node_modules|.DS_Store|*.pyc|*.png|*.jpg' --dirsfirst
    echo "========================================"
}
