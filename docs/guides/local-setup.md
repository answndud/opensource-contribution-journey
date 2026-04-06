# Local Project Configuration

## 개발 도구 (로컬 설치)

이 프로젝트는 로컬 개발 의존성으로 다음 도구들을 사용합니다:

```bash
# package.json 의존성 설치
npm install

# 사용 가능한 명령어
npm run lint:md      # markdown 문법 검사
npm run lint:links   # 마크다운 링크 검증
npm run format       # prettier 포맷팅
npm run validate     # 전체 검증
```

## MCP (Model Context Protocol) 설정

이 프로젝트는 로컬 `.opencode/config.json`에 MCP 설정을 포함합니다.

글로벌 설정 대신 이 프로젝트의 설정을 사용하려면:
1. opencode 실행 시 `--config` 플래그 사용, 또는
2. 프로젝트 루트에서 opencode 실행 (자동 감지)

## GitHub CLI 인증

GitHub CLI는 시스템 전역 도구이므로 별도 관리가 필요합니다:
```bash
gh auth status    # 현재 인증 상태 확인
gh auth login     # 필요시 재인증
```

## SDKMAN (Java 버전 관리)

SDKMAN은 사용자 홈 디렉토리에 설치되므로 시스템 설정을 따릅니다:
```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk list java
```
