# Repository Flow

## Branch Strategy

### Branch Types & Prefixes

- **main**: Production-ready code, always deployable
- **feature/\***: New functionality development
- **bugfix/\***: Bug corrections and fixes
- **hotfix/\***: Critical production fixes
- **release/\***: Release preparation
- **chore/\***: Maintenance and housekeeping
- **refactor/\***: Code structure improvements
- **experimental/\***: R2 experimental features

### Branch Naming Convention

```
PREFIX/descriptive-name

Examples:
feature/add-user-authentication
bugfix/fix-login-redirect
hotfix/patch-security-vulnerability
chore/update-dependencies
release/v2.1.0
```

### Branch Rules
- **Branch from main/master**: Always start from the main branch
- **Use descriptive names**: Clear indication of what the branch does
- **Include ticket number if applicable**: Link to tracking system
- **Keep branches short-lived**: Merge within days, not weeks

## Commit Standards

### Commit Message Format
```
<type>(<scope>): <subject>

<body - explain WHY not WHAT>

Closes #<issue>
```

### Commit Types
- **feat**: new feature
- **fix**: bug fix
- **docs**: documentation
- **style**: formatting changes
- **refactor**: code restructuring
- **test**: test updates
- **chore**: maintenance tasks

### Commit Rules
- **Use imperative mood**: "Add feature" not "Added feature"
- **Keep subject line under 72 characters**
- **Explain WHY in body if needed**: Context and reasoning
- **Reference issues/tickets**: Link to tracking system

## Pull Request Management

### Size Guidelines

- **Standard**: Maximum 400 lines changed (excluding tests)
- **Large refactor**: Use `refactor/*` or `complex/*` labels
- **Requires**: 1 additional reviewer (total 3) + ADR stub

### PR Template Structure

```markdown
## Summary

[Brief description of changes and business justification]

## Risk Level & Justification

- [ ] R0 (Mission-Critical): [Explain why]
- [ ] R1 (Important): [Explain why]
- [ ] R2 (Experimental): [Explain why]

## Business Impact

- **Revenue Impact**: [Quantified where possible]
- **Performance Impact**: [Response time, throughput changes]
- **User Experience**: [UX improvements/changes]
- **Technical Debt**: [Debt added/removed]

## Testing Strategy

- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Performance tests (R0/R1 only)
- [ ] Manual testing completed

## Security & Compliance

- [ ] Security review completed
- [ ] No new vulnerabilities introduced
- [ ] Regulatory compliance verified (R0 only)
- [ ] Data classification checked (R0 only)

## Rollback Plan

[Detailed steps to revert if issues arise]

## Monitoring & Alerts

- [ ] Metrics/dashboards updated
- [ ] Alerts configured
- [ ] Business KPI tracking (R0 only)

## PR Checklist

- [ ] Tests pass
- [ ] Code reviewed
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No console errors
- [ ] Screenshots if UI changes
- [ ] Breaking changes documented
```

## Review Process

### Reviewer Requirements

| Risk Level | Reviewers | Expertise Required                         |
| ---------- | --------- | ------------------------------------------ |
| R0         | 3+        | Domain expert + Security + Senior          |
| R1         | 2+        | Domain expert + Peer                       |
| R2         | 1+        | Peer reviewer (or bot for experimental/\*) |

### Review Criteria

- **Code quality**: Follows style guidelines and best practices
- **Business logic**: Correctly implements requirements
- **Testing**: Appropriate test coverage for risk level
- **Security**: No vulnerabilities introduced
- **Performance**: Meets performance requirements
- **Documentation**: Adequate documentation provided

## Merge Strategy

### Requirements Before Merge

- All required approvals received
- All CI checks passing
- No merge conflicts
- Branch up to date with main

### Merge Types

- **Default**: Squash and merge for standard changes
- **Exceptions**:
  - Feature branches: Merge commit to preserve feature history
  - Release branches: Merge commit for release tracking
- **Never**: Rebase (maintain true history)

### Approval Requirements

- **Require PR approval**: Based on risk level (R0: 3+, R1: 2+, R2: 1+)
- **Pass all CI checks**: Automated testing and quality gates
- **Update from main before merge**: Ensure current with latest changes

### Post-Merge Actions

- Delete feature branch immediately
- Update related issues/tickets
- Deploy to staging environment
- Monitor deployment metrics

## Special Workflows

### Hotfix Process

1. Branch from main: `hotfix/description-issue`
2. Implement minimal fix with tests
3. Fast-track review (1 senior reviewer minimum)
4. Deploy immediately to production
5. Backport to development branches
6. Follow up with comprehensive fix if needed

### Experimental Features

1. Use `experimental/*` branch prefix
2. Reduced review requirements (1 reviewer + bot)
3. Feature flags for gradual rollout
4. Time-boxed experimentation period
5. Decision point: promote, modify, or remove

### Large Refactoring

1. Create ADR documenting approach
2. Break into smaller, reviewable chunks
3. Maintain system functionality throughout
4. Coordinate with dependent teams
5. Gradual migration strategy
