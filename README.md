# 🏥 DTx Empire: Immortal Code Server Environment

**Global Digital Therapeutics (DTx) 개발을 위한 시놀로지 기반 불멸의 개발 환경입니다.**
이 저장소는 Code Server 컨테이너가 초기화되더라도, 단 한 번의 스크립트 실행으로 완벽한 개발 환경을 복구할 수 있도록 설계되었습니다.

---

## 🚀 주요 기능 (Features)

* **🖥️ Shell**: Zsh + Powerlevel10k 테마가 적용된 현대적인 터미널 환경.
* **🐍 Python**: Python 3.x, Black Formatter, PyTorch 개발 환경 완비.
* **🐳 Docker**: Docker-in-Docker 지원 및 시놀로지 호환성 패치 (API 1.43).
* **🔒 Security**: `sudo` 비밀번호 사용을 통한 표준 보안(Standard Security) 준수.
* **🛡️ Maintenance**: 시스템 자가 진단 및 자동 복구 키트 내장.

---

## 🛠️ 설치 방법 (Installation)

이 환경을 새로운 컨테이너에 적용하려면 다음 명령어를 실행하세요.

\`\`\`bash
# 1. 저장소 클론
git clone https://github.com/mingil/codeserver-boilerplate.git
cd codeserver-boilerplate

# 2. 설치 스크립트 실행 (부팅 스크립트 등록)
bash install.sh
\`\`\`

---

## 🚑 유지보수 (Maintenance Center)

시스템에 문제가 발생했거나(예: Sudo 권한 상실, Docker 연결 실패), 정기 점검이 필요할 때 사용합니다.

### 1. 시스템 상태 진단 (Check)
현재 시스템의 건강 상태를 점검합니다.
\`\`\`bash
./maintenance/check.sh
\`\`\`

### 2. 자가 복구 (Repair) 
권한 문제나 설정 오류를 자동으로 감지하고 수정합니다.
\`\`\`bash
./maintenance/repair.sh
\`\`\`

---

## 📂 디렉토리 구조
* \`install.sh\`: 부팅 스크립트 설치 파일
* \`health_check.sh\`: (Deprecated) \`maintenance/check.sh\`로 통합됨
* \`maintenance/\`: 유지보수 도구 모음 (\`check.sh\`, \`repair.sh\`, \`TROUBLESHOOTING.md\`)

---
**Architect**: mingil (DTx Empire)
**Last Updated**: $(date +%Y-%m-%d)
