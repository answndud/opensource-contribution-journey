#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_FILE="${1:-$ROOT_DIR/README.md}"

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: gh is required. Install GitHub CLI first." >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq is required." >&2
  exit 1
fi

if ! command -v rg >/dev/null 2>&1; then
  echo "ERROR: rg is required." >&2
  exit 1
fi

if [[ ! -f "$SOURCE_FILE" ]]; then
  echo "ERROR: source file not found: $SOURCE_FILE" >&2
  exit 1
fi

PR_URLS=()
while IFS= read -r line; do
  PR_URLS+=("$line")
done < <(rg -o 'https://github\.com/[^ )\]]+/pull/[0-9]+' "$SOURCE_FILE" | sort -u)

if [[ ${#PR_URLS[@]} -eq 0 ]]; then
  echo "No PR URLs found in $SOURCE_FILE"
  exit 0
fi

open_count=0
merged_count=0
closed_count=0

echo "# PR Status Snapshot"
echo
echo "- Source: \`$SOURCE_FILE\`"
echo "- Checked at: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo
echo "| PR | 상태 | 업데이트 | 제목 |"
echo "| --- | --- | --- | --- |"

for url in "${PR_URLS[@]}"; do
  path="${url#https://github.com/}"
  owner="${path%%/*}"
  remain="${path#*/}"
  repo_name="${remain%%/*}"
  number="${path##*/}"
  repo="$owner/$repo_name"

  pr_json="$(gh api "repos/$repo/pulls/$number")"

  state="$(jq -r '.state' <<<"$pr_json")"
  merged_at="$(jq -r '.merged_at // empty' <<<"$pr_json")"
  updated_at="$(jq -r '.updated_at' <<<"$pr_json")"
  title="$(jq -r '.title' <<<"$pr_json" | tr '|' '/')"

  status="⚪ 종료"
  if [[ -n "$merged_at" ]]; then
    status="✅ 머지"
    merged_count=$((merged_count + 1))
  elif [[ "$state" == "open" ]]; then
    status="⏳ 대기"
    open_count=$((open_count + 1))
  else
    closed_count=$((closed_count + 1))
  fi

  echo "| [$repo#$number]($url) | $status | $updated_at | $title |"
done

total_count=$((open_count + merged_count + closed_count))
echo
echo "## Summary"
echo
echo "- Total: $total_count"
echo "- ✅ 머지: $merged_count"
echo "- ⏳ 대기: $open_count"
echo "- ⚪ 종료: $closed_count"
