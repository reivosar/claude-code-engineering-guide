claude_dsl:
  version: "0.3"
  
  components:
    program_correctness_verification:
      principle: "Verify program correctness at multiple levels based on application architecture"
      
      syntactic_correctness:
        requirement: "Code compiles/runs without errors"
        verify: "No compilation errors, runtime startup successful"
        methods:
          - "Build process completes successfully"
          - "Application starts without crashes"
          - "No syntax or import errors"
      
      functional_correctness:
        requirement: "Application behaves according to specifications"
        verify: "Core features work as intended"
        methods:
          - "Execute primary user workflows"
          - "Verify expected outputs for given inputs"
          - "Test edge cases and error conditions"
      
      integration_correctness:
        requirement: "Components integrate properly"
        verify: "System components communicate correctly"
        methods:
          - "API endpoints respond correctly"
          - "Database operations succeed"
          - "External service connections work"
          - "Authentication/authorization functions"
      
      practical_correctness:
        requirement: "Application provides real-world value"
        verify: "End-to-end user scenarios complete successfully"
        methods:
          - "Complete realistic usage scenarios"
          - "Verify business logic implementation"
          - "Test with realistic data volumes"
          - "Confirm performance under normal load"

    mandatory_verification_steps:
      - "Identify application type and architecture"
      - "Execute syntactic correctness checks"
      - "Perform functional correctness validation"
      - "Test integration correctness"
      - "Verify practical correctness with real scenarios"
      - "Document verification results with evidence"
    
    validation_enforcement:
      halt_condition: "validation_passed = false"
      enforcement: "STRICT - No exceptions"
      definition: "Development task = Implementation + All validations passed"
      user_report_rule: "NO user reporting until validation_passed = true"
      
    validation_requirements:
      all_must_complete:
        - server_startup_verification
        - client_startup_verification
        - end_to_end_functionality_test
        - critical_path_manual_verification
        - api_request_testing
        - screenshot_capture
      
      failure_response:
        action: "IMMEDIATE_HALT"
        message: "Task FAILED. Missing validation steps detected."
        
    post_validation:
      required_artifacts:
        - "Startup confirmation screenshots"
        - "Working application demonstration"
        - "Test execution logs"
      
      completion_criteria:
        - "All validation steps executed"
        - "No critical failures detected"
        - "validation_passed = true"