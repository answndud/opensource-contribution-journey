# Spring Data Redis 사례: PR #3361

> 주제: `spring-projects/spring-data-redis#3361`
> 상태: ⏳ 리뷰 대기

---

## 문제

`StringToPropertiesConverter`가 문자열을 `Properties`로 변환하는 로직을 직접 가지고 있었고, 같은 목적의 구현이 `Converters.toProperties(...)`에도 존재했습니다.

이슈 `spring-data-redis#3020`에서는 중복 converter를 정리하고 `Converters.toProperties(...)`를 사용하도록 방향이 제시되어 있었습니다.

---

## Readiness Gate

작업 전 아래 조건을 확인했습니다.

| 항목              | 확인 결과                                                                                           |
| ----------------- | --------------------------------------------------------------------------------------------------- |
| 이슈 상태         | Open                                                                                                |
| 라벨              | `type: task`, `status: ideal-for-contribution`                                                      |
| assignee          | 없음                                                                                                |
| maintainer 코멘트 | `StringToPropertiesConverter`를 deprecate하고 `Converters.toProperties(...)`만 사용하자는 방향 제시 |
| 기존 open PR      | 없음                                                                                                |

이 조건을 보고 바로 구현해도 되는 낮은 리스크의 리팩터링 이슈로 판단했습니다.

---

## 내가 한 일

1. `StringToPropertiesConverter`를 `@Deprecated` 처리했습니다.
2. 기존 직접 파싱 로직을 제거하고 `Converters.toProperties(source)`로 위임했습니다.
3. deprecated API를 유지하면서 동작이 그대로 보존되는지 단위 테스트를 추가했습니다.

주요 변경 파일은 아래와 같았습니다.

- `StringToPropertiesConverter.java`
- `ConvertersUnitTests.java`

---

## 검증

Spring Data Redis 전체 빌드 대신 converter 변경 범위에 맞는 targeted test를 실행했습니다.

```bash
./mvnw -Dtest=ConvertersUnitTests test
```

검증 결과 `ConvertersUnitTests` 28개가 모두 통과했습니다.

---

## 포트폴리오 관점에서의 의미

이 PR은 큰 기능 추가가 아니라, 중복 구현을 줄이고 기존 public API를 부드럽게 정리하는 유지보수형 리팩터링입니다.

백엔드 개발에서 중요한 점은 단순히 새 코드를 많이 쓰는 것이 아니라, 이미 노출된 API의 호환성을 유지하면서 내부 구현을 정리하는 판단입니다. 이 사례는 deprecated 처리, 위임 구조, 회귀 테스트를 함께 다룬 예시로 설명할 수 있습니다.

---

## 링크

- PR: [spring-projects/spring-data-redis#3361](https://github.com/spring-projects/spring-data-redis/pull/3361)
- 이슈: [spring-projects/spring-data-redis#3020](https://github.com/spring-projects/spring-data-redis/issues/3020)

---

_마지막 업데이트: 2026-05-18_
