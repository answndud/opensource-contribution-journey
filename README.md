# 오픈소스 기여 기반 백엔드 포트폴리오

> Java 생태계 오픈소스에 직접 기여하며 문제 정의, 구현, 검증, 리뷰 대응, 회고를 기록한 저장소입니다.
>
> 목표는 단순히 PR 개수를 늘리는 것이 아니라, 어떤 문제를 어떤 범위로 고쳐야 실제로 머지될 수 있는지 판단할 수 있는 백엔드 개발자임을 증명하는 것입니다.

[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 빠른 요약

| 구분 | 내용 |
| ---- | ---- |
| 현재 기록 | 대표 upstream 기여와 기술적으로 선별한 리뷰 대기 PR을 기록 |
| 대표 backend 사례 | Spring Boot `MailSender` failure analysis 개선 PR 머지 |
| 주요 역량 | Spring auto-configuration 분석, 모듈 전용 테스트, API 호환성 리팩터링, maintainer workflow 대응 |
| 바로 볼 문서 | [공개 포트폴리오](docs/portfolio/backend-open-source-portfolio.md), [면접 답변](docs/portfolio/interview-stories.md), [Spring Boot 사례](docs/case-studies/spring-boot-49582.md), [readiness checklist](docs/lessons/rejected-and-closed-prs.md) |

---

## 🎯 이 저장소가 보여주는 것

- Java 생태계 오픈소스에서 실제 이슈를 읽고, 수정 범위를 줄여 PR까지 만든 경험
- 문서 수정, 버그 수정, 설정/진단 개선까지 서로 다른 유형의 변경을 다룬 경험
- 머지된 PR뿐 아니라 종료된 PR까지 분석하며 작업 기준을 개선한 과정
- AI를 탐색과 검증 가속에 활용하되, 최종 판단과 품질 책임은 직접 진 방식

---

## 면접관에게 먼저 보여줄 증거

1. **Spring Boot `#49582` 머지**
   - `MailSender` bean 부재를 단순 missing bean 문제가 아니라 auto-configuration 조건 불일치로 분석했습니다.
   - 공통 로직을 바꾸지 않고 `spring-boot-mail` 모듈 안에서 전용 `FailureAnalyzer`와 모듈 전용 테스트로 해결했습니다.

2. **Apache Iceberg `#15309` 머지**
   - `schemas.md` Markdown 표 정합성 문제를 수정하고 렌더링과 before/after 자료로 변경 근거를 제시했습니다.

3. **Spring Guides `gs-rest-service#175` 머지**
   - Spring Initializr 링크의 패키지 경로와 가이드 예제가 일치하도록 파라미터를 수정했습니다.

---

## 📚 목차

- [빠른 요약](#빠른-요약)
- [이 저장소가 보여주는 것](#-이-저장소가-보여주는-것)
- [면접관에게 먼저 보여줄 증거](#면접관에게-먼저-보여줄-증거)
- [기여 현황](#-기여-현황)
- [✅ 머지된 대표 사례 3건](#-머지된-대표-사례-3건)
- [❌ 거절·종료된 PR에서 배운 점](#-거절종료된-pr에서-배운-점)
- [🤖 AI 활용 방식](#-ai-활용-방식)
- [⏳ 선별한 리뷰 대기 PR](#-선별한-리뷰-대기-pr)
- [공개 문서 안내](#공개-문서-안내)
- [📋 선별 기여 로그](#-선별-기여-로그)

---

## 📊 기여 현황

**기준일**: 2026-08-17

| 항목              | 내용                                                                                                                     |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------ |
| 공개 범위              | 대표 머지 기여와 선별 리뷰 대기 사례                                                        |
| 기록 원칙              | 전체 시도 횟수보다 설명 가능한 대표 사례 중심                                      |
| 주요 프로젝트     | Spring Boot, Apache Iceberg, Spring Guides, Spring Data Redis |

---

## ✅ 머지된 대표 사례 3건

### 1. Spring Boot: `#49582`

- **문제**: `spring-boot-mail`이 있어도 필수 속성이 빠지면 `MailSender` bean이 생성되지 않는데, 기존 failure analysis가 잘못된 해결 방향을 안내하고 있었습니다.
- **해결**: 공통 missing bean 로직을 건드리지 않고, `spring-boot-mail` 모듈 안에 mail 전용 `FailureAnalyzer`를 추가했습니다.
- **배운 점**: 좋은 PR은 큰 리팩터링보다 정확한 문제 정의, 기존 패턴 재사용, 작은 수정 범위에서 나옵니다.
- **상세 문서**: [Spring Boot 사례 자세히 보기](docs/case-studies/spring-boot-49582.md)
- **PR 링크**: [spring-projects/spring-boot#49582](https://github.com/spring-projects/spring-boot/pull/49582)

### 2. Apache Iceberg: `#15309`

- **문제**: `schemas.md`의 `uuid` 행에 마크다운 표 문법 오류가 있었고, 문서 정합성이 깨져 있었습니다.
- **해결**: 누락된 Notes 컬럼과 닫는 파이프를 복구하고, 렌더링과 before/after 자료로 변경 의도를 설명했습니다.
- **배운 점**: 겉으로 보이는 변화가 작아도, 문법 정합성과 리뷰 증거를 같이 제시해야 설득력이 생깁니다.
- **상세 문서**: [Apache Iceberg 사례 자세히 보기](docs/case-studies/apache-iceberg-15309.md)
- **PR 링크**: [apache/iceberg#15309](https://github.com/apache/iceberg/pull/15309)

### 3. Spring Guides: `gs-rest-service#175`

- **문제**: pre-initialized project 링크의 `packageName`이 실제 가이드 코드 경로와 맞지 않았습니다.
- **해결**: Spring Initializr 링크 파라미터를 수정해 생성 결과와 문서 예제가 일치하도록 맞췄습니다.
- **배운 점**: 첫 기여일수록 작고 명확하며 저장소 경계가 분명한 문제를 고르는 것이 중요합니다.
- **상세 문서**: [Spring Guides 사례 자세히 보기](docs/case-studies/gs-rest-service-175.md)
- **PR 링크**: [spring-guides/gs-rest-service#175](https://github.com/spring-guides/gs-rest-service/pull/175)

---

## ❌ 거절·종료된 PR에서 배운 점

종료된 시도는 이력서의 대표 성과 목록에서 제외하고, 작업 기준을 만든 회고 자료로만 보관합니다.
상세 분석과 이후 작업 기준은 아래 문서에 정리했습니다.

- [거절·종료된 PR에서 배운 점 자세히 보기](docs/lessons/rejected-and-closed-prs.md)

---

## 🤖 AI 활용 방식

- 이슈 후보 탐색, 관련 코드 위치 파악, 테스트 명령 정리에 AI를 보조 도구로 사용합니다.
- 실제 구현 방향은 maintainer 코멘트, 기존 코드 패턴, 로컬 테스트 결과를 기준으로 판단합니다.
- PR 본문과 포트폴리오 기록에는 어떤 문제를 왜 고쳤는지, 어떤 검증을 했는지 직접 추적 가능하게 남깁니다.

---

## ⏳ 선별한 리뷰 대기 PR

- [spring-data-redis#3361](https://github.com/spring-projects/spring-data-redis/pull/3361)

기술적 판단과 변경 범위를 면접에서 설명할 수 있는 PR만 공개 목록에 남깁니다.

---

## 공개 문서 안내

- [대표 머지 사례 3건](docs/case-studies/README.md)
- [백엔드 오픈소스 포트폴리오 요약](docs/portfolio/backend-open-source-portfolio.md)
- [면접용 대표 답변 정리](docs/portfolio/interview-stories.md)
- [거절·종료된 PR에서 배운 점과 readiness checklist](docs/lessons/rejected-and-closed-prs.md)
- [오픈소스 기여 가이드](docs/guides/open-source-contribution-guide.md)
- [Spring 프로젝트 추천 정리](docs/guides/spring-project-recommendations.md)
- [로컬 환경 정리](docs/guides/local-setup.md)

---

## 📋 선별 기여 로그

전체 시도 목록 대신, 이력서와 면접에서 설명할 가치가 있는 대표 사례만 기록합니다.

| 프로젝트          | 유형      | 상태    | 링크                                                                    |
| ----------------- | --------- | ------- | ----------------------------------------------------------------------- |
| spring-boot       | 버그 수정 | ✅ 머지 | [#49582](https://github.com/spring-projects/spring-boot/pull/49582)     |
| apache/iceberg    | 문서      | ✅ 머지 | [#15309](https://github.com/apache/iceberg/pull/15309)                  |
| gs-rest-service   | 문서      | ✅ 머지 | [#175](https://github.com/spring-guides/gs-rest-service/pull/175)       |
| spring-data-redis | 리팩터링  | ⏳ 대기 | [#3361](https://github.com/spring-projects/spring-data-redis/pull/3361) |

---

_마지막 업데이트: 2026-08-17_
