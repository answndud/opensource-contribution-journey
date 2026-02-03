#!/bin/bash
# First Contribution Script - Issue #166
# Run this script to complete your first open source contribution

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
cd ~
gh repo fork spring-guides/getting-started-guides --clone=true --default-branch-only
cd getting-started-guides

# 3. Upstream 설정
echo "3️⃣ Upstream 원격 저장소 추가..."
git remote add upstream https://github.com/spring-guides/getting-started-guides.git
git remote -v

# 4. 브랜치 생성
echo "4️⃣ 작업 브랜치 생성..."
git checkout -b fix/issue-166-typo

echo ""
echo "✅ 준비 완료!"
echo ""
echo "다음 단계:"
echo "1. 오타 찾기: grep -r 'misspelled_word' . --include='*.adoc' --include='*.md'"
echo "2. 오타 수정 후 저장"
echo "3. ./complete-contribution.sh 실행"
echo ""
