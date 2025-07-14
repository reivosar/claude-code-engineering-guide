---
risk-level: R1
maintainer: @dev-team
last-reviewed: 2025-07-14
purpose: Repository workflow, branching strategy, and PR management procedures
---

# Repository Flow

## Branch Strategy

### Branch Types
- **main**: Production-ready code, always deployable
- **feature/***: New functionality development
- **refactor/***: Code structure improvements
- **fix/***: Bug corrections
- **hotfix/***: Critical production fixes
- **experimental/***: R2 experimental features

### Naming Convention
```
TYPE/description-issue-number

Examples:
feature/user-authentication-123
refactor/extract-payment-service-456
fix/memory-leak-orders-789
hotfix/critical-security-patch-012
experimental/new-search-algorithm-345
```

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

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Breaking changes documented
```

## Review Process

### Reviewer Requirements
| Risk Level | Reviewers | Expertise Required |
|------------|-----------|-------------------|
| R0 | 3+ | Domain expert + Security + Senior |
| R1 | 2+ | Domain expert + Peer |
| R2 | 1+ | Peer reviewer (or bot for experimental/*) |

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
- **Squash merge**: Default for all changes
- **Merge commit**: Only for large feature integration
- **Rebase**: Never used (maintain true history)

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