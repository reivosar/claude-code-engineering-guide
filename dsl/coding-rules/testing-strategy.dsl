variables:
  coverage_targets:
    R0: { line: 100, branch: 100, mutation: 95 }
    R1: { line: 95, branch: 90, mutation: 90 }
    R2: { line: 90, branch: 85, mutation: 80 }
  
  test_types:
    - unit
    - integration
    - e2e
    - performance
    - security
    - accessibility

components:
  test_pyramid:
    unit_tests:
      proportion: 70%
      characteristics: [
        fast execution,
        isolated components,
        mock external dependencies
      ]
      requirements: [
        test edge cases,
        test error conditions,
        test happy path
      ]
    
    integration_tests:
      proportion: 20%
      characteristics: [
        test component interactions,
        use real dependencies when possible,
        verify data flow
      ]
    
    e2e_tests:
      proportion: 10%
      characteristics: [
        test critical user journeys,
        verify end-to-end functionality,
        run in production-like environment
      ]
  
  coverage_requirements:
    by_risk_level:
      R0: "${variables.coverage_targets.R0}"
      R1: "${variables.coverage_targets.R1}"
      R2: "${variables.coverage_targets.R2}"
    
    enforcement: [
      coverage must meet targets before merge,
      new code must not decrease coverage,
      mutation testing for critical paths
    ]
  
  test_quality:
    principles: [
      tests should be deterministic,
      tests should be independent,
      tests should be readable,
      tests should be maintainable
    ]
    
    anti_patterns: [
      avoid testing implementation details,
      avoid brittle selectors,
      avoid shared test state,
      avoid slow tests without reason
    ]