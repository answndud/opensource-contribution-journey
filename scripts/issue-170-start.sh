#!/bin/bash
# Issue #170: Add Maven/Gradle tab support (ADVANCED)
set -euo pipefail

TARGET_REPO="${TARGET_REPO:-$HOME/getting-started-guides}"

echo "🚀 Issue #170: Maven/Gradle 탭 UI 추가 (고급)"
echo "============================================="
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
if git show-ref --verify --quiet refs/heads/feature/issue-170-maven-gradle-tabs; then
    git checkout feature/issue-170-maven-gradle-tabs
else
    git checkout -b feature/issue-170-maven-gradle-tabs
fi

echo ""
echo "2️⃣ 참고: 이미 탭 UI가 있는 가이드 확인..."
echo "   gs-rest-service 가이드에서 Java/Kotlin 탭 구현 참고"
find . -path "*/gs-rest-service/*" -name "*.adoc" | head -5

echo ""
echo "⚠️  작업 예상:"
echo "   - adoc 문법으로 탭 UI 구현"
echo "   - Maven 빌드 지침 탭"
echo "   - Gradle 빌드 지침 탭"
echo "   - Java/Kotlin 탭과 동일한 스타일 적용"
echo ""
echo "이 작업은 복잡하므로 충분히 테스트 후 진행하세요."
echo ""
echo "수정 후 다음 명령어 실행:"
echo "   ./scripts/complete-issue-170.sh"
echo ""
