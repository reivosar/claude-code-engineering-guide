program_correctness_verification:
  principle: Verify program correctness at multiple levels based on application architecture
  
  syntactic_correctness:
    requirement: Code compiles/runs without errors
    verify: No compilation errors, runtime startup successful
    methods: [
      build process completes successfully,
      application starts without crashes,
      no syntax or import errors
    ]
  
  functional_correctness:
    requirement: Application behaves according to specifications
    verify: Core features work as intended
    methods: [
      execute primary user workflows,
      verify expected outputs for given inputs,
      test edge cases and error conditions (see coding-rules/testing-strategy.dsl)
    ]
  
  integration_correctness:
    requirement: Components integrate properly
    verify: System components communicate correctly
    methods: [
      API endpoints respond correctly,
      database operations succeed,
      external service connections work,
      authentication/authorization functions
    ]
  
  practical_correctness:
    requirement: Application provides real-world value
    verify: End-to-end user scenarios complete successfully
    methods: [
      complete realistic usage scenarios,
      verify business logic implementation,
      test with realistic data volumes,
      confirm performance under normal load
    ]