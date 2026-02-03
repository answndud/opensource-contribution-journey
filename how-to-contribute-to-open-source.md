아래는 "완전 초보자" 기준으로, **이슈 찾기 → 수정 → PR 만들기 → 머지까지** 전 과정을 Spring Boot 관련 하위/예제 레포를 대상으로 설명한 절차서입니다. 실무에서 통하는 최소한의 규범과 실패 포인트도 함께 넣었습니다.

> **💡 왜 오픈소스에 기여하나요?**
> - 실제 프로덕션 코드를 접하며 실력 향상
> - 코드 리뷰를 통해 전문가의 피드백 수집
> - 취업 시 포트폴리오로 활용 (GitHub 프로필이 이력서 대용)
> - 개발자 네트워크 형성 및 기술 트렌드 파악
> - 세상을 바꾸는 소프트웨어에 직접 기여하는 성취감

---

# 0) 준비

## GitHub 계정 설정

* **GitHub 계정** 생성: github.com에서 가입
* **프로필 설정**: 
  - Settings → Profile에서 이름과 공개 이메일 설정
  - 프로필 사진 업로드 (전문성을 보여줌)
  - Bio에 관심 기술 스택 표시 (예: "Java Backend Developer | Spring Boot | Learning Open Source")

## Git 로컬 설정

로컬 Git 설정 (한 번만 설정하면 됨):

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main  # 기본 브랜치 이름 설정
git config --global core.autocrlf input      # 줄바꿈 처리 (Mac/Linux)
# Windows 사용자는: git config --global core.autocrlf true
```

**💡 팁**: GitHub에 등록한 이메일과 동일하게 설정해야 커밋이 제대로 연결됩니다.

## 개발 환경 준비

* **JDK 설치**: Spring Boot 프로젝트는 보통 Java 17 또는 21을 요구
  - 레포의 `README.md`, `pom.xml` (Maven), `gradle.properties` (Gradle)에서 요구 버전 확인
  - SDKMAN으로 여러 버전 관리 추천: `sdk install java 21.0.2-tem`
  
* **IDE 선택**:
  - **IntelliJ IDEA** (Ultimate/Community): Spring 개발에 최적, Spring Boot 플러그인 내장
  - **VS Code**: Spring Boot Extension Pack 설치 가능, 가벼움
  - **Eclipse + STS**: 전통적인 선택
  
* **GitHub Codespaces**: 
  - 브라우저에서 바로 개발 가능, 환경 설정 불필요
  - 월 120시간 무료 사용 가능 (Pro 계정)
  - `.devcontainer` 설정이 있는 프로젝트라면 더 쉬움

---

# 1) “좋은 첫 이슈” 찾기

## 검색식 예시 (깃허브 이슈 검색창)

GitHub 상단 검색창에서 이슈 필터링:

### Spring 공식/에코시스템 (자바 위주)

```
is:issue is:open label:"good first issue" language:Java topic:"spring-boot"
```

### 특정 조직별 검색

```
# Spring 공식 프로젝트
org:spring-projects is:issue is:open label:"good first issue"

# Spring 가이드/예제
org:spring-guides is:issue is:open label:"help wanted"

# Spring Cloud
org:spring-cloud is:issue is:open label:"good first issue"
```

### 추가 유용한 검색 조합

```
# 초보자 친화적인 모든 이슈
is:issue is:open label:"good first issue" OR label:"beginner friendly" OR label:"help wanted"

# 문서 관련 이슈 (가장 쉬움)
is:issue is:open label:"documentation" language:Java

# 오타/오류 수정
is:issue is:open "typo" OR "spell" language:Java
```

## 이슈 읽는 법 (중요!)

### 1) 기본 정보 확인
* **제목/본문**에서 **재현 방법, 기대 동작, 현재 동작**이 명확한지 확인
* **라벨** 확인: `bug`, `enhancement`, `documentation`, `good first issue`
* **담당자(Assignees)**: 이미 할당된 사람이 있는지 확인

### 2) 중복/관련 확인
* **"Linked pull requests"**, **"References"** 섹션: 이미 진행 중인 PR은 없는지
* ** 코멘트**: 다른 사람이 작업 중인지 언급했는지 확인
* **최근 활동**: 마지막 코멘트 날짜가 6개월 이상 지났다면 프로젝트가 방치되었을 수 있음

### 3) 프로젝트 활성도 확인
* **커밋 히스토리**: 최근 1-2개월 내 커밋이 있는지
* **릴리즈 주기**: 최신 버전이 언제 나왔는지
* **컨트리뷰터 수**: 활발한 프로젝트는 PR 처리가 빠름

## 착수 선언 (선점) - 매우 중요!

초보자 경쟁이 치열합니다. **작업 시작 전 반드시** 이슈에 댓글로 선언하세요.

### 템플릿 예시

**간단한 선언**:
```
Hi! I'd like to work on this issue. This would be my first contribution to this project.
```

**구체적인 질문이 있을 때**:
```
Hi! I'm interested in working on this issue. 

