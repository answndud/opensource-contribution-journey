# Spring Guides 사례: gs-rest-service PR #175

> 주제: `spring-guides/gs-rest-service#175`
> 상태: ✅ 머지

---

## 문제

`gs-rest-service` 가이드의 pre-initialized project 링크는 Spring Initializr를 통해 예제 프로젝트를 바로 생성할 수 있게 해 줍니다.

하지만 `packageName` 값이 `com.example.rest-service`로 들어가 있어, 실제 생성 결과는 가이드 본문에서 설명하는 패키지 경로와 맞지 않았습니다.

겉보기에는 문서 링크 파라미터 한 줄 문제였지만, 실제로는 사용자가 가이드를 그대로 따라 했을 때 코드 경로가 어긋나는 문제였습니다.

---

## 내가 한 일

1. `start.spring.io` 링크 파라미터를 확인했습니다.
2. `packageName`이 하이픈을 포함한 형태로 들어가 있는 것을 확인했습니다.
3. 이를 `com.example.restservice`로 수정해, 생성되는 패키지 경로가 가이드 예제와 일치하도록 맞췄습니다.

핵심 변경은 아래 한 줄이었습니다.

```diff
- packageName=com.example.rest-service
+ packageName=com.example.restservice
```

---

## 검증

```bash
# pre-initialized project 링크 파라미터 확인
# packageName 값이 실제 생성 경로에 어떤 영향을 주는지 확인
```

이 변경은 테스트 코드가 필요한 성격은 아니었지만, 링크 파라미터가 생성 결과에 직접 영향을 주는지 확인하고 수정 범위를 최소화했습니다.

---

## 왜 머지되었는가

이 PR은 세 가지 점에서 명확했습니다.

1. 문제 정의가 단순했습니다.
   - 생성 결과와 가이드 코드 경로가 불일치했습니다.

2. 수정 범위가 작았습니다.
   - 링크 파라미터 한 줄만 바꾸면 됐습니다.

3. 저장소 선택이 맞았습니다.
   - 공통 매크로가 아니라 개별 가이드 설정 문제였기 때문에 `gs-rest-service`에 직접 수정하는 것이 맞았습니다.

maintainer 피드백도 간단했습니다.

> Merged #175 into main. Good stuff, thanks.

---

## 학습한 내용

- 문서 PR이라도 실제 사용자 흐름을 깨는 문제라면 충분히 가치가 있습니다.
- 첫 기여일수록 작고 명확하며 부작용이 없는 문제를 고르는 것이 중요합니다.
- 같은 문서 수정처럼 보여도, 어떤 문제는 공통 매크로 저장소에서 고쳐야 하고 어떤 문제는 개별 가이드에서 고쳐야 합니다. 저장소 경계를 정확히 읽는 것이 핵심입니다.

---

## 이후에 바뀐 점

이 경험 이후에는 문서 PR을 보낼 때도 먼저 아래를 확인하게 됐습니다.

1. 이 변경이 개별 파일 문제인지, 공통 템플릿 문제인지
2. 사용자가 실제로 재현 가능한 문제인지
3. 한 줄 수정으로 해결 가능한지

작은 수정이어도 문제 정의와 저장소 선택이 맞아야 빨리 머지된다는 점을 처음으로 체감한 사례였습니다.

---

## 링크

- PR: [spring-guides/gs-rest-service#175](https://github.com/spring-guides/gs-rest-service/pull/175)
- 이슈: [spring-guides/gs-spring-boot#195](https://github.com/spring-guides/gs-spring-boot/issues/195)

---

_마지막 업데이트: 2026-04-06_
