#!/bin/bash
# First Contribution Script - Issue #166
# Run this script to complete your first open source contribution
set -euo pipefail

CONTRIB_HOME="${CONTRIB_HOME:-$HOME}"
TARGET_REPO="${TARGET_REPO:-$CONTRIB_HOME/getting-started-guides}"

echo "🚀 Spring Boot 오픈소스 첫 기여 자동화 스크립트"
echo "================================================"
echo ""

# 1. GitHub CLI 인증 확인
echo "1️⃣ GitHub CLI 인증 확인..."
gh auth status || {
    echo "GitHub CLI 인증이 필요합니다. 다음 명령어를 실행하세요:"
    echo "  gh auth login"
    exit 1
}

# 2. 저장소 Fork
echo "2️⃣ getting-started-guides 저장소 Fork..."
if [ -d "$TARGET_REPO/.git" ]; then
    echo "이미 저장소가 존재합니다: $TARGET_REPO"
else
    if ! cd "$CONTRIB_HOME" 2>/dev/null; then
        echo "❌ 작업 디렉터리에 접근할 수 없습니다: $CONTRIB_HOME"
        exit 1
    fi
    gh repo fork spring-guides/getting-started-guides --clone=true --default-branch-only
fi

if ! cd "$TARGET_REPO" 2>/dev/null; then
    echo "❌ 저장소로 이동할 수 없습니다: $TARGET_REPO"
    exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Git 저장소가 아닙니다: $TARGET_REPO"
    exit 1
fi

# 3. Upstream 설정
echo "3️⃣ Upstream 원격 저장소 추가..."
if git remote get-url upstream >/dev/null 2>&1; then
    echo "upstream 원격이 이미 설정되어 있습니다."
else
    git remote add upstream https://github.com/spring-guides/getting-started-guides.git
fi
git remote -v

# 4. 브랜치 생성
echo "4️⃣ 작업 브랜치 생성..."
if git show-ref --verify --quiet refs/heads/fix/issue-166-typo; then
    git checkout fix/issue-166-typo
else
    git checkout -b fix/issue-166-typo
fi

echo ""
echo "✅ 준비 완료!"
echo ""
echo "다음 단계:"
echo "1. 오타 찾기: grep -r 'misspelled_word' . --include='*.adoc' --include='*.md'"
echo "2. 오타 수정 후 저장"
echo "3. ./scripts/complete-contribution.sh 실행"
echo ""
