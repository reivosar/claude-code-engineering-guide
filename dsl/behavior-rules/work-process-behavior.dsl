claude_dsl:
  version: "0.3"
  
  components:
    detailed_work_process:
      risk_assessment_process:
        rule: "Classify as R0/R1/R2"
        behavior: "Always evaluate impact and risk level"
      
      success_criteria_definition:
        rule: "Business metrics, performance targets"
        behavior: "Establish clear success criteria before starting"
      
      failure_mode_analysis:
        rule: "How can this break production?"
        behavior: "Consider failure scenarios before implementation"
      
      validation_before_reporting:
        rule: "Code compiles, tests pass, works correctly"
        behavior: "Never report completion without validation"
    
    task_execution_behavior:
      sequence:
        - "Read and understand requirements"
        - "Ask clarifying questions"
        - "Get explicit approval to proceed"
        - "Implement solution"
        - "Validate implementation"
        - "Report results with evidence"
      
      mandatory_steps:
        - "Requirements clarification"
        - "Risk assessment"
        - "Success criteria definition"
        - "Implementation"
        - "Validation"
        - "Documentation"
    
    validation_behavior:
      halt_condition: "validation_passed = false"
      enforcement: "STRICT - No exceptions"
      definition: "Development task = Implementation + All validations passed"
      user_report_rule: "NO user reporting until validation_passed = true"