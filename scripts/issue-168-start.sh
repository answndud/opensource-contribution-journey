#!/bin/bash
# Issue #168: Maven jarfile name fix automation

echo "🚀 Issue #168: Maven jarfile 오류 수정"
echo "========================================="
echo ""

cd ~/getting-started-guides 2>/dev/null || {
    echo "❌ getting-started-guides 저장소를 먼저 클론하세요:"
    echo "  gh repo fork spring-guides/getting-started-guides --clone=true"
    exit 1
}

# 브랜치 생성
echo "1️⃣ 작업 브랜치 생성..."
git checkout -b fix/issue-168-jarfile-name

echo ""
echo "2️⃣ 수정할 파일 찾기..."
echo "   검색 중: gs-rest-service 가이드"
find . -path "*/gs-rest-service/*" -name "*.adoc" -o -path "*/gs-rest-service/*" -name "*.md" | head -10

echo ""
echo "3️⃣ 수정해야 할 내용:"
echo "   - 변경 전: target/gs-rest-service-0.1.0.jar"
echo "   - 변경 후: target/rest-service-0.0.1-SNAPSHOT.jar"
echo ""
echo "4️⃣ 파일 수정 후 다음 명령어 실행:"
echo "   ./complete-issue-168.sh"
echo ""
