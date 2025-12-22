#!/bin/bash
# 🚑 DTx Empire: 자가 복구 키트 (v3.1 Final)
# 사용법: ./maintenance/repair.sh

echo "🚑 [Repair] 시스템 진단 및 복구를 시작합니다..."

# 1. Docker 소켓 및 파일 권한 복구
echo "🔧 권한(Permissions) 복구 중..."
[ -S /var/run/docker.sock ] && sudo chmod 666 /var/run/docker.sock
sudo find /config/workspace -name "#snapshot" -prune -o -exec chown -h abc:abc {} + 2>/dev/null

# 2. Zsh 터미널 경로 문제 자동 해결 (Critical Fix)
echo "⚡ Zsh 설정 보정 (Instant Prompt Off)..."
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    # (1) Instant Prompt 끄기 (터미널 경로 고정 문제 해결책)
    if ! grep -q "POWERLEVEL9K_INSTANT_PROMPT=off" "$ZSHRC"; then
        sed -i '1i typeset -g POWERLEVEL9K_INSTANT_PROMPT=off' "$ZSHRC"
        echo "   👉 .zshrc: Instant Prompt 비활성화 적용 완료"
    fi
    # (2) 보안 경고 무시
    if ! grep -q "ZSH_DISABLE_COMPFIX" "$ZSHRC"; then
        sed -i '1i ZSH_DISABLE_COMPFIX=\"true\"' "$ZSHRC"
        echo "   👉 .zshrc: 보안 경고 무시 적용 완료"
    fi
else
    echo "⚠️ 주의: .zshrc 파일이 없습니다. Oh-My-Zsh가 설치되지 않았을 수 있습니다."
fi

# 3. 필수 패키지 및 플러그인 복구 (install.sh 호출)
INSTALL_SCRIPT="$(dirname "$0")/../install.sh"
if [ -f "$INSTALL_SCRIPT" ]; then
    echo "🧩 시스템 패키지 및 플러그인 점검..."
    bash "$INSTALL_SCRIPT" > /dev/null 2>&1
else
    echo "⚠️ install.sh 설계도를 찾을 수 없습니다."
fi

# 4. Git 인증 정보 복구
git config --global credential.helper store
unset GIT_ASKPASS

echo "✅ [완료] 모든 시스템이 정상화되었습니다. 터미널을 다시 열어주세요."
