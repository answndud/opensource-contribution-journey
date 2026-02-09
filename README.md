# Open Source Contribution Journey

> **Spring Boot 오픈소스 기여 활동 기록**  
> 백엔드 개발자 취업을 위한 포트폴리오 프로젝트

[![GitHub Repo](https://img.shields.io/badge/GitHub-Repo-blue?logo=github)](https://github.com/answndud/opensource-contribution-journey)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-green?logo=spring)](https://spring.io/projects/spring-boot)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🎯 프로젝트 목표

**기간**: 2025년 2월 ~ 5월 (3개월)  
**목표**: Spring Boot 생태계에 **10개 이상**의 기여 활동  
**최종 목적**: 백엔드 개발자 취업 및 포트폴리오 구축

### 기여 목표
| 유형 | 목표 | 현재 |
|-----|------|------|
| 문서 기여 | 3개 | 0개 |
| 버그 수정 | 4개 | 0개 |
| 기능 추가 | 3개 | 0개 |

---

## 📚 가이드 문서

### 🚀 시작하기
- [`01-guide-open-source-contribution.md`](01-guide-open-source-contribution.md) - 오픈소스 기여 완벽 가이드
- [`02-guide-spring-boot-projects.md`](02-guide-spring-boot-projects.md) - Spring Boot 프로젝트 추천 목록
- [`03-progress-plan.md`](03-progress-plan.md) - 상세 진행 계획 및 타임라인

### 🛠️ 개발 환경
- [AGENTS.md](AGENTS.md) - AI 에이전트 및 기여자를 위한 가이드라인

---

## 🗓️ 진행 현황

### Phase 0: 환경 설정 (✅ 완료)
- 개발 도구 설치 (Git, GitHub CLI, Markdown tools, SDKMAN)
- 포트폴리오 문서 구조 작성
- GitHub 저장소 연결

### Phase 1: 첫 기여 (🔄 진행 중)
- **PR 1**: [gs-rest-service#172 - docs: fix jarfile name in README](https://github.com/spring-guides/gs-rest-service/pull/172)
- **PR 2**: [getting-started-macros#19 - docs: fix broken classic WAR link](https://github.com/spring-guides/getting-started-macros/pull/19)
- **PR 3**: [gs-rest-service#173 - docs: add Gradle and Maven build tabs](https://github.com/spring-guides/gs-rest-service/pull/173)
- **PR 4**: [gs-rest-service#175 - docs: fix Initializr package name](https://github.com/spring-guides/gs-rest-service/pull/175)
- **PR 5**: [spring-restdocs#1022 - fix: avoid inferring Content-Type without body](https://github.com/spring-projects/spring-restdocs/pull/1022)
- **PR 6**: [spring-restdocs#1023 - feat: support path prefixes in modifyUris](https://github.com/spring-projects/spring-restdocs/pull/1023)
- **상태**: PR1 workflow 승인 대기, PR2 checks passed, PR3/PR4/PR5/PR6 리뷰 대기

### Phase 2~5: 예정
- PetClinic 버그 수정
- Spring Data 예제 추가
- Spring Cloud 기여
- 취업 준비 및 면접

---

## 📊 기여 활동

### PR 목록
| # | 프로젝트 | 유형 | 상태 | 링크 |
|---|---------|------|------|------|
| 1 | gs-rest-service | 문서 | 🔄 진행중 | https://github.com/spring-guides/gs-rest-service/pull/172 |
| 2 | getting-started-macros | 문서 | 🔄 진행중 | https://github.com/spring-guides/getting-started-macros/pull/19 |
| 3 | gs-rest-service | 문서 | 🔄 진행중 | https://github.com/spring-guides/gs-rest-service/pull/173 |
| 4 | gs-rest-service | 문서 | 🔄 진행중 | https://github.com/spring-guides/gs-rest-service/pull/175 |
| 5 | spring-restdocs | 버그 수정 | 🔄 진행중 | https://github.com/spring-projects/spring-restdocs/pull/1022 |
| 6 | spring-restdocs | 기능 추가 | 🔄 진행중 | https://github.com/spring-projects/spring-restdocs/pull/1023 |

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

## 🎓 면접 준비 자료

이 저장소는 다음을 포함합니다:
- ✅ **포트폴리오 가이드**: 프로젝트 선택 이유 및 기여 과정
- ✅ **기여 트래킹**: PR 기록 및 성과 분석
- ✅ **기술 학습 일지**: Spring Boot 심화 학습 내용
- ✅ **회고 템플릿**: Keep/Problem/Try 방식의 성장 기록
- ✅ **면접 가이드**: STAR 기법을 활용한 답변 준비

*(상세 포트폴리오 문서는 로컬 `03-portfolio/` 폴더에 있으며, 개인 학습 기록으로 비공개)*

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

## 📞 연락처

- **GitHub**: [@answndud](https://github.com/answndud)
- **Email**: jmoon0227@gmail.com
- **Blog**: *(추후 업데이트)*

---

## 📄 라이선스

이 프로젝트는 [MIT 라이선스](LICENSE) 하에 제공됩니다.

---

**⭐ Star를 눌러주시면 더 많은 개발자들이 이 가이드를 발견할 수 있습니다!**

*마지막 업데이트: 2025년 2월 3일*