Before I start, I have a few questions:
1. Should the fix be applied to the main branch only, or also to version 2.x?
2. Is there a specific test file I should add tests to?
3. Would you prefer approach A or B for the implementation?

This is my first contribution here, so any guidance would be appreciated!
```

### 주의사항
* **"Is this still open?"** 같은 메타 질문은 피하세요 (이슈가 열려있으면 열린 것)
* 작업량을 과대약속하지 마세요 ("I'll fix everything" → "I'll start with the typo fix")
* 24-48시간 내 답변이 없으면 다른 이슈 찾기 (busy maintainer)

---

# 2) 레포 포크 & 환경 준비

## 1) Fork (포크) - 왜 필요한가?

**Fork**는 원본 레포지토리를 **내 계정으로 복사**하는 것입니다.

### 왜 Fork가 필요할까요?
1. **권한**: 대부분의 프로젝트는 직접 push 권한이 없음 (collaborator만 가능)
2. **안전**: 내 실험적인 변경이 원본을 망가뜨리지 않음
3. **독립성**: 원본이 변경되어도 내 Fork는 그대로 유지

### 포크 방법
1. 원본 레포지토리 페이지로 이동 (예: `github.com/spring-guides/gs-spring-boot`)
2. 우측 상단 **"Fork"** 버튼 클릭 (⭐ 버튼 왼쪽)
3. "Create a new fork" 페이지에서:
   - **Owner**: 본인 계정 선택
   - **Repository name**: 기본값 유지 (보통)
   - **Description**: 필요시 수정
   - **Copy the main branch only**: 체크 (필요한 브랜치만)
4. **"Create fork"** 클릭

### 포크 후 화면
* 주소가 `github.com/<your-username>/<repo>` 로 변경됨
* 상단에 "forked from spring-guides/gs-spring-boot" 표시

## 2) Clone (클론) - 내 컴퓨터로 가져오기

```bash
# HTTPS 방식 (개인 액세스 토큰 필요할 수 있음)
git clone https://github.com/<your-username>/<repo>.git

# SSH 방식 (키 설정 필요, 더 안전하고 편함)
git clone git@github.com:<your-username>/<repo>.git

cd <repo>  # 프로젝트 폴더로 이동
```

**💡 SSH 설정 권장**:
```bash
# SSH 키 생성 (한 번만)
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub  # 내용을 GitHub Settings → SSH and GPG keys에 추가
```

## 3) Upstream 원본 추가 - 동기화용

**Upstream**은 원본 레포지토리를 가리키는 별명입니다. 원본의 변경사항을 받아오기 위해 필요합니다.

```bash
# upstream 원격 저장소 추가
# (페이지 상단 "forked from..." 링크에서 원본 주소 확인)
git remote add upstream https://github.com/<original-owner>/<repo>.git

# 설정 확인 (origin=내 포크, upstream=원본)
git remote -v
# 출력 예시:
# origin    git@github.com:myusername/repo.git (fetch)
# origin    git@github.com:myusername/repo.git (push)
# upstream  https://github.com/spring-guides/repo.git (fetch)
# upstream  https://github.com/spring-guides/repo.git (push)
```

## 4) 브랜치 생성 (이슈 단위로)

**왜 브랜치를 사용하나요?**
- 기능별/이슈별로 작업 분리
- 실수로 main 브랜치를 망가뜨려도 안전
- 여러 PR을 동시에 진행 가능

### 브랜치 네이밍 규칙

```bash
# 일반적인 패턴:
# <type>/<short-description>-<issue-number>

git checkout -b fix/petclinic-typo-1234
git checkout -b docs/admin-readme-4567
git checkout -b feature/add-validation-789
git checkout -b refactor/simplify-service-101

