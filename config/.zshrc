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
cd /config/workspace

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export SHELL=/bin/zsh
export DOCKER_API_VERSION=1.43
