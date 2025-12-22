# 🏥 DTx Empire: AI Research Platform (v3.2.1)

**Global Digital Therapeutics (DTx) 개발을 위한 완전 자동화 연구소**

## ⚡ 핵심 시스템 (Core Systems)
1. **자가 복구 (Self-Healing)**: \`./maintenance/repair.sh\`
   - 터미널 경로 문제, 권한 오류, 패키지 누락 자동 해결.
2. **정밀 진단 (Deep Diagnostic)**: \`./maintenance/check.sh\`
   - 시스템 건강 상태(Zsh, Python, Network 등)를 원클릭으로 진단.
3. **영속성 (Persistence)**: \`install.sh\`
   - 컨테이너가 초기화되어도 언제든 동일한 환경으로 복원.

## 🛠 유지보수 워크플로우 (Maintenance Protocol)
1. **진단**: \`./maintenance/check.sh\` 실행하여 문제 파악.
2. **복구**: \`./maintenance/repair.sh\` 실행하여 자동 수리.
3. **업데이트**: 새로운 문제가 발견되면 스크립트 수정 후 Git Push.

**Architect**: Rehab Medicine Department Head
**Last Updated**: $(date +%Y-%m-%d)
