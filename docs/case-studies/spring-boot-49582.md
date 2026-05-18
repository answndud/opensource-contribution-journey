# Spring Boot 사례: PR #49582

> 주제: `spring-projects/spring-boot#49582`
> 상태: ✅ 머지

---

## 문제

`spring-boot-mail`이 클래스패스에 있어도 `spring.mail.host` 또는 `spring.mail.jndi-name`이 없으면 `MailSender` bean이 생성되지 않습니다.

문제는 이 상황에서 나오는 기본 failure analysis가 사용자를 "bean을 직접 정의하라"는 방향으로 잘못 유도한다는 점이었습니다.

겉으로는 missing bean 문제처럼 보였지만, 실제 원인은 auto-configuration 조건 불일치였습니다.

---

## 내가 한 일

1. 문제를 일반적인 missing bean 이슈로 넓히지 않았습니다.
2. `spring-boot-mail` 모듈 안에 mail 전용 `FailureAnalyzer`를 추가했습니다.
3. `spring.mail.host`와 `spring.mail.jndi-name`이 모두 없을 때만 더 정확한 안내가 나오도록 범위를 제한했습니다.
4. 기존 Boot 패턴(`spring-boot-r2dbc`, `spring-boot-jooq`)을 먼저 확인한 뒤 같은 방식으로 구현했습니다.

주요 변경 파일은 아래와 같았습니다.

- `NoSuchMailSenderBeanFailureAnalyzer.java`
- `NoSuchMailSenderBeanFailureAnalyzerTests.java`
- `META-INF/spring.factories`

---

## 설계 판단

이 PR에서 가장 중요한 판단은 "어디를 고치지 않을 것인가"였습니다.

| 선택지 | 장점 | 문제점 | 판단 |
| ------ | ---- | ------ | ---- |
| 공통 missing bean 분석 로직 수정 | 더 넓은 케이스를 한 번에 다룰 수 있음 | 다른 auto-configuration 실패까지 오탐할 수 있음 | 선택하지 않음 |
| `MailSender` bean 생성 조건 변경 | 사용자가 설정 없이도 bean을 얻을 수 있음 | Spring Boot auto-configuration 계약 자체가 바뀜 | 선택하지 않음 |
| mail 전용 `FailureAnalyzer` 추가 | 문제 범위가 `spring-boot-mail` 안에 머무름 | mail 케이스만 해결함 | 선택 |

선택한 방식은 기능 동작을 바꾸지 않고 실패 원인 설명만 정확하게 만드는 접근이었습니다. 그래서 기존 사용자에게 미치는 영향이 작고, reviewer가 변경 범위를 빠르게 확인할 수 있었습니다.

---

## 테스트 경계

테스트는 "언제 새 failure analysis가 나와야 하는가"와 "언제 나오면 안 되는가"를 나누는 데 집중했습니다.

- `spring.mail.host`가 없고 `spring.mail.jndi-name`도 없으면 mail 설정 누락을 안내합니다.
- 둘 중 하나가 있으면 mail sender 생성 조건을 만족할 수 있으므로 analyzer가 과하게 개입하지 않습니다.
- bean을 직접 만드는 해결책을 안내하기보다, 실제 필요한 설정 키를 알려주는 메시지를 검증합니다.

이 경계가 중요했던 이유는 failure analyzer가 너무 넓게 동작하면 다른 missing bean 문제까지 잘못 설명할 수 있기 때문입니다.

---

## 검증

최초에는 로컬 기본 JDK 21 환경 때문에 Spring Boot의 Java 25+ toolchain 요구 사항을 충족하지 못해 검증이 막혔습니다.

환경을 맞춘 뒤 아래 targeted test를 통과시켰습니다.

```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
./gradlew :module:spring-boot-mail:test \
  --tests org.springframework.boot.mail.autoconfigure.NoSuchMailSenderBeanFailureAnalyzerTests
```

이 과정에서 코드 문제와 환경 문제를 분리해서 판단하는 습관이 더 중요해졌습니다.

---

## 왜 머지되었는가

