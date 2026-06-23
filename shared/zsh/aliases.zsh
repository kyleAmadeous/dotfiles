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
