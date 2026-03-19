# Open Source Contribution Journey

> **Spring Boot 오픈소스 기여 활동 기록**  
> 백엔드 개발자 취업을 위한 포트폴리오 프로젝트

[![GitHub Repo](https://img.shields.io/badge/GitHub-Repo-blue?logo=github)](https://github.com/answndud/opensource-contribution-journey)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-green?logo=spring)](https://spring.io/projects/spring-boot)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🎯 프로젝트 목표

**기간**: 2025년 2월 ~ 진행 중  
**기준일**: 2026년 3월 19일  
**목표**: Spring Boot 생태계에 **10개 이상**의 기여 활동  
**최종 목적**: 백엔드 개발자 취업 및 포트폴리오 구축

### 기여 목표

| 유형 | 목표 | 현재 |
| ---- | ---- | ---- |
| 문서 기여 | 3개 | 6개 |
| 버그 수정 | 4개 | 12개 |
| 기능 추가 | 3개 | 3개 |

---

## 📊 기여 활동

### 한눈에 보기

| 총 PR | ✅ 머지 | ⏳ 리뷰 대기 | ⚪ 거부·종료 |
| --- | --- | --- | --- |
| 21개 | 3개 | 6개 | 12개 |

### 🔎 지금 확인할 PR (리뷰 대기)
- [querydsl#3933](https://github.com/querydsl/querydsl/pull/3933)
- [querydsl#3934](https://github.com/querydsl/querydsl/pull/3934)
- [spring-batch#5316](https://github.com/spring-projects/spring-batch/pull/5316)
- [spring-batch#5318](https://github.com/spring-projects/spring-batch/pull/5318)
- [spring-batch#5339](https://github.com/spring-projects/spring-batch/pull/5339)
- [spring-batch#5351](https://github.com/spring-projects/spring-batch/pull/5351)

### 🔁 운영 루틴 (매일 10분)
- 상태 스냅샷 생성: `./scripts/pr-status-snapshot.sh README.md > /tmp/pr-status-snapshot.md`
- 스냅샷에서 상태가 바뀐 PR은 같은 작업 턴에 `portfolio/기여-활동/기여-활동-트래킹.md`에 반영
- 구현, 리뷰, CI, 해결 방향이 바뀐 PR은 `portfolio/기여-활동/기여-상세-기록.md`도 같은 턴에 반영
- 리뷰 대기 7일 이상이면 영어 follow-up 코멘트 1회 작성
- 변경이 있으면 README의 `한눈에 보기` 수치 갱신

### PR 목록 (전체)

| # | 프로젝트 | 유형 | 상태 | 링크 |
| --- | --- | --- | --- | --- |
| 1 | gs-rest-service | 문서 | ❌ 거부 | [#172](https://github.com/spring-guides/gs-rest-service/pull/172) |
| 2 | getting-started-macros | 문서 | ❌ 거부 | [#19](https://github.com/spring-guides/getting-started-macros/pull/19) |
| 3 | gs-rest-service | 문서 | ❌ 거부 | [#173](https://github.com/spring-guides/gs-rest-service/pull/173) |
| 4 | gs-rest-service | 문서 | ✅ 머지 | [#175](https://github.com/spring-guides/gs-rest-service/pull/175) |
| 5 | spring-restdocs | 버그 수정 | ❌ 거부 | [#1022](https://github.com/spring-projects/spring-restdocs/pull/1022) |
| 6 | spring-restdocs | 기능 추가 | ❌ 거부 | [#1023](https://github.com/spring-projects/spring-restdocs/pull/1023) |
| 7 | querydsl | 버그 수정 | ⏳ 리뷰 대기 | [#3933](https://github.com/querydsl/querydsl/pull/3933) |
| 8 | querydsl | 버그 수정 | ⏳ 리뷰 대기 | [#3934](https://github.com/querydsl/querydsl/pull/3934) |
| 9 | apache/iceberg | 문서 | ✅ 머지 | [#15309](https://github.com/apache/iceberg/pull/15309) |
| 10 | spring-batch | 버그 수정 | ⚪ 철회(중복 이슈) | [#5309](https://github.com/spring-projects/spring-batch/pull/5309) |
| 11 | spring-batch | 문서 | ⚪ 종료(SNAPSHOT docs 방향 불가) | [#5313](https://github.com/spring-projects/spring-batch/pull/5313) |
| 12 | spring-batch | 버그 수정 | ⚪ 종료(선행 PR #5296 우선) | [#5315](https://github.com/spring-projects/spring-batch/pull/5315) |
| 13 | spring-batch | 버그 수정 | ⏳ 리뷰 대기 | [#5316](https://github.com/spring-projects/spring-batch/pull/5316) |
| 14 | spring-batch | 버그 수정 | ⚪ 종료(문서 가이드 방향으로 자진 종료) | [#5317](https://github.com/spring-projects/spring-batch/pull/5317) |
| 15 | spring-batch | 버그 수정 | ⏳ 리뷰 대기 | [#5318](https://github.com/spring-projects/spring-batch/pull/5318) |
| 16 | spring-batch | 기능 추가 | ⏳ 리뷰 대기 | [#5339](https://github.com/spring-projects/spring-batch/pull/5339) |
| 17 | spring-security | 버그 수정 | ⚪ 종료(팀 검토 결과 fix 불필요) | [#18850](https://github.com/spring-projects/spring-security/pull/18850) |
| 18 | spring-boot | 버그 수정 | ✅ 머지 | [#49582](https://github.com/spring-projects/spring-boot/pull/49582) |
| 19 | spring-security | 버그 수정 | ⚪ 종료(triage 전 PR로 자진 종료) | [#18889](https://github.com/spring-projects/spring-security/pull/18889) |
| 20 | spring-boot | 기능 추가 | ⚪ 종료(이미 assign된 이슈) | [#49594](https://github.com/spring-projects/spring-boot/pull/49594) |
| 21 | spring-batch | 버그 수정 | ⏳ 리뷰 대기 | [#5351](https://github.com/spring-projects/spring-batch/pull/5351) |

---

## 💡 주요 학습 내용

### 기술 스택
- **Backend**: Spring Boot 3.x, Spring Data JPA, Spring Security
- **Testing**: JUnit 5, Testcontainers, MockMvc
- **DevOps**: GitHub Actions, Docker, Kubernetes
- **Tools**: Maven, Gradle, Git, GitHub CLI

### 오픈소스 기여 프로세스
1. 이슈 탐색 및 선점
2. Fork & Clone
3. 로컬 개발 및 테스트
4. PR 제출 및 리뷰 대응
5. 머지 및 정리

---

## 🛠️ 설치 및 사용법

### 필요한 도구
```bash
# Git 설정
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Markdown 도구 (로컬 설치)
npm install

# GitHub CLI
brew install gh

# SDKMAN (Java 버전 관리)
curl -s "https://get.sdkman.io" | bash
```

### 문서 검증
```bash
# 링크 검사
npm run lint:links

# 포맷팅
npm run format

# 문법 검사
npm run lint:md
```

---

*마지막 업데이트: 2026년 3월 19일*
