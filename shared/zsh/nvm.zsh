# === NVM lazy-load ===
# nvm, node, npm 등 첫 호출 시에만 실제 로드 → 쉘 시작 시간 단축
# Warp처럼 탭마다 subshell을 띄우는 환경에서 특히 효과적

export NVM_DIR="$HOME/.nvm"

if [[ -d "$NVM_DIR" ]]; then
  _nvm_load() {
    unset -f nvm node npm npx yarn pnpm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  }
  nvm()  { _nvm_load; nvm "$@"; }
  node() { _nvm_load; node "$@"; }
  npm()  { _nvm_load; npm "$@"; }
  npx()  { _nvm_load; npx "$@"; }
  yarn() { _nvm_load; yarn "$@"; }
  pnpm() { _nvm_load; pnpm "$@"; }
fi
