# 🛠️ DTx Empire System Troubleshooting Guide

이 문서는 Code Server 환경에서 발생하는 일반적인 문제와 해결 방법을 다룹니다.

## 🚨 긴급 조치 (Emergency)
문제가 생기면 고민하지 말고 아래 스크립트를 순서대로 실행하세요.

1. **상태 진단**: `./maintenance/check.sh`
2. **자동 복구**: `./maintenance/repair.sh`

---

## ⚠️ 자주 발생하는 문제 (FAQ)

### 1. `sudo` 명령어가 작동하지 않거나 비밀번호가 계속 틀린다고 나옴
- **원인**: 컨테이너 재시작으로 권한 설정 파일이 날아갔을 가능성.
- **해결**: 
  - 터미널에서 `./maintenance/repair.sh` 실행.
  - 해결되지 않으면 `su root` 입력 후 비밀번호(초기 설정값) 입력 -> `chmod 666 /var/run/docker.sock` 등 수동 조치.

### 2. Docker 명령어가 `Permission Denied` 뜸
- **원인**: `docker.sock` 파일의 권한이 666(누구나 쓰기 가능)이 아님.
- **해결**: `./maintenance/repair.sh` 실행 시 자동으로 고쳐줍니다.

### 3. Git Push/Pull이 안 됨
- **원인**: 인증 정보가 만료되었거나 인터넷 연결 문제.
- **해결**: `git config --list`로 설정 확인. 인터넷 연결 확인.

### 4. 확장 프로그램이 다 사라짐
- **원인**: 컨테이너가 재생성되면서 `/config/extensions` 폴더가 초기화됨.
- **해결**: `code-server --install-extension ms-python.python` 명령어로 다시 설치.

---
**Last Updated:** $(date)
