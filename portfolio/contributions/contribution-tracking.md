# 기여 활동 트래킹

> **목표**: 체계적인 기여 기록으로 면접에서 구체적인 성과 제시

## 🎯 기여 현황 요약

| 항목      | 목표 | 달성 | 달성률 |
| --------- | ---- | ---- | ------ |
| 총 PR 수  | 10개 | 1개  | 10%    |
| 머지된 PR | 8개  | 0개  | 0%     |
| 문서 기여 | 3개  | 1개  | 33%    |
| 버그 수정 | 4개  | 0개  | 0%     |
| 기능 추가 | 3개  | 0개  | 0%     |

---

## 📋 기여 목록

### PR #1: docs: fix jarfile name in README

**기본 정보:**

- **프로젝트**: spring-guides/gs-rest-service
- **PR 링크**: https://github.com/answndud/gs-rest-service/pull/new/fix/issue-168-jarfile-name
- **이슈 링크**: https://github.com/spring-guides/getting-started-guides/issues/168
- **상태**: ⏳ PR 생성 대기중
- **날짜**: 2025-02-03

**기여 내용:**

```
무엇을: RESTful Web Service 가이드의 README.adoc에서 잘못된 jar 파일명 수정
왜: 사용자들이 Maven 빌드 후 가이드대로 실행하면 "Error: Unable to access jarfile" 오류 발생
어떻게: pom.xml의 실제 artifactId(rest-service-complete)와 version(0.0.1-SNAPSHOT) 확인 후 문서 수정
```

**코드 변경:**

```diff
- include::https://raw.githubusercontent.com/spring-guides/getting-started-macros/main/build_an_executable_jar_with_both.adoc[]
+ You can run the application from the command line with Gradle or Maven...
+ 
+ If you use Gradle:
+ java -jar build/libs/rest-service-complete-0.0.1-SNAPSHOT.jar
+ 
+ If you use Maven:
+ java -jar target/rest-service-complete-0.0.1-SNAPSHOT.jar
```

**테스트:**

```bash
# pom.xml 확인
cat complete/pom.xml | grep -E "(artifactId|version)"
# 결과: artifactId: rest-service-complete, version: 0.0.1-SNAPSHOT
```

**배운 점:**

- Spring Guides는 외부 매크로 파일을 include해서 사용함
- 가이드 문서 작성 시 실제 빌드 결과와 문서의 일치성 중요
- 오픈소스 기여의 첫걸음으로 Git workflow 실습

**면접용 한 줄 요약:**
> "Spring RESTful Web Service 가이드에서 Maven 빌드로 생성되는 jar 파일명이 문서와 달라 사용자들이 오류를 겪는 문제를 발견하고, 실제 pom.xml의 artifactId와 version을 확인하여 문서를 수정했습니다."

---

### PR #2: [제목]

**기본 정보:**

- **프로젝트**:
- **PR 링크**:
- **이슈 링크**:
- **상태**: ⏳ 진행 중 / ✅ 머지됨 / ❌ 거절됨
- **날짜**: 2025-XX-XX

> "[프로젝트]의 [문제]를 [해결책]으로 해결하여 [성과]를 달성했습니다."

---

### PR #2: [제목]

**기본 정보:**

- **프로젝트**:
- **PR 링크**:
- **이슈 링크**:
- **상태**: ⏳ 진행 중 / ✅ 머지됨 / ❌ 거절됨
- **날짜**: 2025-XX-XX

**기여 내용:**

```
무엇을:
왜:
어떻게:
```

**코드 변경:**

```java

```

**테스트:**

```bash

```

**배운 점:**

-
-

**면접용 한 줄 요약:**

>

---

## 📊 기여 분석

### 기술 스택별 기여

| 기술            | 기여 횟수 | 프로젝트 |
| --------------- | --------- | -------- |
| Spring Boot     | 0         | -        |
| Spring Data JPA | 0         | -        |
| Spring Security | 0         | -        |
| REST API        | 0         | -        |
| Testing         | 0         | -        |

### 기여 유형별 분포

```
Documentation ████████░░ 80% (목표)
Bug Fix       ██████░░░░ 60% (목표)
Feature       ████░░░░░░ 40% (목표)
Refactoring   ██░░░░░░░░ 20% (목표)
```

---

## 🏆 성과 및 성장

### 측정 가능한 성과

- [ ] GitHub 프로필에 머지된 PR 5개 이상
- [ ] Spring 팀으로부터 리뷰 받기
- [ ] 첫 이슈 선점 성공
- [ ] CI/CD 파이프라인 이해

### 정성적 성장

- [ ] 실제 프로덕션 코드 읽기 능력
- [ ] 코드 리뷰 문화 이해
- [ ] 오픈소스 커뮤니티 참여
- [ ] 영문 기술 문서 작성 능력

---

_마지막 업데이트: 2025년 2월_
