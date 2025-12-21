#!/bin/bash
# 스크립트의 실제 위치를 기준으로 경로를 잡습니다 (어디서 실행하든 작동)
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
INSTALL_SCRIPT="$SCRIPT_DIR/../install.sh"

echo "🚑 [Repair] 시스템 자가 복구 프로세스(v2.6 Silent) 시작..."

# [1] 권한 복구 (유령 파일 에러 무시 + 백업 폴더 제외)
echo "🔧 권한 및 소켓 연결 복구 중..."
[ -S /var/run/docker.sock ] && sudo chmod 666 /var/run/docker.sock

echo "   👉 작업 공간 권한 정밀 보정 (에러 로그 숨김)..."
# 2>/dev/null : "깨진 링크"나 "읽기 전용" 경고 메시지를 블랙홀로 보내서 화면을 깨끗하게 유지함
sudo find /config/workspace -name "#snapshot" -prune -o -exec chown -h abc:abc {} + 2>/dev/null

# [2] 필수 패키지 및 확장 프로그램 재설치
echo "🧩 설치 스크립트 강제 재실행..."
if [ -f "$INSTALL_SCRIPT" ]; then
    # install.sh가 있는 폴더로 이동해서 실행 (경로 문제 해결)
    cd "$SCRIPT_DIR/.." 
    sudo bash install.sh
    cd - > /dev/null # 원래 위치로 복귀
else
    echo "⚠️ Error: install.sh 파일을 찾을 수 없습니다. ($INSTALL_SCRIPT)"
fi

# [3] Git 설정 복구
echo "🔓 Git 보안 설정 초기화..."
git config --global credential.helper store
unset GIT_ASKPASS

echo "✅ [완료] 시스템 복구 완료. 이제 안심하셔도 됩니다."
