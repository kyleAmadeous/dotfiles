# === Powerlevel10k 즉시 로딩 ===
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# === Oh My Zsh ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  fzf
  docker
  kubectl
  aws
)

source $ZSH/oh-my-zsh.sh

# === 머신 식별자 ===
export MACHINE_ID="server-15004"
export MACHINE_OS="windows-wsl"

# === PATH ===
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# === 기본 설정 ===
export LANG=en_US.UTF-8
export EDITOR=nvim

# === WSL 전용 ===
export BROWSER=wslview
cd ~  # 항상 홈에서 시작

# === nvm (Node.js) ===
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# === pyenv (Python) ===
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)" 2>/dev/null || true

# === Alias ===
alias ll='eza -la --icons'
alias ls='eza --icons'
alias lt='eza -la --icons --tree --level=2'
alias cat='bat'
alias grep='rg'
alias vim='nvim'
alias vi='nvim'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias gco='git checkout'
alias gb='git branch'
alias c='code'
alias ..='cd ..'
alias ...='cd ../..'

# === fzf ===
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# === Powerlevel10k 설정 ===
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
