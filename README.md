🛡️ Immortal Code-Server Boilerplate

> **The Ultimate Persistent Development Environment for Docker & Synology NAS** > **도커와 시놀로지 NAS를 위한 '불멸의 개발 환경' 보일러플레이트**

![Platform](https://img.shields.io/badge/Platform-Docker%20%7C%20Synology-blue)
![Shell](https://img.shields.io/badge/Shell-Zsh%20%2B%20P10k-green)
![Python](https://img.shields.io/badge/Python-Black%20%2B%20ErrorLens-yellow)

## 📖 Introduction (소개)

This repository provides a **fully automated, persistent, and "immortal" setup** for [linuxserver/code-server](https://github.com/linuxserver/docker-code-server). It solves common issues like losing packages after container rebuilds, sudo permission errors, and tedious UI configurations.

이 저장소는 Code-Server 컨테이너를 **재시작하거나 리빌드해도 설정이 사라지지 않는 '완전한 영속성' 환경**을 제공합니다. 패키지 증발, Sudo 권한 문제, 매번 반복해야 하는 UI 설정을 스크립트 한 방으로 해결합니다.

---

## ✨ Key Features (핵심 기능)

### 1. ♾️ Infinity Persistence (불멸의 영속성)

- **Problem**: Usually, `apt` or `pip` packages disappear when you recreate a container.
- **Solution**: We redirect installed packages to `/config` volume. A custom boot script (`init_hook.sh`) restores everything automatically on every boot.
- **한국어**: 컨테이너를 지웠다 다시 만들어도 `pip` 패키지와 설정이 `/config` 경로에 안전하게 보관되며, 부팅 시 자동으로 복구됩니다.

### 2. 🔓 Auto Sudo (Sudo 권한 자동화)

- **Problem**: The default user `abc` often faces password prompts or permission denied errors.
- **Solution**: The script forcibly injects `NOPASSWD` rules into `/etc/sudoers` on boot, granting you full control without passwords.
- **한국어**: 매번 비밀번호를 물어보는 Sudo 문제를 해결했습니다. 부팅 시 자동으로 권한을 탈취하여 비밀번호 없이 관리자 명령을 사용할 수 있습니다.

### 3. 🎨 Pro Developer UI (프로급 UI 환경)

- **Shell**: Zsh + Oh My Zsh + Powerlevel10k theme installed.
- **Theme**: "Tokyo Night" theme applied by default.
- **Formatting**: Python `Black` formatter and `Error Lens` extension are pre-configured.
- **한국어**: Zsh와 예쁜 터미널(P10k), 도쿄 나이트 테마, 그리고 저장 시 자동으로 코드를 정리해주는(Auto-Format) 환경이 모두 세팅되어 있습니다.

---

## 🚀 Installation (설치 방법)

### Step 1. Clone this repository

Run this command inside your Code-Server terminal:
(Code-Server 터미널에서 이 저장소를 복제하세요.)

````bash
git clone [https://github.com/mingil/codeserver-boilerplate.git](https://github.com/mingil/codeserver-boilerplate.git)
cd codeserver-boilerplate
Step 2. Run the Install ScriptThis script will copy the hook files and configurations to the right place.(설치 스크립트를 실행하면 설정 파일들이 제자리를 찾아갑니다.)Bashbash install.sh
Step 3. Restart ContainerRestart your docker container to apply changes.(도커 컨테이너를 재시작하세요. 부팅 스크립트가 작동하며 마법이 시작됩니다.)Bash# Example (Synology / Docker CLI)
sudo docker restart code-server
📂 Structure (폴더 구조)PathDescriptionscripts/init_hook.shThe Heart. Runs on boot to install packages & fix permissions. (부팅 시 실행되는 핵심 스크립트)config/.zshrcZsh configuration file. (Zsh 설정 원본)config/settings.jsonVS Code user settings (Theme, Formatter, Font). (VS Code 종결 설정 파일)install.shOne-click setup script. (한 방 설치 스크립트)👨‍💻 CreditsArchitect: Mingil (Rehab Doctor & Developer)Concept: "Focus on creation, not configuration."
---

### 2. 터미널 명령어 (업로드용)
(파일 저장 후, 터미널에 **한 번에 복사해서 붙여넣으세요**.)

```bash
cd /config/workspace/projects/codeserver-boilerplate
git add README.md
git commit -m "docs: Update README with bilingual guide"
git push
````