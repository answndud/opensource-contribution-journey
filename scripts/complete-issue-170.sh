#!/bin/bash
# Complete Issue #170 contribution
set -euo pipefail

TARGET_REPO="${TARGET_REPO:-$HOME/getting-started-guides}"

if ! cd "$TARGET_REPO" 2>/dev/null; then
    echo "❌ 대상 저장소를 찾을 수 없습니다: $TARGET_REPO"
    exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Git 저장소가 아닙니다: $TARGET_REPO"
    exit 1
fi

echo "📝 Issue #170 기여 완료"
echo "======================"
echo ""

# 변경사항 확인
echo "1️⃣ 변경사항 확인..."
git diff

echo ""
read -p "변경사항이 맞습니까? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "작업을 취소합니다."
    exit 1
fi

# 커밋
echo "2️⃣ 커밋 생성..."
git add -A
git commit -s -m "feat: add Maven and Gradle tabs to guide

Following the pattern used for Java/Kotlin tabs in the RESTful Web Service
guide, this change adds tabs for Maven and Gradle build instructions.

This improves the user experience by allowing developers to easily
switch between build tool instructions without scrolling.

Closes #170"

# 푸시
echo "3️⃣ 원격 저장소에 푸시..."
git push -u origin feature/issue-170-maven-gradle-tabs

echo ""
echo "✅ 푸시 완료!"
echo ""
echo "PR 생성 URL:"
echo "https://github.com/answndud/getting-started-guides/pull/new/feature/issue-170-maven-gradle-tabs"
echo ""
