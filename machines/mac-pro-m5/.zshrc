# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# === entry point — keep this file short, put real config in the dotfiles repo ===

# User local bin
export PATH="$HOME/.local/bin:$PATH"

# Homebrew (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)
ZSH_DISABLE_COMPFIX=true   # compaudit 보안 검사 skip → compinit 속도 개선
source "$ZSH/oh-my-zsh.sh"

# --- pyenv ---
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"

# --- nvm (lazy-load via dotfiles) ---
[ -f "$DOTFILES/shared/zsh/nvm.zsh" ] && source "$DOTFILES/shared/zsh/nvm.zsh"

# --- fzf ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- dotfiles repo sourcing ---
DOTFILES="$HOME/devsrc/dotfiles"
[ -f "$DOTFILES/shared/zsh/aliases.zsh" ] && source "$DOTFILES/shared/zsh/aliases.zsh"
[ -f "$DOTFILES/machines/mac-pro-m5/zshrc.zsh" ] && source "$DOTFILES/machines/mac-pro-m5/zshrc.zsh"

# --- Powerlevel10k prompt config (generated on first `p10k configure`) ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
