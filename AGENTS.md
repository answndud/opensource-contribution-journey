# AGENTS.md

Guidelines for AI agents working on this Spring Boot open source contribution guide repository.

## Project Overview

This repository contains Korean-language documentation guides for contributing to Spring Boot open source projects. It helps beginners navigate the contribution process from finding issues to creating pull requests.

## Build/Test Commands

This is a documentation repository. Use local npm scripts:

```bash
# Install dependencies
npm install

# Validate markdown links
npm run lint:links

# Format markdown
npm run format

# Check markdown syntax
npm run lint:md

# Run all validations
npm run validate

# Docker alternative for markdownlint
docker run --rm -v "$PWD:/workspace" davidanson/markdownlint-cli *.md
```

## Code Style Guidelines

### Documentation Structure

- Use clear hierarchy: `#` for title, `##` for sections, `###` for subsections
- Include table of contents for guides >100 lines
- Use tables for structured comparisons (projects, commands, checklists)
- Add code blocks with language specification: ` ```bash `, ` ```java `

### Writing Style (Korean)

- Use formal but friendly tone (합니다/습니다 style)
- Include practical examples with real commands
- Add emoji markers for visual hierarchy: ⭐, ✅, ❌, 💡, ⚠️
- Keep paragraphs under 5 lines for readability
- Use numbered lists for sequential steps
- Use bullet points for options/non-sequential items

### Formatting Standards

- **Line breaks**: Insert blank line between sections
- **Code blocks**: Always specify language, include `$` for shell commands
- **Commands**: Include both Maven and Gradle alternatives where applicable
- **Links**: Use descriptive text, not raw URLs in body text
- **File paths**: Use backticks: `pom.xml`, `README.md`

### Content Guidelines

1. **Accuracy**: All commands must be tested/verified
2. **Completeness**: Include prerequisites, expected output, and troubleshooting
3. **Examples**: Provide copy-paste ready command snippets
4. **Updates**: Include last-updated date in footer

## Git Workflow

### Commit Message Format

```
docs(<file>): <what changed>

<why it changed>

Related: <issue-if-any>
```

Types: `docs`, `fix`, `update`, `refactor`

Examples:
- `docs(readme): add Docker guide section`
- `fix(guide): correct mvnw command syntax`
- `update(petclinic): refresh star counts and links`

### Branch Naming

```
docs/<description>
update/<section-name>
fix/<error-description>
```

### PR Guidelines

1. Small, focused changes
2. Update date in footer when modifying
3. Verify all links work before submitting
4. Include "Tested locally" in PR description

## File Organization

```
/
├── README.md                          # Project overview (public)
├── AGENTS.md                          # This file
├── 01-guide-open-source-contribution.md # Main contribution guide
├── 02-guide-spring-boot-projects.md   # Project recommendations
├── 03-progress-plan.md                # Roadmap and timeline
├── 04-local-setup.md                  # Local setup notes
├── 05-pr-168-guide.md                 # First PR playbook
├── 01-spring-guides/                  # Spring Guides workspaces
│   ├── 01-getting-started-guides-issues/
│   └── 02-gs-spring-boot-reference-issue-195/
├── 02-spring-projects/                # Spring Projects workspaces
│   └── 01-spring-restdocs-issues-1017-945/
└── portfolio/                         # Job interview portfolio (local-only)
    ├── 프로젝트-선정/                 # Project selection reasoning
    │   └── 스프링부트-오픈소스-선정-이유.md
    ├── 기여-활동/                     # Contribution tracking
    │   ├── 기여-활동-트래킹.md
    │   └── 기여-상세-기록.md
    ├── 학습-일지/                     # Technical learning journal
    │   └── 학습-일지.md
    ├── 회고/                          # Development retrospectives
    │   └── 회고-템플릿.md
    ├── 면접-준비/                     # Interview preparation
    │   └── 면접-가이드.md
    └── 디버깅-로그/                    # Problem solving logs
        └── 디버깅-로그.md
```

## Maintenance Tasks

### Quarterly Updates

- [ ] Verify all GitHub links work
- [ ] Update star counts for listed projects
- [ ] Check Spring Boot version references
- [ ] Verify command syntax still valid

### On Adding New Content

1. Follow existing file structure
2. Match tone with existing guides
3. Include practical, tested examples
4. Add to table of contents if applicable
5. Update last-updated date

## Portfolio Guidelines (For Job Interviews)

This repository serves as a backend developer job interview portfolio.

### Portfolio Writing Principles

1. **Interview-Ready Documentation**
   - Each document should answer "Why? What? How?"
   - Include specific technical challenges and solutions
   - Prepare STAR-method answers for common questions

