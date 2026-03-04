#!/bin/bash
# Issue #163: Fix broken WAR file link
set -euo pipefail

TARGET_REPO="${TARGET_REPO:-$HOME/getting-started-guides}"

echo "🚀 Issue #163: WAR 파일 링크 404 수정"
echo "======================================="
echo ""

if ! cd "$TARGET_REPO" 2>/dev/null; then
    echo "❌ getting-started-guides 저장소를 먼저 클론하세요"
    exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Git 저장소가 아닙니다: $TARGET_REPO"
    exit 1
fi

# 브랜치 생성
echo "1️⃣ 작업 브랜치 생성..."
if git show-ref --verify --quiet refs/heads/fix/issue-163-war-link; then
    git checkout fix/issue-163-war-link
else
    git checkout -b fix/issue-163-war-link
fi

echo ""
echo "2️⃣ gs/accessing-data-jpa 가이드에서 'build a classic WAR file' 링크 찾기..."
grep -r "classic WAR file" . --include="*.adoc" --include="*.md" -n || true

echo ""
echo "3️⃣ 수정 방법 선택:"
echo "   A) 올바른 Spring 문서 링크로 교체"
echo "   B) 'WAR' 관련 문구 제거하고 일반적인 설명으로 변경"
echo ""
echo "수정 후 다음 명령어 실행:"
echo "   ./scripts/complete-issue-163.sh"
echo ""
