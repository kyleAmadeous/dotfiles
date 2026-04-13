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
# CLI 도구 (기본)
brew install \
    git \
    curl \
    wget \
    jq \
    tree \
    htop \
    neofetch

# CLI 도구 (현대 대체재 — shared/zsh/aliases.zsh가 이들에 의존)
brew install \
    bat \
    eza \
    ripgrep \
    fd \
    fzf \
    btop \
    neovim

# 언어 버전 관리
brew install pyenv
# nvm은 아래 섹션 5 참고 (brew 버전은 비공식 지원)

# 클라우드 CLI
brew install awscli azure-cli
brew install --cask gcloud-cli

# GUI 앱 (cask)
brew install --cask \
    visual-studio-code \
    google-chrome \
    warp \
    iterm2 \
    alfred \
    alt-tab \
    stats \
    hiddenbar \
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

### 2-3. Docker Desktop (별도)

> Docker Desktop은 설치 중 `/usr/local/cli-plugins`를 만들기 위해 **sudo 권한**을 요구합니다. 비대화형(스크립트/CI)에서는 설치가 실패하므로 대화형 셸에서 직접 실행하고 로그인 비밀번호를 입력해야 합니다.

```bash
brew install --cask docker-desktop
# 설치 후 Docker.app을 한 번 실행해 라이선스 동의 완료
```

---

## 3. Zsh + Oh My Zsh + Powerlevel10k

> macOS 기본 셸이 zsh이므로 셸 교체는 불필요. Oh My Zsh는 프레임워크, Powerlevel10k는 고성능 프롬프트 테마.

### 3-1. Oh My Zsh 설치

```bash
# --unattended 플래그로 기존 .zshrc 덮어쓰기·chsh·셸 교체 방지
RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### 3-2. Powerlevel10k 테마 + 플러그인

```bash
# 테마
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 플러그인
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 3-3. Nerd Font 설치 (Powerlevel10k 권장)

> P10k는 패치된 Nerd Font 없이는 아이콘이 네모/물음표로 깨집니다. `romkatv/powerlevel10k-media`가 배포하는 공식 `MesloLGS NF`를 권장.

```bash
# 공식 권장 폰트 (가장 안전)
cd ~/Library/Fonts
for f in Regular Bold Italic "Bold Italic"; do
    curl -fLo "MesloLGS NF ${f}.ttf" \
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20${f// /%20}.ttf"
done

# (선택) brew cask로 추가 Nerd Font
brew install --cask \
    font-meslo-lg-nerd-font \
    font-jetbrains-mono-nerd-font \
    font-fira-code-nerd-font \
    font-hack-nerd-font
```

**터미널 앱 폰트 설정**: Terminal.app / iTerm2 / Warp 각각 Settings에서 폰트를 `MesloLGS NF`로 변경.

- **macOS 폰트 패널의 "언어" 드롭다운 주의**: 시스템 언어가 한국어면 기본값이 "한국어"로 잡혀 한글 폰트만 보입니다. **"모든 서체"**로 변경해야 `MesloLGS NF`가 목록에 나타납니다.
- brew cask로 깐 Meslo는 피커에 `MesloLGS Nerd Font` / `MesloLGS Nerd Font Mono` 이름으로 등록 (약어 `NF`가 아님).

### 3-4. P10k 마법사 실행

새 터미널 창을 열면 자동으로 시작되거나, 수동으로:

```bash
p10k configure
```

폰트 글리프 확인 질문에 전부 `y`, 스타일은 Rainbow/Unicode/256 colors, 2 lines, Sparse, Many icons, Transient prompt = yes 정도가 무난한 선택.

---

## 4. 언어 런타임

### 4-1. Node.js (nvm)

> `brew install nvm`은 nvm 공식에서 권장하지 않음. 공식 install 스크립트 사용.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# 새 셸에서 nvm 로드 후
nvm install --lts
nvm alias default 'lts/*'
node -v
```

설치 스크립트가 `~/.zshrc`에 nvm source 블록을 자동 추가합니다.

### 4-2. Python (pyenv)

```bash
# pyenv 자체는 섹션 2-2에서 brew로 설치 완료
# 원하는 Python 버전 설치 예시
pyenv install 3.13.0
pyenv global 3.13.0
python --version
```

`~/.zshrc`에 다음 초기화 코드 필요:

```bash
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"
```

### 4-3. gcloud SDK Python 핀

> `google-cloud-sdk` cask는 시스템 Python 3.9를 감지해 씁니다. 3.9는 Google이 공식 지원 중단 상태라 경고가 뜹니다.

해결: `~/.zshrc` 또는 머신별 설정 파일에 Homebrew 파이썬으로 강제 지정.

```bash
export CLOUDSDK_PYTHON="/opt/homebrew/bin/python3.13"
```

---

## 5. dotfiles 레포 연결

### 5-1. 클론

```bash
mkdir -p ~/devsrc
gh repo clone kyleAmadeous/dotfiles ~/devsrc/dotfiles
# 또는 HTTPS: git clone https://github.com/kyleAmadeous/dotfiles.git ~/devsrc/dotfiles
```

### 5-2. shared 파일 심링크

```bash
DOT=~/devsrc/dotfiles

mkdir -p ~/.config/nvim
ln -sf $DOT/shared/git/.gitconfig         ~/.gitconfig
ln -sf $DOT/shared/git/.gitignore_global  ~/.gitignore_global
ln -sf $DOT/shared/vim/init.vim           ~/.config/nvim/init.vim
```

> **주의**: `~/.gitconfig`가 레포 파일을 가리키는 symlink 상태에서 `git config --global ...`을 실행하면 레포 파일이 **직접 수정**됩니다. 특히 쉘이 `~`를 절대경로로 확장해 넣어버리면 다른 머신에서 깨집니다. 레포 `.gitconfig`에서 경로는 항상 `~/...` 또는 `$HOME` 상대로 유지.

### 5-3. ~/.zshrc 엔트리포인트 패턴

`~/.zshrc`는 짧은 엔트리포인트로 유지하고 실질 설정은 레포 파일을 source:

```bash
# 맨 위: P10k instant prompt (P10k configure 실행 후 자동 삽입)
# ... (P10k 블록) ...

# Homebrew / Oh My Zsh / pyenv / nvm / fzf 초기화
eval "$(/opt/homebrew/bin/brew shellenv)"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# ... pyenv / nvm / fzf ...

# dotfiles repo sourcing
DOTFILES="$HOME/devsrc/dotfiles"
[ -f "$DOTFILES/shared/zsh/aliases.zsh" ] && source "$DOTFILES/shared/zsh/aliases.zsh"
[ -f "$DOTFILES/machines/$(scutil --get LocalHostName)/zshrc.zsh" ] && \
    source "$DOTFILES/machines/$(scutil --get LocalHostName)/zshrc.zsh"

# 맨 아래: P10k 프롬프트 config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
```

---

## 6. 검증

```bash
# 새 셸에서 핵심 도구 확인
for t in node npm pyenv gcloud aws az bat eza nvim fzf fd btop; do
    printf "%-8s " $t
    command -v $t >/dev/null && echo OK || echo MISSING
done

# git 아이덴티티
git config --global user.name
git config --global user.email

# alias 로드 확인
alias ls cat grep vim
```
