#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
TAP="scheron/tap"
CASK="${TAP}/daily"
APP_PATH="/Applications/Daily.app"

cleanup() {
  brew uninstall --cask "${CASK}" >/dev/null 2>&1 || true
  brew untap "${TAP}" >/dev/null 2>&1 || true
}
trap cleanup EXIT

echo "Tapping local repository as ${TAP}"
if brew tap | grep -qx "${TAP}"; then
  brew untap "${TAP}"
fi
brew tap "${TAP}" "${REPO_ROOT}"

echo "Running brew audit for ${CASK}"
brew audit --cask --strict "${CASK}"

echo "Installing cask ${CASK}"
brew install --cask "${CASK}"

if [[ ! -d "${APP_PATH}" ]]; then
  echo "Error: ${APP_PATH} was not installed." >&2
  exit 1
fi

echo "Installed app found at ${APP_PATH}"

if xattr -p com.apple.quarantine "${APP_PATH}" >/dev/null 2>&1; then
  echo "Error: quarantine attribute is still present on ${APP_PATH}." >&2
  exit 1
fi

echo "Quarantine attribute is not present on ${APP_PATH}"
