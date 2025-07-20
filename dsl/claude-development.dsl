claude_dsl:
  version: "0.3"
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
    
    validation:
      critical: "Server startup logs ≠ Working application"
      rules:
        - "Test actual user experience"
        - "Verify critical paths manually"
        - "Screenshot or demonstrate"
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