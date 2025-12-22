#!/bin/bash
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
INSTALL_SCRIPT="$SCRIPT_DIR/../install.sh"

echo "🚑 [Repair] 시스템 자가 복구(v3.0 Silent) 시작..."

# [1] 권한 복구 (백업 폴더 회피 + 에러 메시지 숨김)
echo "🔧 권한 및 소켓 연결 복구 중..."
[ -S /var/run/docker.sock ] && sudo chmod 666 /var/run/docker.sock
echo "   👉 작업 공간 권한 보정 (Smart Mode)..."
sudo find /config/workspace -name "#snapshot" -prune -o -exec chown -h abc:abc {} + 2>/dev/null

# [2] 설계도(install.sh) 실행
echo "🧩 설계도 기반 패키지 재설치..."
if [ -f "$INSTALL_SCRIPT" ]; then
    cd "$(dirname "$INSTALL_SCRIPT")"
    sudo bash install.sh
    cd - > /dev/null
else
    echo "⚠️ Error: install.sh를 찾을 수 없습니다."
fi

# [3] Git 설정 복구
echo "�� Git 보안 설정 초기화..."
git config --global credential.helper store
unset GIT_ASKPASS

echo "✅ [완료] 복구 완료. 'check.sh'를 실행하세요."
