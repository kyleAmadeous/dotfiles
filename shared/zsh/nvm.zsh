# === NVM lazy-load (nvm command only) ===
# node/npm/npx/yarn/pnpm 은 path.zsh 가 nvm 의 default node bin 을
# PATH 에 미리 등록하므로 래퍼가 필요 없다. `nvm` 서브커맨드만
# lazy-load 한다.
#
# 주의: Claude Code shell snapshot 이 underscore prefix helper 함수를
# 누락해 무한 재귀 버그가 있었다. 그래서 helper 없이 nvm() 안에
# 로직을 인라인한다.

export NVM_DIR="$HOME/.nvm"

if [[ -d "$NVM_DIR" ]]; then
  nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
  }
fi