# 타입 종류:
# fix/      - 버그 수정
# docs/     - 문서 수정
# feature/  - 새 기능 추가
# refactor/ - 코드 리팩토링
# test/     - 테스트 추가/수정
```

### 브랜치 작업 흐름
```bash
# 1. main 브랜치에서 최신 코드 받기
git checkout main
git fetch upstream
git reset --hard upstream/main

# 2. 새 브랜치 생성
git checkout -b fix/<short-desc>-<issue-number>

# 3. 작업 진행...
```

---

# 3) 빌드/테스트 구동

## Maven 기반 프로젝트 (pom.xml 존재)

```bash
# 단위 테스트만 실행
./mvnw -q test

# 모든 테스트 + 통합 테스트
./mvnw -q verify

# 패키지 빌드 (테스트 포함)
./mvnw clean package

# 특정 테스트만 실행
./mvnw test -Dtest=ExampleControllerTest

# 테스트 제외하고 빌드 (빠르게)
./mvnw package -DskipTests
```

**💡 처음 실행시**: Maven Wrapper(`mvnw`)가 Maven을 자동 다운로드 (설치 불필요)

## Gradle 기반 프로젝트 (build.gradle 존재)

```bash
# 테스트 실행
./gradlew test

# 모든 검사 (테스트, 정적 분석 등)
./gradlew check

# 빌드
./gradlew build

# 특정 테스트
./gradlew test --tests ExampleControllerTest
```

## 코드 스타일/포맷터 적용

많은 Spring 프로젝트는 Spotless나 Checkstyle을 사용:

```bash
# Maven + Spotless
./mvnw spotless:apply    # 자동 포맷팅 적용
./mvnw spotless:check    # 포맷팅 확인만

# Gradle + Spotless
./gradlew spotlessApply
./gradlew spotlessCheck

# Spring Boot 프로젝트의 경우
./mvnw spring-javaformat:apply  # Spring 전용 포맷터
```

## ⚠️ 주의: 문서/샘플 레포도 테스트가 있음!

README만 수정해도 다음 검사가 실행될 수 있습니다:
* **링크 체크**: 외부 링크가 살아있는지
* **마크다운 문법**: 잘못된 문법 체크
* **빌드 테스트**: 예제 코드가 실제로 컴파일되는지

**반드시 로컬에서 `./mvnw verify` 또는 `./gradlew check`를 통과시킨 후 PR 생성!**

---

# 4) 수정 작업 (작게, 명확하게)

## 핵심 원칙: 한 PR = 한 주제

**나쁜 예시** (한 PR에 여러 주제):
```
Fix typo in README + Add new feature + Refactor controller + Update dependencies
```

**좋은 예시** (PR 분리):
```
PR #1: Fix typo in README (documentation)
PR #2: Add input validation to UserController (feature)
PR #3: Update Spring Boot to 3.2.0 (dependency)
```

## 작업 순서

```
재현(버그 확인) → 수정 → 테스트 추가/보완 → 로컬 빌드 통과
```

### 문서 변경 시

* 오탈자라도 **근거**를 PR 본문에 첨부하면 리뷰가 빨라집니다:
  - "Spring Boot 2.x" → "Spring Boot 3.x" (버전 업데이트)
  - "Maven" → "Apache Maven" (정식 명칭)
  - 문법 교정 사이트 링크 (grammarly, etc.)

### 코드 변경 시

1. **기존 테스트 통과 확인** 먼저
2. **회귀 방지 테스트** 추가 (버그 고쳤다면 그 버그를 재현하는 테스트)
3. **변경사항 최소화**: 필요한 것만 수정

---

# 5) 커밋 (Commit)

## 작은 단위로 커밋

**나쁜 예시** (한 커밋에 모든 것):
```bash
git add .
git commit -m "Update"
```

**좋은 예시** (논리적 단위로 분리):
```bash
git add README.md
git commit -m "Fix typo in installation guide"

git add src/
git commit -m "Add null check for request body"

git add test/
git commit -m "Add test for null request body handling"
```

## 커밋 메시지 작성법 (매우 중요!)

### Conventional Commits 스타일 (권장)

```
<type>(<scope>): <subject>

<body>

<footer>
```

**타입 종류**:
- `feat`: 새 기능
- `fix`: 버그 수정
- `docs`: 문서만 변경
- `style`: 코드 스타일 (세미콜론, 포맷 등, 로직 변경 없음)
- `refactor`: 리팩토링 (기능은 같고 구조만 변경)
- `test`: 테스트 추가/수정
- `chore`: 빌드, 설정 등 잡다한 것

### 예시

**간단한 문서 수정**:
```
docs(readme): fix typo in installation instructions

