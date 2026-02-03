# AGENTS.md

Guidelines for AI agents working on this Spring Boot open source contribution guide repository.

## Project Overview

This repository contains Korean-language documentation guides for contributing to Spring Boot open source projects. It helps beginners navigate the contribution process from finding issues to creating pull requests.

## Build/Test Commands

This is a documentation repository. No build system required.

```bash
# Validate markdown links (if tool available)
npx markdown-link-check *.md

# Format markdown (if prettier available)
npx prettier --write *.md

# Check markdown syntax
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
├── README.md                          # Project overview (if exists)
├── AGENTS.md                          # This file
├── how-to-contribute-to-open-source.md # Main contribution guide
├── spring-boot-contribution-guide.md   # Project recommendations
└── portfolio/                         # Job interview portfolio
    ├── project-selection/             # Project selection reasoning
    │   └── why-spring-boot-opensource.md
    ├── contributions/                 # Contribution tracking
    │   └── contribution-tracking.md
    ├── learnings/                     # Technical learning journal
    │   └── learning-journal.md
    ├── retrospectives/                # Development retrospectives
    │   └── retrospective-template.md
    ├── interview-prep/                # Interview preparation
    │   └── interview-guide.md
    └── debugging-logs/                # Problem solving logs
        └── debugging-log.md
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
   - Detailed contribution records (PR links, issues)
   - Technical growth documentation
   - Problem-solving logs

3. **Regular Updates Required**
   - After each contribution: Update `contribution-tracking.md`
   - After learning sessions: Update `learning-journal.md`
   - Weekly: Write retrospective in `retrospective-template.md`
   - When stuck: Document in `debugging-log.md`

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
