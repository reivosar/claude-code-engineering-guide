---
risk-level: R0
maintainer: @qa-team
last-reviewed: 2025-07-14
purpose: Testing standards, coverage requirements, and performance testing procedures
---

# Testing Requirements

## Risk-Stratified Coverage

| Risk Level | Coverage | Mutation | Test Types | Performance |
|------------|----------|----------|------------|-------------|
| R0 (Mission-Critical) | 100% | 95% | Unit + Integration + E2E | Load testing required |
| R1 (Important) | 95% | 90% | Unit + Integration | Basic benchmarks |
| R2 (Experimental) | 90% | 80% | Unit + Happy path | Manual validation |

## Differential Coverage Rules

### Legacy Code Integration
- Coverage/Mutation thresholds apply **to changed lines only**
- Existing untested code doesn't block new feature delivery
- Gradual improvement strategy over time

### Hotfix Process
- Critical production fixes can bypass full coverage
- Requires post-fix cleanup and test addition
- Maximum 48-hour window for coverage completion

### Test Pyramid Strategy
- **Unit tests**: 70% of total tests
- **Integration tests**: 20% of total tests  
- **E2E tests**: 10% of total tests

## Performance Testing Standards

### R0 Requirements
- Load testing with realistic traffic patterns
- Stress testing at 2x expected peak load
- Endurance testing for 24+ hours
- Performance regression testing in CI

### R1 Requirements
- Basic load testing with expected traffic
- Performance benchmarks for critical paths
- Regression detection for major changes

### R2 Requirements
- Manual performance validation
- Basic monitoring and alerting setup

## Test Quality Gates

### Before Commit
- All tests passing at appropriate risk level
- No flaky tests (>95% pass rate over 10 runs)
- Performance tests within acceptable thresholds

### Mutation Testing
- Focus on critical business logic
- Exclude trivial getters/setters
- Target complex conditional logic and algorithms

## Test Organization

### Naming Conventions
- Test files: `*.test.ts` or `*.spec.ts`
- Test classes: `ClassNameTest`
- Test methods: `should_behave_when_condition`

### Test Structure
- **Arrange**: Set up test data and mocks
- **Act**: Execute the behavior under test
- **Assert**: Verify expected outcomes

### Mock Strategy
- Mock external dependencies
- Avoid mocking internal domain logic
- Use test doubles for slow or unreliable resources