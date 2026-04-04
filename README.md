# dotfiles

> 멀티 머신 개발 환경 설정 및 dotfiles 관리

## 머신 목록

| ID | 머신 | OS | 용도 |
|----|------|----|------|
| `rog-g14` | ASUS ROG Zephyrus G14 | Windows 11 (WSL Ubuntu 24.04) | 메인 개발 |
| `mbp-m2-14` | MacBook Pro M2 14" | macOS | 모바일 개발 |
| `mac-mini-m2` | Mac mini M2 | macOS | 서브 워크스테이션 |
| `server-15004` | Server 15004 | Linux | 서버 |
| `server-15006` | Server 15006 | Linux | 서버 |
| `mac-pro-m5` | Mac Pro M5 | macOS | 워크스테이션 |

## 구조

```
dotfiles/
├── machines/          # 머신별 설정
│   ├── rog-g14/       # .zshrc, etc.
│   ├── mbp-m2-14/
│   ├── mac-mini-m2/
│   ├── server-15004/
│   ├── server-15006/
│   └── mac-pro-m5/
├── shared/            # 공통 설정
│   ├── zsh/           # aliases.zsh
│   ├── git/           # .gitconfig, .gitignore_global
│   └── vim/           # init.vim
└── docs/              # 설정 가이드
    ├── windows-dev-setup-guide.md
    └── mac-dev-setup-guide.md
```

## 공통 스택

- **Terminal**: Zsh + Oh My Zsh + Powerlevel10k
- **CLI**: fzf, fd, bat, eza, ripgrep, jq, btop
- **AI**: Claude Code, Codex
- **Editor**: Neovim, VS Code
- **Runtime**: Node.js (nvm), Python (pyenv)
- **Infra**: Docker, AWS CLI, Azure CLI, gcloud CLI
- **VCS**: Git (SSH)

## 업데이트 이력

- 2026-04-05: dotfiles 구조 개편 (machines/shared 분리)
- 2026-04-04: 초기 생성
