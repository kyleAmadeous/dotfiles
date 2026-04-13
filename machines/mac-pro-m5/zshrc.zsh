# === mac-pro-m5 machine-specific zsh config ===

# gcloud CLI: pin to Homebrew Python 3.13 (bundled 3.9 is deprecated)
export CLOUDSDK_PYTHON="/opt/homebrew/bin/python3.13"

# Homebrew gcloud SDK shell integration
if [ -f "/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc" ]; then
    source "/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc" ]; then
    source "/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc"
fi