이 PR이 빠르게 머지된 이유는 세 가지였습니다.

1. 문제 정의가 정확했습니다.
   - "bean이 없다"가 아니라 "왜 없고, 현재 메시지가 왜 틀린 방향을 안내하는가"를 먼저 정리했습니다.

2. 해결 범위를 넓히지 않았습니다.
   - 공통 missing bean 분석 로직을 바꾸지 않고, `spring-boot-mail` 모듈 안에서만 해결했습니다.

3. 기존 패턴을 재사용했습니다.
   - 새로운 구조를 주장하기보다, 이미 있던 failure analyzer 패턴을 그대로 따라가 리뷰 부담을 줄였습니다.

---

## 면접에서 받을 수 있는 꼬리질문

### 왜 공통 `NoSuchBeanDefinitionFailureAnalyzer`를 고치지 않았나요?

문제가 모든 missing bean에 있는 것이 아니라 `spring-boot-mail`의 auto-configuration 조건과 failure message 사이의 불일치에 있었기 때문입니다. 공통 analyzer를 바꾸면 다른 모듈의 실패 분석까지 영향을 받을 수 있어, mail 모듈 내부의 전용 analyzer가 더 작은 변경 범위라고 판단했습니다.

### 왜 설정 키를 안내하는 방식이 더 낫다고 봤나요?

사용자가 bean을 직접 정의해야 하는 상황이 아니라, `MailSenderAutoConfiguration`이 활성화되기 위한 설정이 빠진 상황이었습니다. 따라서 "bean을 직접 만들라"보다 `spring.mail.host` 또는 `spring.mail.jndi-name` 설정을 확인하라는 안내가 실제 원인에 더 가깝습니다.

### 이 변경의 리스크는 무엇이었나요?

가장 큰 리스크는 analyzer가 너무 넓게 동작해 다른 missing bean 상황을 잘못 설명하는 것이었습니다. 그래서 mail 관련 클래스와 설정 조건에만 반응하도록 범위를 제한하고, 설정이 있는 경우에는 새 analyzer가 개입하지 않는 경계를 테스트했습니다.

### 실무에서도 같은 판단을 적용한다면?

공통 예외 처리나 공통 진단 로직을 바로 수정하기 전에, 문제가 특정 모듈의 조건 불일치인지 먼저 확인하겠습니다. 영향 범위를 줄일 수 있다면 공통 로직보다 모듈 전용 해결책을 우선 검토하겠습니다.

---

## 학습한 내용

- 백엔드 문제 해결은 표면 에러보다 실제 생성 조건을 읽는 것에서 시작합니다.
- 좋은 PR은 큰 리팩터링보다 정확한 문제 정의와 작은 수정 범위에서 나옵니다.
- 활발한 프로젝트일수록 toolchain, 모듈 경계, 기존 패턴을 먼저 맞추는 것이 중요합니다.
- 개발자 경험 개선도 충분히 백엔드 품질 개선의 일부입니다.

---

## 이후에 바뀐 점

이 PR 이후에는 새 이슈를 볼 때 아래 순서를 먼저 고정했습니다.

1. 겉으로 보이는 실패와 실제 원인을 분리하기
2. 비슷한 패턴의 기존 구현을 최소 두 개 이상 읽기
3. 공통 로직보다 모듈 내부의 작은 수정으로 해결 가능한지 먼저 보기
4. 저장소의 JDK 및 toolchain 요구 사항을 먼저 맞추기

이 사례는 제가 가장 "실무형"으로 문제를 좁히고 검증한 PR입니다.

면접에서는 이 사례를 "auto-configuration 조건을 읽고, 공통 로직을 건드리지 않는 작은 변경으로 사용자-facing 진단 품질을 개선한 경험"으로 설명할 수 있습니다.

---

## 링크

- PR: [spring-projects/spring-boot#49582](https://github.com/spring-projects/spring-boot/pull/49582)
- 이슈: [spring-projects/spring-boot#49359](https://github.com/spring-projects/spring-boot/issues/49359)

---

_마지막 업데이트: 2026-05-18_
