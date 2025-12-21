#!/bin/bash
# 스크립트의 절대 경로를 계산하여 어디서 실행하든 작동하도록 함
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
INSTALL_SCRIPT="$SCRIPT_DIR/../install.sh"

echo "🚑 [Repair] 시스템 자가 복구 프로세스(v3.0 Final) 시작..."

# [Step 1] 권한 및 연결 복구
echo "🔧 권한 및 도커 소켓 복구 중..."
[ -S /var/run/docker.sock ] && sudo chmod 666 /var/run/docker.sock

echo "   👉 작업 공간 권한 정밀 보정 (백업 폴더 보호, 에러 숨김)..."
# 시놀로지 스냅샷 폴더 제외, 깨진 링크 에러 무시
sudo find /config/workspace -name "#snapshot" -prune -o -exec chown -h abc:abc {} + 2>/dev/null

# [Step 2] 패키지 및 환경 재설치 (install.sh 호출)
echo "🧩 설치 스크립트(설계도) 강제 재실행..."
if [ -f "$INSTALL_SCRIPT" ]; then
    # install.sh가 있는 상위 폴더로 이동하여 실행
    cd "$(dirname "$INSTALL_SCRIPT")"
    sudo bash install.sh
    cd - > /dev/null
else
    echo "⚠️ Critical Error: install.sh 파일을 찾을 수 없습니다."
    exit 1
fi

# [Step 3] Git 인증 정보 복구
echo "🔓 Git 보안 설정 초기화..."
git config --global credential.helper store
unset GIT_ASKPASS

echo "✅ [완료] 시스템이 정상 상태로 복구되었습니다. 'check.sh'로 확인하세요."
