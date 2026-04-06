# 오픈소스 기여 기반 백엔드 포트폴리오

> Spring/Java 오픈소스 프로젝트에 직접 기여하며 문제 정의, 구현, 검증, 리뷰 대응, 회고를 기록한 저장소입니다.
>
> 목표는 단순히 PR 개수를 늘리는 것이 아니라, 어떤 문제를 어떤 범위로 고쳐야 실제로 머지될 수 있는지 판단할 수 있는 백엔드 개발자임을 증명하는 것입니다.

[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📚 목차

- [이 저장소가 보여주는 것](#-이-저장소가-보여주는-것)
- [기여 현황](#-기여-현황)
- [✅ 머지된 대표 사례 3건](#-머지된-대표-사례-3건)
- [❌ 거절·종료된 PR에서 배운 점](#-거절종료된-pr에서-배운-점)
- [🤖 AI 활용 방식](#-ai-활용-방식)
- [⏳ 현재 진행 중인 PR](#-현재-진행-중인-pr)
- [공개 문서 안내](#공개-문서-안내)
- [📋 전체 기여 로그](#-전체-기여-로그)

---

## 🎯 이 저장소가 보여주는 것

- Spring 생태계와 Java 오픈소스 프로젝트에서 실제 이슈를 읽고, 수정 범위를 좁혀 PR까지 만든 경험
- 문서 수정, 버그 수정, 설정/진단 개선까지 서로 다른 유형의 변경을 다룬 경험
- 머지된 PR뿐 아니라 종료된 PR까지 분석하며 작업 기준을 개선한 과정
- AI를 탐색과 검증 가속에 활용하되, 최종 판단과 품질 책임은 직접 진 방식

---

## 📊 기여 현황

**기준일**: 2026-04-06

| 항목 | 내용 |
| ---- | ---- |
| 총 PR | 21개 |
| ✅ 머지 | 3개 |
| ⏳ 리뷰 대기 | 6개 |
| ⚪ 종료·자진 정리 | 12개 |
| 주요 프로젝트 | Spring Guides, Spring REST Docs, Spring Batch, Spring Boot, Spring Security, Apache Iceberg, Querydsl |

중요한 건 단순 수치보다, 어떤 PR이 왜 머지됐고 어떤 PR이 왜 종료됐는지를 계속 분석해 다음 작업 방식에 반영했다는 점입니다.

---

## ✅ 머지된 대표 사례 3건

### 1. Spring Guides: `gs-rest-service#175`

- **문제**: pre-initialized project 링크의 `packageName`이 실제 가이드 코드 경로와 맞지 않았습니다.
- **해결**: Spring Initializr 링크 파라미터를 수정해 생성 결과와 문서 예제가 일치하도록 맞췄습니다.
- **배운 점**: 첫 기여일수록 작고 명확하며 저장소 경계가 분명한 문제를 고르는 것이 중요합니다.
- **상세 문서**: [Spring Guides 사례 자세히 보기](docs/case-studies/gs-rest-service-175.md)
- **PR 링크**: [spring-guides/gs-rest-service#175](https://github.com/spring-guides/gs-rest-service/pull/175)

### 2. Apache Iceberg: `#15309`

- **문제**: `schemas.md`의 `uuid` 행에 마크다운 표 문법 오류가 있었고, 문서 정합성이 깨져 있었습니다.
- **해결**: 누락된 Notes 컬럼과 닫는 파이프를 복구하고, 렌더링과 before/after 자료로 변경 의도를 설명했습니다.
- **배운 점**: 겉으로 보이는 변화가 작아도, 문법 정합성과 리뷰 증거를 같이 제시해야 설득력이 생깁니다.
- **상세 문서**: [Apache Iceberg 사례 자세히 보기](docs/case-studies/apache-iceberg-15309.md)
- **PR 링크**: [apache/iceberg#15309](https://github.com/apache/iceberg/pull/15309)

### 3. Spring Boot: `#49582`

- **문제**: `spring-boot-mail`이 있어도 필수 속성이 빠지면 `MailSender` bean이 생성되지 않는데, 기존 failure analysis가 잘못된 해결 방향을 안내하고 있었습니다.
- **해결**: 공통 missing bean 로직을 건드리지 않고, `spring-boot-mail` 모듈 안에 mail 전용 `FailureAnalyzer`를 추가했습니다.
- **배운 점**: 좋은 PR은 큰 리팩터링보다 정확한 문제 정의, 기존 패턴 재사용, 작은 수정 범위에서 나옵니다.
- **상세 문서**: [Spring Boot 사례 자세히 보기](docs/case-studies/spring-boot-49582.md)
- **PR 링크**: [spring-projects/spring-boot#49582](https://github.com/spring-projects/spring-boot/pull/49582)

---

## ❌ 거절·종료된 PR에서 배운 점

저는 종료된 PR을 숨기지 않습니다. 오히려 어떤 기준이 빠져 있었는지 보여주는 자료라고 생각합니다.

대표적으로 배운 패턴은 아래 네 가지였습니다.

1. **구조를 모르면 맞는 수정도 틀린 PR이 된다**
   - `gs-rest-service#172`, `getting-started-macros#19`, `gs-rest-service#173`
   - 문서 문제처럼 보여도 실제 수정 지점은 공통 매크로나 팀이 이미 정해 둔 방향일 수 있었습니다.

2. **버그처럼 보여도 의도된 동작일 수 있다**
   - `spring-restdocs#1022`
   - HTTP semantics와 라이브러리 철학을 먼저 확인해야 했습니다.

3. **기능 추가는 강한 use case 없이는 받아들여지지 않는다**
   - `spring-restdocs#1023`
   - 구현 가능성과 머지 가능성은 다르다는 점을 배웠습니다.

4. **코드가 맞아도 프로세스를 어기면 종료될 수 있다**
   - `spring-security#18850`, `spring-security#18889`, `spring-boot#49594`
   - assignee, triage 상태, maintainer 코멘트를 확인하지 않고 먼저 움직이면 작업 방향이 어긋날 수 있었습니다.

상세 분석과 이후 작업 기준은 아래 문서에 정리했습니다.

- [거절·종료된 PR에서 배운 점 자세히 보기](docs/lessons/rejected-and-closed-prs.md)

---

## 🤖 AI 활용 방식

AI는 생산성 도구로 적극 활용했지만, 판단과 책임은 직접 가져갔습니다.

- **AI가 도운 부분**
  - 코드베이스 탐색 속도 향상
  - 관련 구현 패턴 후보 정리
  - 테스트 케이스 초안과 반례 탐색
  - PR/회고 문서 초안 구조화

- **직접 판단한 부분**
  - 어떤 이슈를 실제로 건드릴지
  - 수정 범위를 어디까지로 제한할지
  - 로컬 검증 환경과 toolchain 문제 분리
  - maintainer workflow와 triage 상태 해석
  - 최종 PR 코멘트와 후속 대응 방향

즉, AI는 탐색과 정리를 가속하는 데 사용했고, 최종 품질과 커뮤니케이션 책임은 직접 졌습니다.

---

## ⏳ 현재 진행 중인 PR

- [querydsl#3933](https://github.com/querydsl/querydsl/pull/3933)
- [querydsl#3934](https://github.com/querydsl/querydsl/pull/3934)
- [spring-batch#5316](https://github.com/spring-projects/spring-batch/pull/5316)
- [spring-batch#5318](https://github.com/spring-projects/spring-batch/pull/5318)
- [spring-batch#5339](https://github.com/spring-projects/spring-batch/pull/5339)
- [spring-batch#5351](https://github.com/spring-projects/spring-batch/pull/5351)

리뷰 대기 PR도 단순히 쌓아 두지 않고, maintainer 반응 가능성, 프로젝트 활동성, triage 상태를 기준으로 계속 분류하고 있습니다.

---

## 공개 문서 안내

- [대표 머지 사례 3건](docs/case-studies/README.md)
- [거절·종료된 PR에서 배운 점](docs/lessons/rejected-and-closed-prs.md)
- [오픈소스 기여 가이드](docs/guides/open-source-contribution-guide.md)
- [Spring 프로젝트 추천 정리](docs/guides/spring-project-recommendations.md)
- [로컬 환경 정리](docs/guides/local-setup.md)

---

## 📋 전체 기여 로그

| # | 프로젝트 | 유형 | 상태 | 링크 |
| --- | --- | --- | --- | --- |
| 1 | gs-rest-service | 문서 | ⚪ 종료 | [#172](https://github.com/spring-guides/gs-rest-service/pull/172) |
| 2 | getting-started-macros | 문서 | ⚪ 종료 | [#19](https://github.com/spring-guides/getting-started-macros/pull/19) |
| 3 | gs-rest-service | 문서 | ⚪ 종료 | [#173](https://github.com/spring-guides/gs-rest-service/pull/173) |
| 4 | gs-rest-service | 문서 | ✅ 머지 | [#175](https://github.com/spring-guides/gs-rest-service/pull/175) |
| 5 | spring-restdocs | 버그 수정 | ⚪ 종료 | [#1022](https://github.com/spring-projects/spring-restdocs/pull/1022) |
| 6 | spring-restdocs | 기능 추가 | ⚪ 종료 | [#1023](https://github.com/spring-projects/spring-restdocs/pull/1023) |
| 7 | querydsl | 버그 수정 | ⏳ 대기 | [#3933](https://github.com/querydsl/querydsl/pull/3933) |
| 8 | querydsl | 버그 수정 | ⏳ 대기 | [#3934](https://github.com/querydsl/querydsl/pull/3934) |
| 9 | apache/iceberg | 문서 | ✅ 머지 | [#15309](https://github.com/apache/iceberg/pull/15309) |
| 10 | spring-batch | 버그 수정 | ⚪ 종료 | [#5309](https://github.com/spring-projects/spring-batch/pull/5309) |
| 11 | spring-batch | 문서 | ⚪ 종료 | [#5313](https://github.com/spring-projects/spring-batch/pull/5313) |
| 12 | spring-batch | 버그 수정 | ⚪ 종료 | [#5315](https://github.com/spring-projects/spring-batch/pull/5315) |
| 13 | spring-batch | 버그 수정 | ⏳ 대기 | [#5316](https://github.com/spring-projects/spring-batch/pull/5316) |
| 14 | spring-batch | 버그 수정 | ⚪ 종료 | [#5317](https://github.com/spring-projects/spring-batch/pull/5317) |
| 15 | spring-batch | 버그 수정 | ⏳ 대기 | [#5318](https://github.com/spring-projects/spring-batch/pull/5318) |
| 16 | spring-batch | 기능 추가 | ⏳ 대기 | [#5339](https://github.com/spring-projects/spring-batch/pull/5339) |
| 17 | spring-security | 버그 수정 | ⚪ 종료 | [#18850](https://github.com/spring-projects/spring-security/pull/18850) |
| 18 | spring-boot | 버그 수정 | ✅ 머지 | [#49582](https://github.com/spring-projects/spring-boot/pull/49582) |
| 19 | spring-security | 버그 수정 | ⚪ 종료 | [#18889](https://github.com/spring-projects/spring-security/pull/18889) |
| 20 | spring-boot | 기능 추가 | ⚪ 종료 | [#49594](https://github.com/spring-projects/spring-boot/pull/49594) |
| 21 | spring-batch | 버그 수정 | ⏳ 대기 | [#5351](https://github.com/spring-projects/spring-batch/pull/5351) |

---

_마지막 업데이트: 2026-04-06_
