# 🏥 DTx Empire: AI Research Platform (v3.0)

Global Digital Therapeutics (DTx) 개발을 위한 **완전 자동화(Self-Healing)** 및 **영속성(Persistent)**이 보장된 연구 환경입니다.

---

## 🏗️ 시스템 아키텍처 (Architecture)

* **Core**: Ubuntu, Python 3.12+, Docker-in-Docker
* **AI Engine**: PyTorch (CPU), OpenCV, Scikit-learn, Pandas
* **Assistant**: Codeium (AI Code Completion)
* **Storage**: `/config/workspace` (Synology NAS 영구 저장소)

---

## 🛡️ 유지보수 프로토콜 (Maintenance)

시스템에 문제가 발생하거나, 초기화 후 복구가 필요할 때 아래 절차를 따르십시오.

### 1. 상태 점검 (Health Check)
AI 엔진 및 필수 도구(FFmpeg 등)의 작동 여부를 진단합니다.
\`\`\`bash
~/workspace/codeserver-boilerplate/maintenance/check.sh
\`\`\`

### 2. 긴급 복구 (Emergency Repair)
시스템 권한 오류, 패키지 누락 등 모든 문제를 자동으로 해결합니다. (약 2~3분 소요)
\`\`\`bash
~/workspace/codeserver-boilerplate/maintenance/repair.sh
\`\`\`

---

## 📂 폴더 구조 및 관리 (File System)

* **\`/config/workspace/DTx_Core_Platform\`**:
    * 실제 연구 프로젝트 및 소스 코드를 저장하는 곳입니다.
    * 이곳의 파일은 영구적으로 보존됩니다.
* **\`/config/workspace/codeserver-boilerplate\`**:
    * 시스템 설정 파일(\`install.sh\`, 유지보수 스크립트)이 있는 곳입니다.
    * **인프라 변경 시**: \`install.sh\`를 수정하고 반드시 Git Push 하십시오.

---

**Architect**: mingil (Department of Rehabilitation Medicine)
**Last Updated**: $(date +%Y-%m-%d)
