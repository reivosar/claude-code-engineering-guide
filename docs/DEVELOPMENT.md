# Development Requirements

**This file must be read for ALL development tasks (writing/modifying code)**

## Core Development Principles
- **Read ALL related code first**: Never touch code without understanding system context
- **Write tests proportional to risk**: R0 = comprehensive, R2 = core paths only
- **Document business impact**: Quantify performance gains, user experience improvements
- **Peer review everything**: Two pairs of eyes catch what one misses
- **Deploy incrementally with monitoring**: Feature flags, canary deployments, instant rollback
- **Monitor with SLA/SLI targets**: p95 latency, error rates, business KPIs

## Design Principles
- **Zero-trust**: Every component verifies all inputs
- **Security-first**: Security requirements supersede functional requirements
- **Composition over inheritance**: Use delegation instead of complex hierarchies
- **Atomic changes**: Single logical unit of work per commit

## Validation Requirements
**CRITICAL: Server startup logs ≠ Working application**
- **Always test the actual user experience**: Visit the URL, click buttons, verify responses
- **Verify all critical paths manually**: Login flow, main features, error handling
- **Screenshot or demonstrate actual behavior**: Never report success without visual proof
- **Test API endpoints with real requests**: Use curl/browser to verify actual responses
- **Check error scenarios**: Test what happens when things go wrong
- **Definition of Done**: "I have personally verified this works as intended" not "the logs say it started"
- **Server startup ≠ Success**: Starting processes is not completion - verify actual functionality
- **Always verify end-to-end functionality**: Test actual screens, API responses, and user flows
- **Never assume based on logs alone**: Logs lie - verify with eyes and real requests

## Code Style Guidelines
**SUMMARY**: 10 language-agnostic principles (readability, complexity ≤10, small units). Community standards + pragmatic exceptions for generated code/performance.
*Details: [docs/CODE_STYLE.md](docs/CODE_STYLE.md)*

## Testing Requirements
**SUMMARY**: Risk-stratified coverage (R0: 100/95%, R1: 95/90%, R2: 90/80%). Differential coverage for legacy. Performance tests required for R0/R1.
*Details: [docs/TESTING.md](docs/TESTING.md)*

## Quality Gates
**SUMMARY**: Pre-commit hooks mandatory. Static analysis zero tolerance. SAST/DAST security scans. Performance targets by risk level.
*Details: [docs/QUALITY_GATES.md](docs/QUALITY_GATES.md)*

## Repository Flow
**SUMMARY**: Branch naming TYPE/description-issue. PR templates with business impact. Risk-appropriate reviewers (R0: 3+, R1: 2+, R2: 1+). Squash merge only.
*Details: [docs/REPO_FLOW.md](docs/REPO_FLOW.md)*

## Exceptions & Large Refactors
- **Label `refactor/*` or `complex/*`** for >400 LOC or >50 lines/class
- Requires **1 additional reviewer** (total 3) and **ADR stub** (1-page template)
- **Automated refactoring tools** count as single logical change

## Differential Coverage Rule
- Coverage/Mutation thresholds apply **to changed lines only** when touching legacy code
- R2 changes with `experimental/*` label: **1 reviewer + bot check** acceptable
- **Hotfix branches**: Can bypass full coverage for critical production fixes (with post-fix cleanup)

## Automated Compliance (Security/Privacy)
- R0 PRs must pass **regulatory compliance scans** (GDPR/PCI/SOX as applicable)
- **Dependency vulnerability scans**: Required in CI pipeline
- **Static security analysis**: Required for all risk levels

## UI/UX Design Requirements
**MANDATORY: Always use Digital Agency Design System for all UI implementations**
- **Primary Design System**: デジタル庁デザインシステム (https://design.digital.go.jp/)
- **Components**: Use official components, tokens, and patterns from the design system
- **Accessibility**: Follow WCAG 2.1 AA standards as required by the design system
- **Typography**: Use designated fonts and text scales from the design system
- **Color Palette**: Use only approved colors from the design system token library
- **Spacing**: Follow the design system's spacing tokens and grid system
- **Icons**: Use icons from the design system icon library
- **Form Elements**: Implement form components according to design system specifications
- **Navigation**: Follow navigation patterns specified in the design system
- **Responsive Design**: Implement responsive breakpoints as defined in the design system
- **NO CUSTOM CSS**: Do not create custom styles that deviate from the design system
- **Documentation**: Reference design system documentation for all UI decisions

## Development Task Completion Checklist
**⚠️ BEFORE REPORTING DEVELOPMENT TASK COMPLETION, YOU MUST: ⚠️**
1. **All items in main CLAUDE.md checklist completed**
2. **All validation requirements above executed**
3. **Actual functionality tested (not just logs)**
4. **UI follows Digital Agency Design System (if applicable)**
5. **Security requirements verified**
6. **Code quality gates passed**
7. **Ask permission before committing any files**

**If you committed without permission = You failed the task**