components:
  validation_enforcement:
    halt_condition: "validation_passed = false"
    enforcement: "STRICT - No exceptions"
    definition: "Development task = Implementation + All validations passed"
    user_report_rule: "NO user reporting until validation_passed = true"
      
  post_validation:
    required_artifacts:
      - "Startup confirmation screenshots"
      - "Working application demonstration"
      - "Test execution logs"
    
    completion_criteria:
      - "All validation steps executed"
      - "No critical failures detected"
      - "validation_passed = true"