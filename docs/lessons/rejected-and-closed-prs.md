# 거절·종료된 PR에서 배운 점

> 단순히 "머지되지 않은 PR 목록"이 아니라, 어떤 기준이 빠졌고 이후 작업 방식을 어떻게 바꿨는지를 정리한 문서입니다.

---

## 왜 이 문서를 공개하나

오픈소스 기여에서는 머지된 PR만큼이나 거절되거나 종료된 PR도 중요한 신호를 줍니다.

저는 종료된 PR을 숨기기보다, 왜 닫혔는지와 이후 어떤 기준을 세웠는지를 함께 남기는 편이 더 실무적이라고 생각합니다.

실제로 이 과정에서 배운 점은 크게 네 가지 패턴으로 정리됩니다.

---

## 1. 구조를 모르면 맞는 수정도 틀린 PR이 된다

### 대표 사례
- [spring-guides/gs-rest-service#172](https://github.com/spring-guides/gs-rest-service/pull/172)
- [spring-guides/getting-started-macros#19](https://github.com/spring-guides/getting-started-macros/pull/19)
- [spring-guides/gs-rest-service#173](https://github.com/spring-guides/gs-rest-service/pull/173)

### 왜 거부되었나
- `#172`: 개별 가이드의 README를 고쳤지만, 실제 문제는 공통 매크로에 있었습니다.
- `#19`: 깨진 링크를 고쳤지만, maintainer는 링크를 바꾸는 대신 해당 노트 자체를 제거하는 쪽을 선택했습니다.
- `#173`: UI 개선 방향 자체는 나쁘지 않았지만, 팀은 이미 공통 매크로 개선 방향을 갖고 있었습니다.

### 깨달은 점
- 증상만 보고 수정하면 저장소를 잘못 고를 수 있습니다.
- 문서 PR도 템플릿 구조와 재사용 구조를 먼저 읽어야 합니다.
- "좋은 수정"보다 "프로젝트 구조에 맞는 수정"이 먼저입니다.

### 이후 바뀐 기준
1. 이 변경이 개별 파일 문제인지 공통 템플릿 문제인지 먼저 확인합니다.
2. 관련 이슈 코멘트와 maintainer의 기존 계획을 먼저 읽습니다.
3. 동일한 내용이 여러 가이드에 복제되는 구조라면, 개별 파일이 아니라 공통 계층을 먼저 봅니다.

---

## 2. 버그처럼 보여도 의도된 동작일 수 있다

### 대표 사례
- [spring-projects/spring-restdocs#1022](https://github.com/spring-projects/spring-restdocs/pull/1022)

### 왜 거부되었나
빈 POST/PUT/PATCH 요청에 `Content-Type`을 붙이는 로직을 버그로 보고 수정했지만, maintainer는 이 동작이 HTTP semantics를 고려한 의도된 구현이라고 명확히 설명했습니다.

### 깨달은 점
- 내가 불편하다고 느낀 동작이 곧 버그는 아닙니다.
- 스펙, 기존 사용자 기대, 라이브러리 철학을 먼저 확인해야 합니다.
- 특히 HTTP, security, framework core behavior는 구현보다 해석이 먼저입니다.

### 이후 바뀐 기준
1. 동작 변경 전 "이게 정말 버그인가"를 먼저 검증합니다.
2. 애매하면 PR보다 짧은 질문 코멘트를 먼저 남깁니다.
3. 스펙/프로토콜/핵심 동작 해석이 걸린 이슈는 discussion-first로 다룹니다.

---

## 3. 기능 추가는 강한 use case 없이는 받아들여지지 않는다

### 대표 사례
- [spring-projects/spring-restdocs#1023](https://github.com/spring-projects/spring-restdocs/pull/1023)

### 왜 거부되었나
`modifyUris`에 path prefix 지원을 추가했지만, maintainer는 기존의 `scheme`, `host`, `port` 지원만으로 충분하다고 판단했습니다.

즉, 구현은 가능했지만 프로젝트가 그 API를 앞으로 계속 유지해야 할 이유는 충분하지 않았습니다.

### 깨달은 점
- 오픈소스에서는 "구현 가능함"과 "머지 가능함"이 다릅니다.
- 새로운 API는 기능 하나가 아니라 유지보수 책임까지 함께 추가합니다.
- 기능 제안에는 개인적 편의가 아니라 커뮤니티 차원의 강한 use case가 필요합니다.

### 이후 바뀐 기준
1. 기능 추가 전 기존 API로 정말 해결이 불가능한지 확인합니다.
2. 새 API가 생기면 누가, 어떤 문맥에서 반복적으로 필요한지 설명할 수 있어야 합니다.
3. enhancement는 bug fix보다 더 보수적으로 접근합니다.

---

## 4. 코드가 맞아도 프로세스를 어기면 종료될 수 있다

### 대표 사례
- [spring-projects/spring-security#18850](https://github.com/spring-projects/spring-security/pull/18850)
- [spring-projects/spring-security#18889](https://github.com/spring-projects/spring-security/pull/18889)
- [spring-projects/spring-boot#49594](https://github.com/spring-projects/spring-boot/pull/49594)

### 왜 종료되었나
- `#18850`: maintainer가 issue를 평가하고 결론 내리기 전에 PR을 먼저 열었습니다. 게다가 assignee가 있던 이슈였습니다.
- `#18889`: 같은 패턴을 반복하지 않기 위해 triage-first 기준으로 자진 종료했습니다.
- `#49594`: 구현 방향 자체보다, 이미 assign된 이슈에 뒤늦게 들어가면서 종료됐습니다.

### 깨달은 점
- 활발한 저장소일수록 코드보다 workflow를 먼저 맞춰야 합니다.
- assignee, latest maintainer comment, existing PR, triage 상태 확인은 선택이 아니라 필수입니다.
- 특히 Spring Security처럼 behavior/spec 해석이 중요한 영역은 explicit maintainer approval 없이 PR을 열면 안 됩니다.

### 이후 바뀐 기준
1. 착수 전에 issue 상태, labels, assignee, 최신 maintainer comment, 기존 PR 여부를 반드시 확인합니다.
2. triage 전에는 PR을 먼저 열지 않고 contribution welcome 여부를 짧게 묻습니다.
3. security/spec/core behavior 변경은 discussion-first로 분류합니다.

---

## 지금의 작업 방식으로 남은 것

이 과정을 거친 뒤에는 다음 기준이 제 작업의 기본값이 됐습니다.

1. 문제 정의를 먼저 좁힙니다.
2. 저장소 구조와 maintainer workflow를 먼저 읽습니다.
3. 기존 패턴 안에서 가장 작은 수정으로 해결합니다.
4. 구현보다 먼저 검증 전략과 종료 조건을 생각합니다.

머지된 3개의 PR은 이 기준이 잘 맞아떨어진 사례이고, 거절·종료된 PR들은 그 기준을 만들게 한 근거였습니다.

---

## 함께 보면 좋은 문서

- [Spring Guides 사례: gs-rest-service PR #175](../case-studies/gs-rest-service-175.md)
- [Apache Iceberg 사례: PR #15309](../case-studies/apache-iceberg-15309.md)
- [Spring Boot 사례: PR #49582](../case-studies/spring-boot-49582.md)

---

_마지막 업데이트: 2026-04-06_
