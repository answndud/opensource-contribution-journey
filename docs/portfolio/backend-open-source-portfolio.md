# 백엔드 오픈소스 포트폴리오 요약

> 목적: 채용 담당자와 면접관이 5분 안에 기여 범위, 기술 깊이, 검증 습관을 파악할 수 있도록 정리한 공개 문서입니다.

---

## 한 줄 요약

Java 생태계에서 문제를 정확히 정의하고, 변경 범위를 줄이고, 기존 패턴과 테스트를 근거로 PR을 작성해 온 경험입니다. 설명할 가치가 있는 대표 머지 기여와 리뷰 대기 사례만 공개하고, 종료된 시도는 회고 자료로 보관합니다.

---

## 현재 지표

**기준일**: 2026-08-17

| 항목 | 내용 |
| ---- | ---- |
| 공개 범위 | 대표 머지 기여와 선별 리뷰 대기 사례 |
| 기록 원칙 | 전체 시도 횟수보다 설명 가능한 대표 사례 중심 |
| 주요 영역 | Spring Boot auto-configuration, Apache Iceberg 문서 정합성, Spring Guides, Spring Data Redis 호환성 리팩터링 |

---

## 대표 사례

| 사례 | 상태 | 핵심 역량 | 문서 |
| ---- | ---- | --------- | ---- |
| Spring Boot `#49582` | 머지 | auto-configuration 조건 분석, FailureAnalyzer, 모듈 전용 테스트 | [case study](../case-studies/spring-boot-49582.md) |
| Apache Iceberg `#15309` | 머지 | 문서 렌더링 정합성, 최소 수정, before/after 증거 | [case study](../case-studies/apache-iceberg-15309.md) |
| Spring Guides `#175` | 머지 | Initializr 링크 정합성, 문서와 생성 코드 일치 | [case study](../case-studies/gs-rest-service-175.md) |

---

## 제가 보여줄 수 있는 백엔드 역량

### 1. 원인과 증상을 분리합니다

Spring Boot `#49582`에서는 `MailSender` bean 부재라는 증상만 보지 않고, 실제 원인이 `spring.mail.host` 또는 `spring.mail.jndi-name` 조건 불일치라는 점을 확인했습니다.

### 2. 변경 범위를 작게 잡습니다

공통 missing bean 분석기를 바꾸지 않고 `spring-boot-mail` 모듈 내부의 전용 `FailureAnalyzer`로 해결했습니다. 유지보수자가 리뷰하기 쉬운 범위로 문제를 좁힌 것이 머지에 영향을 주었습니다.

### 3. 호환성을 고려해서 리팩터링합니다

Spring Data Redis `#3361`에서는 기존 converter를 제거하지 않고 deprecated 처리한 뒤 내부 구현만 `Converters.toProperties(...)`로 위임했습니다. 공개 API를 다룰 때 바로 삭제하지 않는 판단을 배웠습니다.

### 4. 실패한 PR도 운영 기준으로 바꿉니다

종료된 PR에서 assignee, triage 상태, maintainer 코멘트, 기존 PR 확인을 작업 전 필수 gate로 만들었습니다. 이 기준은 [거절·종료된 PR에서 배운 점](../lessons/rejected-and-closed-prs.md)에 정리했습니다.

---

## 검증 습관

- repo 전체 빌드가 과한 경우에는 변경 범위와 직접 연결된 모듈 전용 테스트를 먼저 실행합니다.
- 테스트를 실행하지 못한 경우에는 환경 제약과 생략 이유를 PR 또는 case study에 남깁니다.
- 공개 문서는 `npm run validate`로 markdown syntax와 link 상태를 확인합니다.
- PR 상태는 `npm run snapshot:prs`로 주기적으로 확인합니다.

---

## 리뷰 대기 PR 운영 방식

리뷰 대기 PR은 모두 같은 우선순위로 보지 않습니다. maintainer 반응 가능성, triage 상태, 프로젝트 활동성을 기준으로 시간을 더 쓸 PR과 기다리기만 할 PR을 나눕니다.

| 분류 | PR | 운영 방식 | 이유 |
| ---- | -- | --------- | ---- |
| 일반 대기 | [spring-data-redis#3361](https://github.com/spring-projects/spring-data-redis/pull/3361) | maintainer 리뷰 대기 | deprecated API 유지와 내부 위임이라는 호환성 판단을 설명할 수 있는 대표 사례입니다. |

이 운영 방식의 목적은 "열린 PR을 많이 쌓는 것"이 아니라, 어떤 PR에 더 시간을 쓰면 안 되는지도 판단하는 것입니다.

---

## 면접에서 강조할 메시지

> 저는 오픈소스를 GitHub 잔디 채우기가 아니라 실무형 코드 리뷰 훈련으로 사용했습니다. 특히 Spring Boot PR이 머지된 뒤부터는 문제를 크게 풀기보다, 기존 설계 패턴 안에서 작은 변경과 테스트로 설득하는 방식이 더 효과적이라는 점을 체득했습니다.

---

_마지막 업데이트: 2026-08-17_
