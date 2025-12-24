# 🛠️ Code Server Boilerplate (Synology NAS Edition)

이 프로젝트는 **Synology NAS 기반의 VS Code (Code Server)** 개발 환경을 위한 **표준 보일러플레이트(Boilerplate)**입니다.
재활의학과 의국장님의 **DTx 개발 및 데이터 분석**을 위해 최적화된 초기 설정과 구조를 담고 있습니다.

## ✨ Key Features (핵심 기능)

이 보일러플레이트에는 다음과 같은 **생산성 및 가시성 최적화**가 적용되어 있습니다.

### 1. 🎨 Visual Optimization (가시성 강화)

- **High Contrast Line Highlight**: 현재 커서가 위치한 줄을 **진한 남색(#103353)**과 **민트색 테두리**로 강조하여 코드 식별력을 높였습니다.
- **Enhanced Minimap**: 우측 미니맵 슬라이더의 명암비를 높여 전체 코드 내 위치 파악이 쉽습니다.
- **Theme**: `Tokyo Night` 테마를 기반으로 장시간 코딩에 최적화되었습니다.

### 2. 🐍 Python Environment

- **Interpreter**: `/usr/bin/python3` (Standard)
- **Formatter**: `Black` Formatter 자동 적용 (저장 시 자동 정렬)
- **Linter**: Flake8/Pylint 호환

### 3. 🏗️ Standard Directory Structure

데이터 사이언스 및 일반 개발을 모두 포용하는 표준 폴더 구조를 따릅니다.

```text
workspace/
├── 📂 data/            # 데이터 저장소 (Raw/Processed)
├── 📂 src/             # 소스 코드 메인
├── 📂 notebooks/       # Jupyter Notebook 실험실
├── 📂 .vscode/         # VS Code 설정 (settings.json 포함)
└── 📄 README.md        # 프로젝트 문서

🚀 Getting Started
이 보일러플레이트를 기반으로 새 프로젝트를 시작하려면:

이 저장소를 Clone 또는 Template으로 사용합니다.

.vscode/settings.json이 자동 적용되어 바로 가시성 설정이 활성화됩니다.

src/main.py부터 코딩을 시작하세요.

Maintained by: Dr. Rehab & AI Assistant Last Updated: 2025.12.24

---

### 2단계: Git GUI로 '변경 사항' 저장 (Commit & Push)

이제 작성한 문서와 그동안 바뀐 설정 파일들을 Git에 기록합시다. 터미널 말고 **VS Code 왼쪽 메뉴**로만 진행합니다.

1.  **소스 제어(Source Control) 탭 열기**
    * 화면 왼쪽 액티비티 바에서 **가지(Branch) 모양 아이콘** (세 번째) 클릭. (`Ctrl + Shift + G`)
2.  **변경 사항 확인 및 담기 (Stage)**
    * `README.md`와 (혹시 있다면) `settings.json` 등이 목록에 보일 겁니다.
    * **Changes** 글자 옆의 **`+` (더하기)** 버튼을 눌러서 **Staged Changes**로 올립니다.
3.  **커밋 메시지 작성 (Message)**
    * 입력창에 다음과 같이 적어주세요.
        > **docs: 개발 환경 보일러플레이트 문서화 및 가시성 설정 업데이트**
4.  **커밋 및 동기화 (Commit & Sync)**
    * 파란색 **Commit** 버튼(또는 체크 표시) 클릭.
    * 버튼이 **Sync Changes** (또는 Publish Branch)로 바뀌면 한 번 더 클릭해서 서버(GitHub 등)로 업로드까지 완료하세요.

---

### ✅ 확인
소스 제어 탭이 깨끗해졌다면, 의국장님의 **전용 개발 환경 세팅**이 안전하게 저장된 것입니다.

이 작업이 완료되면, 이제 이 환경을 토대로 **진짜 프로젝트(논문 봇, EMG 분석 등)**를 시작할 준비가 완벽히 끝난 셈입니다. 저장 완료되셨나요? 🚀
```
