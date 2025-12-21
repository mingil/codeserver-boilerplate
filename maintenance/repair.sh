#!/bin/bash
echo "🚑 [Repair] 시스템 자가 복구 프로세스(v2.2) 시작..."

# [1] 권한 복구
echo "🔧 권한 및 소켓 연결 복구 중..."
[ -S /var/run/docker.sock ] && sudo chmod 666 /var/run/docker.sock
sudo chown -R abc:abc /home/abc /config/workspace

# [2] 필수 패키지 및 확장 프로그램 재설치
echo "🧩 설치 스크립트 강제 재실행..."
if [ -f "../install.sh" ]; then
    sudo bash ../install.sh
else
    echo "⚠️ install.sh 파일을 찾을 수 없습니다."
fi

# [3] Git 설정 복구
echo "🔓 Git 보안 설정 초기화..."
git config --global credential.helper store
unset GIT_ASKPASS

echo "✅ [완료] 시스템 복구 완료. 'check.sh'를 실행해보세요."