Changed "sprng" to "Spring" in the Maven setup section.
```

**버그 수정**:
```
fix(controller): handle null request body in ExampleController

The controller assumed non-null payload and threw NPE on empty POST.
This change adds a null check and returns 400 with a helpful message.

Tests cover the regression scenario:
- testNullRequestBody() added to ExampleControllerTest

Fixes #123
```

**기능 추가**:
```
feat(service): add email validation to UserRegistrationService

Implements RFC 5322 compliant email validation.
Returns 400 Bad Request with field error if email format is invalid.

Closes #456
```

## DCO (Developer Certificate of Origin)

일부 프로젝트(Spring 포함)는 DCO 서명을 요구합니다. 이는 "내가 작성한 코드이며 라이선스를 준수한다"는 서명입니다.

```bash
# -s 플래그로 서명 자동 추가
git commit -s -m "Fix: handle null request body"

# 커밋 메시지 하단에 다음이 추가됨:
# Signed-off-by: Your Name <you@example.com>
```

**DCO 체크 실패시** (기존 커밋에 서명 추가):
```bash
# 마지막 N개 커밋에 서명 추가
git rebase HEAD~3 --signoff

# 강제 푸시 (주의: PR 브랜치에서만 사용)
git push -f origin HEAD
```

---

# 6) 원격 푸시 & PR (Pull Request) 열기

## 1) 푸시 (Push)

```bash
# 현재 브랜치를 원격(origin)에 푸시
# -u (--set-upstream) 플래그: 로컬 브랜치와 원격 브랜치 연결
git push -u origin HEAD

# 이후부터는 단순히
git push
```

## 2) GitHub에서 PR 생성

푸시 후 GitHub 페이지에서 **"Compare & pull request"** 버튼이 나타납니다.

### PR 작성 단계

**1. 브랜치 선택**:
   - **base**: 원본 레포의 main (머지 대상)
   - **compare**: 내 포크의 fix/... 브랜치 (내 변경사항)

**2. 제목 작성**:
   - 명확하고 간결하게
   - "Fix typo" ❌ → "Fix typo in README installation section" ✅

**3. 본문 작성** (PR 템플릿 활용):

```markdown
## Description
<!-- 무엇을 고쳤는지 요약 -->
Fixed NullPointerException in ExampleController when request body is null.

## Changes
<!-- 주요 변경사항 -->
- Added null check in ExampleController.handleRequest()
- Returns 400 Bad Request with error message instead of 500 NPE
- Added test case for null request body scenario

## Testing
<!-- 테스트 방법 -->
```bash
./mvnw test -Dtest=ExampleControllerTest
```
All tests pass including the new regression test.

## Related Issue
<!-- 관련 이슈 연결 (자동 닫힘 키워드) -->
Fixes #123

## Screenshots (if applicable)
<!-- UI 변경시 스크린샷 -->
N/A - Backend change only

## Checklist
- [x] Code follows project style guidelines (./mvnw spotless:apply)
- [x] Tests added for new functionality
- [x] All tests pass locally
- [x] Documentation updated (if needed)
- [x] DCO sign-off included (git commit -s)
```

### PR 키워드 (이슈 자동 닫힘)

```
Fixes #123      - PR 머지시 #123 이슈 자동 닫힘
Closes #123     - 동일
Resolves #123   - 동일

Related to #123 - 연결만 하고 닫지 않음
Refs #123       - 동일
```

## 3) Draft PR (선택사항)

방향성 확인용으로 Draft PR을 먼저 열 수 있습니다:

1. PR 생성 페이지에서 **"Create draft pull request"** 선택 (버튼 드롭다운)
2. "Draft" 라벨이 붙어 리뷰어가 "아직 진행 중"임을 알 수 있음
3. 준비 완료 후 **"Ready for review"** 버튼 클릭

---

# 7) 리뷰 대응 (왕복 과정)

## 리뷰는 정상입니다!

**처음부터 완벽한 PR은 없습니다**. 리뷰 피드백은:
- 코드 품질 향상
- 프로젝트 규칙 준수
- 학습 기회

### 리뷰 대응 방법

**1. 피드백 수용**:
```
Reviewer: "Can you extract this to a constant?"

You: "Good point! I'll update it."
```

**2. 질문이 있을 때**:
```
Reviewer: "Why did you choose approach A over B?"