2. **Contribution Tracking Structure**
   - Project selection rationale
   - Overview dashboard for project-level follow-up
   - Detailed contribution archive (PR links, issues, code/test/review details)
   - Technical growth documentation
   - Problem-solving logs

3. **Regular Updates Required**
   - After each contribution event: Update `기여-활동-트래킹.md` and `기여-상세-기록.md`
   - After learning sessions: Update `학습-일지.md`
   - Weekly: Write retrospective in `회고-템플릿.md`
   - When stuck: Document in `디버깅-로그.md`

### Dual Contribution Documents

Always maintain the two contribution documents together:

1. `portfolio/기여-활동/기여-활동-트래킹.md`
   - Purpose: project-level dashboard and follow-up board
   - Must contain: current counts, project-by-project status, open PR queue, recent status changes, next actions
   - Update timing: immediately after issue claim, PR creation, maintainer feedback, follow-up comment, merge, close, rejection, or blocker resolution

2. `portfolio/기여-활동/기여-상세-기록.md`
   - Purpose: PR-by-PR detailed archive
   - Must contain: issue link, PR link, what/why/how, code or test summary, feedback, follow-up, interview-ready one-line summary
   - Update timing: when a new contribution starts, when implementation direction changes, when meaningful review feedback arrives, and when the PR outcome is finalized

### Contribution Update Rules

When working on any contribution-related task, apply these rules:

1. If a new issue is claimed:
   - Add the project/issue status to `기여-활동-트래킹.md`
   - Create or prepare the matching entry in `기여-상세-기록.md`
2. If a PR is opened:
   - Update counts and open PR lists in `기여-활동-트래킹.md`
   - Add a full PR entry in `기여-상세-기록.md` on the same day
3. If review or maintainer feedback arrives:
   - Update the current status and next action in `기여-활동-트래킹.md`
   - Record the feedback and the planned/implemented response in `기여-상세-기록.md`
4. If a PR is merged, closed, or rejected:
   - Move the PR to the correct status bucket in `기여-활동-트래킹.md`
   - Finalize the outcome, lesson learned, and interview summary in `기여-상세-기록.md`
5. If public summary numbers change materially:
   - Consider syncing `README.md` as the public-facing summary

### Snapshot-Based Sync Workflow

Use the PR snapshot script as the default starting point for follow-up work:

1. Run `./scripts/pr-status-snapshot.sh README.md > /tmp/pr-status-snapshot.md`
2. Compare the snapshot summary with `README.md` and `portfolio/기여-활동/기여-활동-트래킹.md`
3. If any PR status, update time, or bucket has changed:
   - Update the dashboard table and status change log in `기여-활동-트래킹.md` in the same turn
4. If the changed PR includes review feedback, implementation updates, CI blockers, or resolution details:
   - Update `기여-상세-기록.md` in the same turn
5. If totals or public-facing status groups changed:
   - Sync the relevant numbers and links in `README.md` before ending the task
6. Do not leave a confirmed snapshot change unreflected in the tracking documents

### Portfolio Document Templates

#### Project Selection Document
- Why this project was chosen
- Technical and career reasons
- Expected learning outcomes
- Interview Q&A preparation

#### Contribution Tracking
- PR links and status
- Code changes (before/after)
- Test results
- One-line summary for interviews

#### Learning Journal
- Technical concepts learned
- Source references
- Practical applications
- Interview-ready explanations

#### Retrospective
- Keep/Problem/Try format
- Measurable achievements
- Growth tracking
- Insights collection

#### Interview Guide
- Common questions and answers
- STAR method examples
- GitHub profile optimization
- Portfolio presentation tips

#### Debugging Log
- Issue reproduction steps
- Root cause analysis
- Solution verification
- Lessons learned

## Writing Patterns

### Command Block Template

```markdown
```bash
# Description of what this does
./mvnw <command>
# or for Gradle
./gradlew <command>
```

**💡 Tip**: Brief explanation of common flags
```

### Project Table Template

```markdown
| 프로젝트 | Stars | 설명 | 기여 포인트 |
|---------|-------|------|------------|
| [name](url) | count | brief | specific tasks |
```

### Warning Block Template

```markdown
## ⚠️ 주의: Warning Title

Warning content in Korean.

**해결 방법:**
1. Step one
2. Step two
```

## Review Checklist

Before submitting changes:
- [ ] No broken markdown syntax
- [ ] All code blocks have language tags
- [ ] Korean spacing follows conventions (e.g., `입니다 ` not `입니다`)
- [ ] Commands use proper formatting with `./mvnw` or `./gradlew`
- [ ] Links use proper markdown `[text](url)` format
- [ ] Date updated in file footer

---

*This file was generated for AI agents working on Spring Boot contribution guides.*
