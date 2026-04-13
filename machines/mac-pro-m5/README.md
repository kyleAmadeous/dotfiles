# mac-pro-m5

Mac Pro M5 · macOS · 워크스테이션

## 개요

풀스택 + DevOps 개발을 위한 기본 환경이 구축된 상태. 자세한 설치 절차는 [docs/mac-dev-setup-guide.md](../../docs/mac-dev-setup-guide.md) 참고.

## 적용된 구성

**셸**
- zsh 5.9 + Oh My Zsh + Powerlevel10k
- `~/.zshrc`는 짧은 엔트리포인트로 유지하고 실질 설정은 이 레포에서 source
- 플러그인: `git`, `fzf`, `zsh-autosuggestions`, `zsh-syntax-highlighting`

**CLI 툴체인**
- 현대 대체재: `bat`, `eza`, `ripgrep`, `fd`, `fzf`, `btop`, `neovim`
- 기본: `git`, `curl`, `wget`, `jq`, `tree`, `htop`
- 클라우드: `awscli`, `azure-cli`, `google-cloud-sdk`

**런타임**
- Node.js: nvm → v24 LTS (`nvm alias default lts/*`)
- Python: pyenv (시스템 Python 3.9는 그대로 두고 pyenv로 버전 관리)
- gcloud SDK: `CLOUDSDK_PYTHON=/opt/homebrew/bin/python3.13` (번들 Python 3.9 deprecation 우회)

**GUI 앱 (brew cask)**
- 개발: Visual Studio Code, iTerm2, Warp, Docker Desktop
- 브라우저: Google Chrome
- 유틸: Alfred 5, AltTab, Stats, Hidden Bar, Keka
- 생산성: Obsidian, 1Password (+ `op` CLI)
- AI: Claude, ChatGPT
- 스토리지: Dropbox
- Microsoft 365 (Word / Excel / PowerPoint / Outlook / OneNote / OneDrive 번들) + Teams

**GUI 앱 (App Store)**
- Magnet — 창 관리
- Day One — 저널

**폰트**
- Powerlevel10k용 `MesloLGS NF` 4종 (romkatv 공식 배포)
- 추가: FiraCode NF, JetBrainsMono NF, Hack NF

**Git**
- 아이덴티티: `kyleAmadeous / pinkrich@gmail.com`
- `~/.gitconfig`, `~/.gitignore_global`은 `shared/git/` symlink

## 머신 전용 파일

- `zshrc.zsh` — gcloud Python 핀 + gcloud path/completion source. `~/.zshrc`에서 자동 로드.

## 수동 작업 필요

- `gcloud init` (브라우저 OAuth)
- Microsoft 365 구독 계정으로 Office 앱 첫 실행 시 로그인
- OneDrive/Dropbox 동기화 폴더 설정
- 1Password vault 로그인 및 브라우저 확장 연결

## 완료된 설정

- P10k 마법사 (`~/.p10k.zsh` 존재)
- Docker Desktop 설치 완료