You: "I chose A because... However, I'm open to B if you prefer. 
       What are the specific benefits of B in this context?"
```

**3. 수정 후 푸시**:
```bash
# 수정 작업
git add .
git commit -m "Address review: extract magic number to constant"

# 같은 브랜치에 푸시하면 PR에 자동 반영
git push
```

## 충돌 (Conflict) 해결

원본 레포가 변경되어 충돌이 발생하면:

```bash
# 1. 최신 원본 가져오기
git fetch upstream

# 2. 리베이스 (충돌 해결)
git rebase upstream/main

# 충돌 파일이 표시됨 (CONFLICT 표시)
# 파일을 열어 충돌 부분 수정 (<<<<< HEAD / ===== / >>>>>)

git add <충돌 해결된 파일>
git rebase --continue

# 3. 강제 푸시 (rebase는 히스토리를 변경하므로)
git push -f
```

**💡 충돌이 너무 많으면**: 새 브랜치를 만들어 처음부터 cherry-pick 하는 것도 방법

## CI (Continuous Integration) 실패 대응

GitHub Actions 등의 자동 검사가 실패하면:

**1. 로그 확인**: 
   - PR 하단의 "Checks" 탭 클릭
   - 실패한 job 클릭 → 로그 확인

**2. 일반적인 실패 원인**:
   - 테스트 실패: 로컬에서 `./mvnw test` 재확인
   - 스타일 위반: `./mvnw spotless:apply` 실행
   - 라이선스 헤더 누락: `./mvnw license:format` (해당시)

**3. 수정 후 푸시**: 자동으로 CI 재실행

---

# 8) 머지 (Merge) 이후 정리

## 머지 완료 확인

* PR 페이지에서 **"Merged"** 표시 확인
* 감사의 코멘트 남기기: "Thank you for the review!"

## 로컬/포크 정리

```bash
# 1. 로컬 main 브랜치로 이동
git checkout main

# 2. 최신 원본 동기화
git fetch upstream
git reset --hard upstream/main

# 3. 로컬 브랜치 삭제
git branch -D fix/<short-desc>-<issue-number>

# 4. 원격 브랜치 삭제
git push origin :fix/<short-desc>-<issue-number>
# 또는
git push origin --delete fix/<short-desc>-<issue-number>

# 5. 내 포크 동기화 (GitHub UI에서 Sync fork 클릭)
# 또는 명령어로:
git push origin main --force-with-lease
```

## 다음 기여 준비

* 성공 경험 정리: 어려웠던 점, 배운 점 기록
* 다른 이슈 찾기: 더 도전적인 이슈로 레벨업
* 커뮤니티 참여: Discussions, Issues에 코멘트

---

# 9) 초보자용 체크리스트 (요약)

## 작업 전
- [ ] 이슈 본문 끝까지 읽고 중복 PR 없는지 확인
- [ ] "I'd like to work on this."로 선점 코멘트 작성
- [ ] `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `LICENSE` 확인
- [ ] 프로젝트 빌드/테스트 요구사항 숙지

## 작업 중
- [ ] 작은 단위로 커밋 (논리적 분리)
- [ ] 모든 테스트 통과 확인 (로컬에서 `./mvnw verify`)
- [ ] 코드 스타일 적용 (`./mvnw spotless:apply`)
- [ ] DCO 서명 포함 (`git commit -s`)

## PR 작성
- [ ] 명확한 제목 (무엇을 고쳤는지)
- [ ] 상세한 본문 (왜, 어떻게, 테스트 방법)
- [ ] 이슈 연결 (`Fixes #123`)
- [ ] 필요시 스크린샷 첨부

## 리뷰 후
- [ ] 피드백 정성껏 반영
- [ ] CI 그린 상태 유지
- [ ] 충돌 발생시 해결
- [ ] 머지 후 브랜치 정리

---

# 10) 실패를 줄이는 팁

## 작업 시작 전

**간단한 변경이라도 이슈에 접근 방향을 짧게 제안**:
```
Hi! I'd like to work on this. My plan:
1. Add validation in UserService.validateEmail()
2. Add test in UserServiceTest
3. Update documentation

Does this approach sound good?
```

## 프로젝트 선택 전략

**문서/샘플부터 시작** (성공률 높음):
- `spring-guides/*` - Getting Started Guides
- `spring-projects/spring-petclinic` - 샘플 애플리케이션
- `spring-projects/spring-data-examples` - 예제 코드

