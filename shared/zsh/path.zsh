# === PATH pre-registration ===
# Sourced from ~/.zshenv → runs for EVERY zsh invocation
# (interactive, non-interactive, login, scripts).
#
# Keep this file light: PATH/env exports only. No heavy init,
# no prompt config, no plugin loading.
#
# Purpose: let non-interactive shells (Claude Code `!` commands,
# cron, scripts) find tools that are normally exposed via ~/.zshrc.

# --- User local bin ---
export PATH="$HOME/.local/bin:$PATH"

# --- Homebrew (Apple Silicon) ---
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- npm global bin (nvm default node) ---
# Exposes npm global binaries (codex, claude-code, ...) without
# triggering nvm lazy-load. When nvm actually loads later it will
# re-prepend the correct version, so version switching still works.
if [[ -d "$HOME/.nvm/versions/node" ]]; then
  _node_bins=("$HOME"/.nvm/versions/node/*/bin(N))
  if (( ${#_node_bins} )); then
    export PATH="${_node_bins[-1]}:$PATH"
  fi
  unset _node_bins
fi
