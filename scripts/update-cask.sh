#!/usr/bin/env bash
set -euo pipefail

OWNER="scheron"
REPO="Daily"
CASK_FILE="Casks/daily.rb"
API_URL="https://api.github.com/repos/${OWNER}/${REPO}/releases/latest"

if [[ ! -f "${CASK_FILE}" ]]; then
  echo "Error: ${CASK_FILE} not found." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

get_latest_version() {
  local json
  json="$(curl -fsSL "${API_URL}")"

  local tag
  tag="$(printf '%s' "${json}" | sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"

  if [[ -z "${tag}" ]]; then
    echo "Error: unable to parse latest release tag from ${API_URL}." >&2
    exit 1
  fi

  printf '%s\n' "${tag#v}"
}

normalize_version() {
  local input="${1:-}"
  if [[ -z "${input}" ]]; then
    get_latest_version
  else
    printf '%s\n' "${input#v}"
  fi
}

version="$(normalize_version "${1:-}")"
tag="v${version}"
asset="Daily-${version}-mac.dmg"
dmg_url="https://github.com/${OWNER}/${REPO}/releases/download/${tag}/${asset}"
dmg_path="${tmp_dir}/${asset}"
backup_path="${tmp_dir}/daily.rb.bak"

echo "Target version: ${version}"
echo "Downloading: ${dmg_url}"
curl -fL "${dmg_url}" -o "${dmg_path}"

sha256="$(shasum -a 256 "${dmg_path}" | awk '{print $1}')"
if [[ -z "${sha256}" ]]; then
  echo "Error: failed to calculate sha256 for ${asset}." >&2
  exit 1
fi

echo "Computed sha256: ${sha256}"

cp "${CASK_FILE}" "${backup_path}"

awk -v version="${version}" -v sha256="${sha256}" '
  /^  version "/ { $0 = "  version \"" version "\"" }
  /^  sha256 "/ { $0 = "  sha256 \"" sha256 "\"" }
  { print }
' "${backup_path}" > "${CASK_FILE}"

if cmp -s "${backup_path}" "${CASK_FILE}"; then
  echo "No changes detected in ${CASK_FILE}."
  exit 0
fi

echo "Updated ${CASK_FILE} to ${version}."
