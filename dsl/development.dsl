variables:
  validation_order:
    - "run_unit_tests_if_available"
    - "verify_startup_success"
    - "test_end_to_end_user_experience"
    - "verify_critical_paths_manually"
    - "test_api_with_real_requests"
  execution_steps:
    - "Load validation rules from validation-rules/"
    - "Load application type definitions from app-types.dsl"
    - "Identify target application type and architecture"
    - "Execute appropriate validation sequence"
    - "Document results and evidence"
  required_artifacts_list:
    - "Startup confirmation logs"
    - "Working application demonstration"
    - "Test execution logs"
  completion_criteria_list:
    - "All validation steps executed"
    - "No critical failures detected"
    - "validation_passed = true"

components:
  validation_principles:
    critical: "Server startup logs ≠ Working application"
  
  validation_execution:
    rules: "${variables.validation_order}"
    requirements:
      all_must_complete: "${variables.validation_order}"
      failure_response:
        action: "IMMEDIATE_HALT"
        message: "Task FAILED. Missing validation steps detected."
    basic_validation:
      rules:
        - "Test actual user experience"
        - "Verify critical paths manually"
        - "Test API with real requests"
    load_on_execution:
      - "validation-rules/index.dsl"
    execution_flow: "${variables.execution_steps}"
  
  security_verification_process:
    load_external_rules: "security-rules/index.dsl"
    mandatory: true
    execution_order:
      - "Load security requirements from security-rules/"
      - "Execute security validation steps"
      - "Verify all critical and high priority requirements"
      - "Run security test cases"
      - "Document security validation results"
        
  completion_requirements:
    required_artifacts: "${variables.required_artifacts_list}"
    completion_criteria: "${variables.completion_criteria_list}"
  
  development_checklist:
    - "All validation requirements executed?"
    - "Actual functionality tested?"
    - "UI follows Design System?"
    - "Security requirements verified (security-rules/)?"
    - "Code quality gates passed?"
    - "Asked permission before committing?"
  
  commit_rule: "NEVER commit without permission"

flow:
  - action: load_external
    files:
      - "behavior-rules/index.dsl"
  
  - action: load_all
    targets:
      - components.validation_execution
  
  - action: load_on_demand
    condition: "requires_risk_assessment"
    files:
      - "risk-assessment.dsl"
  
  - action: load_on_demand
    condition: "requires_app_type_detection"
    files:
      - "app-types.dsl"
  
  - action: load_on_demand
    condition: "requires_code_quality"
    files:
      - "coding-rules/index.dsl"
  
  - action: load_on_demand
    condition: "has_ui_components"
    files:
      - "design-rules/index.dsl"
  
  - action: load_on_demand
    condition: "requires_git_operations"
    files:
      - "git-rules/index.dsl"
  
  - action: remind
    with:
      critical: "${components.validation_principles.critical}"
      rule: "${components.commit_rule}"
  
  - action: append_checklist
    target: components.development_checklist
  
