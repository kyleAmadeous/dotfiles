# macOS 개발 환경 설정 가이드

> 풀스택 + DevOps 개발자용 종합 설정
> macOS Sonoma / Sequoia 기준

---

## 1. macOS 기본 설정

### 1-1. 시스템 설정

```bash
# Xcode Command Line Tools 설치 (필수 - 대부분의 개발 도구 의존)
xcode-select --install

# Finder: 숨김 파일 표시
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: 파일 확장자 항상 표시
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: 경로 표시줄 활성화
defaults write com.apple.finder ShowPathbar -bool true

# Dock: 자동 숨기기 활성화
defaults write com.apple.dock autohide -bool true

# Dock: 최근 사용 앱 표시 비활성화
defaults write com.apple.dock show-recents -bool false

# 키 반복 속도 향상
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# 스크린샷 저장 위치 변경
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

# 설정 적용
killall Finder
killall Dock
```

### 1-2. 키보드 설정

```
시스템 설정 → 키보드
  - 키 반복 속도: 빠르게
  - 반복 지연 시간: 짧게
  - 한/영 전환: Caps Lock 또는 fn 키 설정

시스템 설정 → 키보드 → 키보드 단축키 → 수정자 키
  - Caps Lock → Control 변경 (개발 시 편리)
```

---

## 2. Homebrew (패키지 매니저)

> macOS의 핵심. Windows의 winget에 해당하며, 거의 모든 도구를 brew로 설치합니다.

### 2-1. 설치

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon (M1/M2/M3) 경로 설정 - .zshrc에 자동 추가 확인
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# 설치 확인
brew --version
```

### 2-2. 필수 앱 일괄 설치

```bash
# CLI 도구
brew install \
    git \
    curl \
    wget \
    jq \
    tree \
    htop \
    neofetch

# GUI 앱 (cask)
brew install --cask \
    visual-studio-code \
    google-chrome \
    warp \
    iterm2 \
    alfred \
    alt-tab \
    stats \
    hidden-bar \
    keka

# 이미 유료 사용 중인 앱 (App Store 또는 공식 사이트에서 설치)
# - Magnet (App Store 유료) → 창 관리
# - Day One (App Store 유료) → 저널/일기
# - Alfred (Powerpack 유료) → 런처/워크플로우

# AI & 생산성 앱
brew install --cask \
    claude \
    chatgpt \
    dropbox

# Claude Code (CLI)
npm install -g @anthropic-ai/claude-code

# OpenAI Codex CLI
npm install -g @openai/codex
```
