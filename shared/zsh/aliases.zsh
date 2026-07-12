# === Shared Aliases (all machines) ===

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Modern CLI replacements
alias cat='bat'
alias grep='rg'
alias vim='nvim'
alias vi='nvim'

# eza
alias ls='eza --icons'
alias ll='eza -la --icons'
alias lt='eza -la --icons --tree --level=2'

# Git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias gco='git checkout'
alias gb='git branch'

# Editor
alias c='code'

# Local LLM (mlx-lm 엔진 → OpenAI 호환 @ localhost:8080)
alias qwen-server='mlx_lm.server --model mlx-community/Qwen3-Coder-30B-A3B-Instruct-4bit-dwq-v2 --port 8080'

# tmux — devsrc repo/worktree 세션 스위처 (수동 실행, 자동 attach 안 함)
alias tm='~/devsrc/dotfiles/shared/bin/tmux-sessionizer.sh'

# tmux — 이름을 이미 아는 세션 직접 제어 (tm 은 fzf 로 고를 때, 이 아래는 바로 칠 때)
alias tls='tmux ls'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias td='tmux detach'
alias tk='tmux kill-session -t'

# ts <name> — 있으면 attach, 없으면 ~/devsrc/<name> 에서 새로 생성
ts() { tmux attach -t "$1" 2>/dev/null || tmux new -s "$1" -c "$HOME/devsrc/${1}"; }
