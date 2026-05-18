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

## 설계 판단

이 PR의 핵심은 "중복 코드를 없애되 public API 사용자를 깨지 않는 것"이었습니다.

| 선택지 | 장점 | 문제점 | 판단 |
| ------ | ---- | ------ | ---- |
| `StringToPropertiesConverter` 즉시 삭제 | 중복 타입을 완전히 제거함 | 기존 사용자가 컴파일 단계에서 깨질 수 있음 | 선택하지 않음 |
| 기존 구현을 유지하고 문서만 정리 | 호환성 리스크가 거의 없음 | 중복 구현이 계속 남음 | 선택하지 않음 |
| deprecated 처리 후 내부 위임 | 기존 타입은 유지하면서 구현 중복 제거 | API는 당분간 남아 있음 | 선택 |

maintainer가 이슈에서 deprecate 방향을 언급했기 때문에, 삭제보다 단계적 정리가 더 적절하다고 판단했습니다. 이 방식은 Spring 생태계처럼 public API 호환성이 중요한 프로젝트에서 리뷰 부담을 줄이는 선택입니다.

---

## 테스트 경계

테스트는 기존 converter를 사용하는 코드가 여전히 같은 결과를 얻는지 확인하는 데 집중했습니다.

- deprecated 타입을 직접 호출해도 `Properties` 변환 결과가 유지됩니다.
- 실제 변환 로직은 `Converters.toProperties(...)`로 위임됩니다.
- 테스트 이름에는 위임 의도를 드러내, 리팩터링 목적이 동작 변경이 아니라 중복 제거임을 분명히 했습니다.

전체 Redis integration test가 아니라 `ConvertersUnitTests`를 실행한 이유는 변경 범위가 문자열 변환 유틸리티에 한정되어 있었기 때문입니다.

---

## 검증

Spring Data Redis 전체 빌드 대신 converter 변경 범위에 맞는 targeted test를 실행했습니다.

```bash
./mvnw -Dtest=ConvertersUnitTests test
```

검증 결과 `ConvertersUnitTests` 28개가 모두 통과했습니다.

---

## 면접에서 받을 수 있는 꼬리질문

### 왜 바로 삭제하지 않고 deprecated 처리했나요?

`StringToPropertiesConverter`가 public class라 외부 코드에서 직접 참조하고 있을 가능성이 있습니다. 바로 삭제하면 기존 사용자의 컴파일이 깨질 수 있으므로, 먼저 deprecated 처리하고 내부 구현만 공통 메서드로 위임하는 단계적 정리가 더 안전합니다.

### 이 PR은 기능 추가가 아닌데 왜 백엔드 역량으로 설명할 수 있나요?

백엔드 시스템에서는 새 기능만큼 기존 API를 깨지 않고 내부 구현을 정리하는 능력도 중요합니다. 이 PR은 중복 로직 제거, public API 호환성, 회귀 테스트를 함께 다룬 유지보수형 리팩터링 사례입니다.

### targeted test만 실행한 이유는 무엇인가요?

변경 범위가 Redis 서버 연동이 아니라 문자열을 `Properties`로 변환하는 converter에 한정되어 있었기 때문입니다. 그래서 전체 integration test보다 관련 단위 테스트인 `ConvertersUnitTests`가 변경 리스크를 직접 검증한다고 판단했습니다.

### 리뷰에서 다른 방향이 제시되면 어떻게 대응하겠나요?

maintainer가 deprecate 대신 삭제나 다른 API 정리를 원하면 그 방향으로 축소 수정할 수 있습니다. 다만 현재 PR은 기존 사용자 호환성을 보존하는 쪽으로 열어 두었기 때문에, 리뷰어가 선택할 수 있는 변경 폭을 남긴 상태입니다.

---

## 포트폴리오 관점에서의 의미

이 PR은 큰 기능 추가가 아니라, 중복 구현을 줄이고 기존 public API를 부드럽게 정리하는 유지보수형 리팩터링입니다.

백엔드 개발에서 중요한 점은 단순히 새 코드를 많이 쓰는 것이 아니라, 이미 노출된 API의 호환성을 유지하면서 내부 구현을 정리하는 판단입니다. 이 사례는 deprecated 처리, 위임 구조, 회귀 테스트를 함께 다룬 예시로 설명할 수 있습니다.

면접에서는 이 사례를 "public API 호환성을 유지하면서 중복 구현을 제거한 리팩터링"으로 설명할 수 있습니다.

---

## 링크

- PR: [spring-projects/spring-data-redis#3361](https://github.com/spring-projects/spring-data-redis/pull/3361)
- 이슈: [spring-projects/spring-data-redis#3020](https://github.com/spring-projects/spring-data-redis/issues/3020)

---

_마지막 업데이트: 2026-05-18_
