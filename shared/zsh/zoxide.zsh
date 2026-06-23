# === zoxide — smarter cd (frecency 기반 디렉토리 점프) ===
# autojump 대체재 (Rust). chpwd 훅으로 방문 경로를 학습하고
# `z <부분문자열>`로 frecency(빈도+최근성) 점수가 가장 높은 경로로 점프한다.
#
# 주의: oh-my-zsh 로드 이후에 source 해야 chpwd 훅이 정상 등록된다.
# DB: ~/.local/share/zoxide  (설치 직후엔 비어 있음 → 평소 경로를 cd 로 학습시킬 것)

if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"

  # autojump 근육기억 호환: j / ji 로도 점프
  alias j='z'    # j foo  → 점프
  alias ji='zi'  # ji     → fzf 인터랙티브 선택

  # ── 초기 seed (새 머신/DB 리셋 시 최초 1회) ────────────────
  # 새 머신은 DB 가 비어 있어 `z <repo>` 가 안 먹힌다 → 자주 쓰는 repo 를 미리 등록.
  # 주의: zoxide add 는 호출마다 frecency 점수를 올리므로 매 셸 실행 금지.
  #       sentinel 로 최초 1회만 돌리고, 이후 학습은 chpwd 훅이 담당.
  #       sentinel 을 DB 디렉토리 안에 두어 DB 를 지우면 자동 재seed 된다.
  # 존재하지 않는 경로는 [ -d ] 로 건너뛰므로 다른 머신에서도 안전(portable).
  _zoxide_seed_flag="${_ZO_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/zoxide}/.seeded"
  if [ ! -f "$_zoxide_seed_flag" ]; then
    for _d in \
      ~/devsrc \
      ~/devsrc/knowledge-os \
      ~/devsrc/metabet \
      ~/devsrc/tableGame-next \
      ~/devsrc/rushguru-client \
      ~/devsrc/agent-harness \
      ~/devsrc/kyle-claude-plugins \
      ~/devsrc/dotfiles \
      ~/devsrc/allLinkMall \
      ~/devsrc/mlx-gemma4-demo \
      ~/.claude
    do
      [ -d "$_d" ] && zoxide add "$_d"
    done
    mkdir -p "${_zoxide_seed_flag:h}" && touch "$_zoxide_seed_flag"
    unset _d
  fi
  unset _zoxide_seed_flag
fi
