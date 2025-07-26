components:
  mandatory_verification_steps:
    - "Identify application type and architecture"
    - "Execute syntactic correctness checks"
    - "Perform functional correctness validation"
    - "Test integration correctness"
    - "Verify practical correctness with real scenarios"
    - "Document verification results with evidence"
  
  validation_requirements:
    all_must_complete:
      - "run_unit_tests_if_available"
      - "verify_startup_success"
      - "test_end_to_end_user_experience"
      - "verify_critical_paths_manually"
      - "test_api_with_real_requests"
    
    failure_response:
      action: "IMMEDIATE_HALT"
      message: "Task FAILED. Missing validation steps detected."