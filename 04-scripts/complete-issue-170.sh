#!/bin/bash
# Complete Issue #170 contribution

cd ~/getting-started-guides

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
git add .
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
