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

---

## 링크

- PR: [spring-projects/spring-boot#49582](https://github.com/spring-projects/spring-boot/pull/49582)
- 이슈: [spring-projects/spring-boot#49359](https://github.com/spring-projects/spring-boot/issues/49359)

---

_마지막 업데이트: 2026-04-06_
