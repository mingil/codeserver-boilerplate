# 🥋 Coding Dojo (Python Data Science Practice)

이 프로젝트는 **데이터 사이언스 표준 폴더 구조(Cookiecutter Data Science)**를 기반으로 구축된 Python 코딩 수련장입니다.
재활의학과 의국장님의 **데이터 분석 및 DTx 개발 역량 강화**를 목적으로 합니다.

## 🏗️ Project Structure (프로젝트 구조)

이 프로젝트는 **관심사의 분리(SoC)** 원칙에 따라 모듈화되어 있습니다.

```text
coding-dojo/
├── 📂 data/            # 데이터 보관소 (HIPAA/GDPR 준수)
│   ├── raw/            # 원본 데이터 (Read-only, 수정 금지)
│   └── processed/      # 전처리 및 가공된 데이터
├── 📂 src/             # 소스 코드 (핵심 로직)
│   ├── main.py         # 메인 실행 파일
│   └── modules/        # 기능별 모듈 모음
├── 📂 notebooks/       # Jupyter Notebook 실험 공간
├── 📂 outputs/         # 분석 결과물 (그래프, 테이블)
└── 📄 settings.json    # VS Code 가시성(High Contrast) 설정 포함

🛠️ Environment Setup (환경 설정)
VS Code (Code Server) Optimization
시각적 편의성을 위해 settings.json에 다음 설정이 적용되었습니다:

Line Highlight: 현재 커서 라인 강조 (Deep Blue)

High Contrast Minimap: 미니맵 시인성 개선

🚀 Usage (사용법)
Bash

# 메인 프로그램 실행
python3 src/main.py
Author: Dr. Rehab & AI Assistant Last Updated: 2025.12.24
```
