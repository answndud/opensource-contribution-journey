#!/bin/bash
# Complete Contribution Script
# Run this after fixing the typo
set -euo pipefail

TARGET_REPO="${TARGET_REPO:-$HOME/getting-started-guides}"

echo "📝 기여 완료 스크립트"
echo "==================="
echo ""

if ! cd "$TARGET_REPO" 2>/dev/null; then
    echo "❌ 대상 저장소를 찾을 수 없습니다: $TARGET_REPO"
    exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Git 저장소가 아닙니다: $TARGET_REPO"
    exit 1
fi

# 1. 변경사항 확인
echo "1️⃣ 변경사항 확인..."
git status
git diff

echo ""
echo "변경사항이 맞습니까? (y/n)"
read confirm

if [ "$confirm" != "y" ]; then
    echo "작업을 취소합니다."
    exit 1
fi

# 2. 커밋
echo "2️⃣ 커밋 생성..."
git add -A
git commit -s -m "docs: fix typo in Building an Application with Spring Boot guide

Fix misspelling reported in issue #166.

Closes #166"

# 3. 푸시
echo "3️⃣ 원격 저장소에 푸시..."
git push -u origin fix/issue-166-typo

# 4. PR 생성 안내
echo ""
echo "✅ 푸시 완료!"
echo ""
echo "GitHub에서 PR을 생성하세요:"
echo "  https://github.com/answndud/getting-started-guides/pull/new/fix/issue-166-typo"
echo ""
echo "PR 제목: docs: fix typo in Building an Application with Spring Boot guide"
echo ""
echo "PR 본문 템플릿:"
cat << 'EOF'
## Description
Fix misspelling reported in issue #166.

## Changes
- Fixed typo: [old] → [new]

## Testing
- [x] Verified the fix locally
- [x] All existing tests pass

## Related Issue
Closes #166

## Checklist
- [x] Typo fixed
- [x] No other changes made
- [x] DCO sign-off included
EOF

echo ""
