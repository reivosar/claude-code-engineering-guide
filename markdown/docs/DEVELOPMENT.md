# Development Requirements

**This file must be read for ALL development tasks (writing/modifying code)**

## Work Process (Development-Specific)

### Mandatory Task Execution Sequence
1. **Read and understand requirements**
2. **Ask clarifying questions in Japanese**
3. **Get explicit approval to proceed** 
4. **Implement solution**
5. **Validate implementation**
6. **Report results with evidence**

### Core Work Process Rules
- **Clarify requirements obsessively**: Ask "what exactly should this do?" until crystal clear
- **Assess risk level first**: Classify changes as R0 (mission-critical), R1 (important), R2 (experimental)
- **Define success criteria upfront**: Business metrics, performance targets, rollback conditions
- **Think in failure modes**: For every feature, ask "how can this break production?"
- **Validate before requesting feedback**: Only seek stakeholder review after code compiles, tests pass, and functionality works correctly

### Communication Behavior
- **Language requirement**: Ask questions in Japanese, require Japanese responses
- **Tone**: Direct and concise professional engineering communication
- **Permission requests**: Always ask permission before committing code or making significant changes
- **Clarifying questions**: Ask "what exactly?" until requirements are crystal clear
- **Error handling**: Stop immediately on validation failure, report specific failure reason

### Validation Behavior
- **Halt condition**: validation_passed = false
- **Enforcement**: STRICT - No exceptions
- **Definition**: Development task = Implementation + All validations passed
- **User report rule**: NO user reporting until validation_passed = true

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

### Mandatory Validation Steps
- **Always test the actual user experience**: Visit the URL, click buttons, verify responses
- **Verify all critical paths manually**: Login flow, main features, error handling
- **Screenshot or demonstrate actual behavior**: Never report success without visual proof
- **Test API endpoints with real requests**: Use curl/browser to verify actual responses
- **Check error scenarios**: Test what happens when things go wrong
- **Definition of Done**: "I have personally verified this works as intended" not "the logs say it started"
- **Server startup ≠ Success**: Starting processes is not completion - verify actual functionality
- **Always verify end-to-end functionality**: Test actual screens, API responses, and user flows
- **Never assume based on logs alone**: Logs lie - verify with eyes and real requests

### Validation Enforcement
- **Halt condition**: All development stops if validation_passed = false
- **No user reporting**: FORBIDDEN to report completion until all validations pass
- **Evidence required**: Provide concrete proof of functionality (screenshots, test results, API responses)
- **End-to-end verification**: Test complete user workflows, not just individual components

## Code Style Guidelines

**SUMMARY**: 10 language-agnostic principles (readability, complexity <=10, small units). Community standards + pragmatic exceptions for generated code/performance.
_Details: [docs/CODE_STYLE.md](docs/CODE_STYLE.md)_

## Testing Requirements

**SUMMARY**: Risk-stratified coverage (R0: 100%/100%/95%, R1: 95%/90%/90%, R2: 90%/85%/80% line/branch/mutation). Differential coverage for legacy. Performance tests required for R0/R1.
_Details: [docs/TESTING.md](docs/TESTING.md)_

## Quality Gates

**SUMMARY**: Pre-commit hooks mandatory. Static analysis zero tolerance. SAST/DAST security scans. Performance targets by risk level.
_Details: [docs/QUALITY_GATES.md](docs/QUALITY_GATES.md)_

## Repository Flow

**SUMMARY**: Branch naming PREFIX/descriptive-name. PR templates with business impact. Risk-appropriate reviewers (R0: 3+, R1: 2+, R2: 1+). Squash merge default.
_Details: [docs/REPO_FLOW.md](docs/REPO_FLOW.md)_

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

### Primary Design System
- **System**: Digital Agency Design System (https://design.digital.go.jp/)
- **Configurable**: Design system can be changed if business requirements demand it
- **Documentation**: Reference design system documentation for all UI decisions

### Design System Compliance
- **Components**: Use official components, tokens, and patterns from the design system
- **NO CUSTOM CSS**: Do not create custom styles that deviate from the design system without approval
- **Exceptions**: Document and get approval for business critical requirements that require deviations
- **Process**: Business critical requirement → Document exception → Get approval → Implement

### Accessibility Requirements (WCAG 2.1 AA)
- **Keyboard navigation support**
- **Screen reader compatibility** 
- **Color contrast compliance**
- **Focus indicators visible**
- **Alt text for images**
- **ARIA labels where needed**

### Responsive Design Standards
- **Mobile-first approach**
- **Breakpoints**: Mobile (320px), Tablet (768px), Desktop (1024px), Wide (1440px)
- **Fluid typography**
- **Flexible images**
- **Progressive enhancement**

### Performance Standards
- **FCP**: < 1.8s
- **LCP**: < 2.5s  
- **FID**: < 100ms
- **CLS**: < 0.1
- **Optimization**: Lazy load images, code split by route, minimize bundle size, cache static assets

## Unexpected Situation Handling

### When Unexpected Issues Occur
1. **Stop current execution immediately**
2. **Analyze the unexpected situation**
3. **Ask user for clarification if needed**  
4. **Propose solution approach**
5. **Get user approval before proceeding**
6. **Implement solution**
7. **Verify solution works**
8. **Resume normal flow**

### Error Analysis Process
- **Read all error messages completely**
- **Identify what was expected vs what happened**
- **Check recent changes that might have caused this**
- **Look for similar issues in documentation**
- **Gather all relevant context**

### Communication During Problems
- **Report the problem clearly in Japanese**
- **Explain what went wrong**
- **Describe what you tried to do**
- **Present possible solutions**
- **Ask for user's preferred approach**
- **Never guess or assume solutions**

### Recovery Strategies
- **When stuck**: Stop and ask user for help, explain exactly where you're stuck
- **When confused**: Admit confusion immediately, ask clarifying questions
- **When something breaks**: Stop immediately, document current state, report what broke and when

### Solution Implementation
- **Start with the least risky solution**
- **Make one change at a time**
- **Test each change immediately**
- **Document what was changed and why**
- **Revert if solution makes things worse**

### Never Do
- Never proceed without understanding the problem
- Never skip reporting unexpected issues
- Never assume the problem will resolve itself
- Never make random changes hoping they work
- Never ignore error messages

## Development Task Completion Checklist

**BEFORE REPORTING DEVELOPMENT TASK COMPLETION, YOU MUST:**

1. **All items in main CLAUDE.md checklist completed**
2. **All validation requirements above executed**
3. **Actual functionality tested (not just logs)**
4. **UI follows Digital Agency Design System (if applicable)**
5. **Security requirements verified**
6. **Code quality gates passed**
7. **Ask permission before committing any files**
8. **validation_passed = true**

**If you committed without permission = You failed the task**
