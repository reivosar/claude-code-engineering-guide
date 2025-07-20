claude_dsl:
  version: "0.3"
  variables:
    validation_order:
      - "run_unit_tests_if_available"
      - "verify_startup_success"
      - "test_end_to_end_user_experience"
      - "verify_critical_paths_manually"
      - "test_api_with_real_requests"
    execution_steps:
      - "Load validation rules from validation-rules.dsl"
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
    work_process:
      clarify_requirements:
        rule: "Ask 'what exactly?' until crystal clear"
      assess_risk:
        rule: "Classify as R0/R1/R2"
      define_success:
        rule: "Business metrics, performance targets"
      think_failure_modes:
        rule: "How can this break production?"
      validate_before_feedback:
        rule: "Code compiles, tests pass, works correctly"
    
    validation_rules: "${variables.validation_order}"
    
    mandatory_validation:
      halt_condition: "validation_passed = false"
      enforcement: "STRICT - No exceptions"
      definition: "Development task = Implementation + All validations passed"
      user_report_rule: "NO user reporting until validation_passed = true"
      
    validation_requirements:
      all_must_complete: "${variables.validation_order}"
      
      failure_response:
        action: "IMMEDIATE_HALT"
        message: "Task FAILED. Missing validation steps detected."
        
    validation_execution:
      load_external_rules: "validation-rules.dsl"
      load_app_types: "app-types.dsl"
      
      execution_flow: "${variables.execution_steps}"
          
    post_validation:
      required_artifacts: "${variables.required_artifacts_list}"
      
      completion_criteria: "${variables.completion_criteria_list}"
    
    validation:
      critical: "Server startup logs ≠ Working application"
      rules:
        - "Test actual user experience"
        - "Verify critical paths manually"
        - "Test API with real requests"
    
    code_style:
      - "Readability > Cleverness"
      - "Cyclomatic complexity ≤10"
      - "Functions ≤50 lines"
      - "Single responsibility"
      - "Test-driven mindset"
    
    testing:
      R0: { coverage: "100%", mutation: "95%" }
      R1: { coverage: "95%", mutation: "90%" }
      R2: { coverage: "90%", mutation: "80%" }
    
    ui_ux:
      system: "Digital Agency Design System"
      rules:
        - "Use official components only"
        - "NO CUSTOM CSS"
        - "WCAG 2.1 AA required"
    
    dev_checklist:
      - "All validation requirements executed?"
      - "Actual functionality tested?"
      - "UI follows Design System?"
      - "Security requirements verified?"
      - "Code quality gates passed?"
      - "Asked permission before committing?"
    
    commit_rule: "NEVER commit without permission"
  
  flow:
    - action: load_all
      targets:
        - components.work_process
        - components.validation
        - components.code_style
        - components.testing
        - components.ui_ux
    
    - action: load_external
      files:
        - "validation-rules.dsl"
        - "app-types.dsl"
    
    - action: remind
      with:
        critical: "${components.validation.critical}"
        rule: "${components.commit_rule}"
    
    - action: append_checklist
      target: components.dev_checklist