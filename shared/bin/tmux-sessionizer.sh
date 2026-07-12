#!/usr/bin/env bash
# tmux-sessionizer — ~/devsrc 하위 repo/worktree를 fzf로 골라 tmux 세션으로 전환.
# 패턴: ~/devsrc/<repo> (기준 repo, flat worktree 공통) + ~/devsrc/<repo>-wt/<branch> (worktree 부모형)
set -euo pipefail

DEVSRC="$HOME/devsrc"

selected=$(
  {
    find "$DEVSRC" -mindepth 1 -maxdepth 1 -type d
    find "$DEVSRC" -mindepth 2 -maxdepth 2 -type d -path '*-wt/*'
  } | sort -u | fzf --prompt="devsrc> "
)

[ -z "${selected:-}" ] && exit 0

session_name=$(basename "$selected" | tr '.:' '__')

if ! tmux has-session -t "$session_name" 2>/dev/null; then
  tmux new-session -ds "$session_name" -c "$selected"
fi

if [ -z "${TMUX:-}" ]; then
  tmux attach-session -t "$session_name"
else
  tmux switch-client -t "$session_name"
fi
