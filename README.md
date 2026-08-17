# 오픈소스 기여 포트폴리오

Java 생태계 오픈소스에 이슈를 읽고, 변경 범위를 정한 뒤, 테스트와 리뷰를 거쳐 기여한 기록입니다.

단순히 PR 수를 늘리는 것보다 문제의 원인과 저장소의 기여 기준을 먼저 확인하고, 유지보수자가 검토할 수 있는 작은 변경으로 제안하는 과정을 중요하게 다룹니다.

## 한눈에 보기

| 구분 | 내용 |
| --- | --- |
| 주요 생태계 | Spring Boot, Spring Guides, Apache Iceberg, Spring Data Redis |
| 대표 결과 | upstream merge 3건 |
| 대표 코드 기여 | Spring Boot `FailureAnalyzer`와 모듈 전용 테스트 추가 |
| 대표 유지보수 기여 | Spring Data Redis public API 호환성을 고려한 converter 리팩터링 PR |
| 작업 기준 | 문제 정의 → 저장소 구조 확인 → 최소 변경 → targeted test·문서 검증 |

## 대표 기여

### 1. Spring Boot `#49582` — FailureAnalyzer 개선

`spring-boot-mail`이 클래스패스에 있어도 필수 설정이 없으면 `MailSender` bean이 생성되지 않는 상황에서, 기존 failure analysis가 사용자를 잘못된 해결 방향으로 안내하는 문제를 다뤘습니다.

- `spring.mail.host`와 `spring.mail.jndi-name` 조건을 기준으로 실제 원인을 분석했습니다.
- 공통 missing bean 분석기를 수정하지 않고 `spring-boot-mail` 모듈 안에 전용 `FailureAnalyzer`를 추가했습니다.
- analyzer가 필요한 조건에서만 동작하도록 모듈 전용 테스트를 구성했습니다.
- [PR #49582](https://github.com/spring-projects/spring-boot/pull/49582)
- [상세 사례](docs/case-studies/spring-boot-49582.md)

**핵심 판단**: 공통 로직을 넓게 변경하기보다, 원인이 특정 auto-configuration 조건에 한정된다는 점에 맞춰 변경 범위를 모듈 내부로 제한했습니다.

### 2. Apache Iceberg `#15309` — Markdown 문서 정합성 수정

`schemas.md`의 표에서 `uuid` 행에 컬럼과 구분 기호가 누락되어 문서 렌더링과 소스 정합성이 깨진 문제를 수정했습니다.

- 누락된 Notes 컬럼과 닫는 파이프를 복구했습니다.
- 수정 전후 렌더링을 비교해 변경 결과를 확인했습니다.
- 문서의 실제 구조를 유지하는 최소 변경으로 PR을 구성했습니다.
- [PR #15309](https://github.com/apache/iceberg/pull/15309)
- [상세 사례](docs/case-studies/apache-iceberg-15309.md)

### 3. Spring Guides `gs-rest-service#175` — Initializr 링크 수정

Spring Initializr 링크의 `packageName`과 생성되는 가이드 코드 경로가 일치하지 않는 문제를 수정했습니다.

- 링크 파라미터와 실제 예제 코드의 패키지 경로를 대조했습니다.
- 문서 사용자가 생성 직후 겪는 경로 불일치를 한 줄 수정으로 해결했습니다.
- [PR #175](https://github.com/spring-guides/gs-rest-service/pull/175)
- [상세 사례](docs/case-studies/gs-rest-service-175.md)

## 리뷰 대기 중인 대표 사례

### Spring Data Redis `#3361` — public converter 호환성 리팩터링

중복된 converter 구현을 정리하되, 외부에서 참조할 수 있는 public API를 바로 삭제하지 않는 방향으로 제안한 PR입니다.

- 기존 converter를 deprecated 처리해 호환성을 보존했습니다.
- 내부 구현은 공통 메서드로 위임해 중복을 줄였습니다.
- converter 동작에 대한 targeted test를 함께 확인했습니다.
- [PR #3361](https://github.com/spring-projects/spring-data-redis/pull/3361)
- [상세 사례](docs/case-studies/spring-data-redis-3361.md)

## 기여 과정에서 정립한 기준

### 문제 정의

증상만 보고 구현하지 않고, 관련 코드·설정 조건·기존 테스트·이슈 논의를 먼저 확인합니다.

### 변경 범위

공통 로직을 수정하기 전에 특정 모듈이나 특정 조건 안에서 해결할 수 있는지 검토합니다. 새 API나 동작 변경은 구현 가능성보다 유지보수 필요성과 사용 사례를 먼저 판단합니다.

### 검증

- Java 코드 변경: 변경 범위와 직접 연결된 targeted test 실행
- 문서 변경: Markdown 문법, 렌더링, 링크 검증
- public API 변경: 호환성 영향과 deprecated 전환 경로 확인
- PR 작성: 변경 이유, 영향 범위, 검증 결과를 재현 가능하게 기록

### 오픈소스 workflow

이슈 상태, labels, assignee, 최신 maintainer 코멘트, 기존 PR 여부를 확인한 뒤 작업을 시작합니다. triage 전이거나 다른 기여자가 담당한 이슈는 바로 구현하지 않고 contribution welcome 여부를 먼저 확인합니다.

## AI 활용과 검증

AI 도구는 이슈 후보 탐색, 관련 코드 위치 파악, 반복적인 구현과 테스트 명령 정리를 보조하는 데 사용합니다.

요구사항과 수용 기준은 먼저 정의하고, AI가 제안한 변경은 diff를 직접 검토한 뒤 저장소의 테스트, 코드 패턴, maintainer 논의와 대조합니다. 최종 PR에는 무엇을 왜 변경했는지와 어떤 검증을 수행했는지를 남깁니다.

## 문서 안내

- [백엔드 오픈소스 포트폴리오 요약](docs/portfolio/backend-open-source-portfolio.md)
- [Spring Boot PR 사례](docs/case-studies/spring-boot-49582.md)
- [Apache Iceberg PR 사례](docs/case-studies/apache-iceberg-15309.md)
- [Spring Guides PR 사례](docs/case-studies/gs-rest-service-175.md)
- [Spring Data Redis PR 사례](docs/case-studies/spring-data-redis-3361.md)
- [면접용 대표 답변](docs/portfolio/interview-stories.md)
- [거절·종료된 PR에서 배운 점](docs/lessons/rejected-and-closed-prs.md)
- [오픈소스 기여 가이드](docs/guides/open-source-contribution-guide.md)

---

_마지막 업데이트: 2026-08-17_