**Starter 생태계** (진입장벽 낮음):
- `mybatis/spring-boot-starter` - 데이터베이스 매퍼
- `spring-projects/spring-boot`의 하위 모듈
- 커뮤니티 starter 프로젝트들

## 테스트 우선 마인드셋

**"고쳤다"보다 "깨지던 테스트가 통과한다"가 설득력 있음**:
```java
@Test
public void testNullRequestBody() {
    // Given: null request body
    RequestBody body = null;
    
    // When: handling request
    Response response = controller.handle(body);
    
    // Then: should return 400, not 500
    assertEquals(400, response.getStatus());
}
```

## 스팸성 PR 금지

**대부분 거절당하는 PR 유형**:
- ❌ 단순 포맷만 변경 (import 순서, 줄바꿈 등)
- ❌ 불필요한 리팩터링 (변수명만 바꾸기 등)
- ❌ README 오타 수정 (의미 없는 변경)
- ❌ 테스트 커버리지 100% 강제 추가 (기존 코드 품질 저하)

---

# 11) 바로 써먹는 명령 묶음 (카피해두기)

```bash
# ============== 1) 초기 설정 ==============
# 포크한 레포 클론
git clone git@github.com:<you>/<repo>.git
cd <repo>

# upstream 원본 추가
git remote add upstream https://github.com/<upstream-owner>/<repo>.git

# ============== 2) 브랜치 생성 ==============
# 최신 동기화 & 브랜치 생성
git fetch upstream
git checkout -b fix/<desc>-<issue#> upstream/main

# ============== 3) 개발 ==============
# ... 작업 진행 ...

# 빌드/테스트
./mvnw clean verify        # Maven
# 또는
./gradlew clean check      # Gradle

# 코드 포맷팅
./mvnw spotless:apply
# 또는
./gradlew spotlessApply

# ============== 4) 커밋 ==============
# 변경사항 확인
git status
git diff

# 스테이징 & 커밋
git add -A
git commit -s -m "fix: <short description>

Detailed explanation of what and why.

Fixes #<issue-number>"

# ============== 5) 푸시 & PR ==============
# 원격에 푸시
git push -u origin HEAD

# → GitHub에서 "Compare & pull request" 클릭
# → PR 템플릿 작성
# → "Create pull request" 클릭

# ============== 6) 리뷰 반영 ==============
# 최신 원본 동기화 (충돌 방지)
git fetch upstream
git rebase upstream/main

# 충돌 발생시:
# 1. 충돌 파일 수정
# 2. git add <파일>
# 3. git rebase --continue

# 푸시 (강제 푸시 주의)
git push -f

# ============== 7) 머지 후 정리 ==============
git checkout main
git fetch upstream
git reset --hard upstream/main
git branch -D fix/<desc>-<issue#>
git push origin --delete fix/<desc>-<issue#>
git push origin main --force-with-lease
```

---

# 12) 추가 리소스

## GitHub 오픈소스 기여 연습

* [First Contributions](https://github.com/firstcontributions/first-contributions) - 안전한 연습용 레포
* [GitHub Skills](https://skills.github.com/) - GitHub 공식 튜토리얼

## Spring 생태계 학습

* [Spring.io Guides](https://spring.io/guides) - 공식 가이드
* [Spring Boot Reference](https://docs.spring.io/spring-boot/docs/current/reference/html/) - 공식 문서
* [Spring One](https://springone.io/) - Spring 컨퍼런스 (영상 무료)

## 커뮤니티

* [Spring Discord](https://discord.gg/spring) - 실시간 채팅
* [Spring Forum](https://forum.spring.io/) - 포럼
* [Stack Overflow - spring-boot 태그](https://stackoverflow.com/questions/tagged/spring-boot)

---

## 마무리

처음엔 **문서/예제/작은 버그**부터 시작하세요. 다음 세 가지만 지켜도 승인 확률은 충분히 높습니다:

1. ✅ **이슈 선점** - "I'd like to work on this"
2. ✅ **테스트 통과** - `./mvnw verify` 필수
3. ✅ **명확한 PR 본문** - 무엇, 왜, 어떻게

**기억하세요**: 모든 전문가도 한때 첫 컨트리뷰션이 있었습니다. 작은 시작이 큰 성장의 시작입니다! 🚀

---

*마지막 업데이트: 2025년 2월*  
*이 문서는 Spring Boot 생태계 기여를 위한 실전 가이드입니다.*
