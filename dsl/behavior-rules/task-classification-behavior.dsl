task_type_detection:
  development_task_indicators:
    - "code implementation"
    - "feature development"
    - "bug fixing"
    - "refactoring"
    - "testing"
    - "deployment"
  
  non_development_indicators:
    - "explanation requests"
    - "documentation reading"
    - "planning discussions"
    - "architecture discussions"
  
  classification_behavior:
    rule: "Automatically classify task type and load appropriate rules"
    conditions:
      development: "Load development.dsl and all validation rules"
      non_development: "Load basic interaction rules only"

conditional_loading_behavior:
  triggers:
    requires_risk_assessment: "Task involves production changes"
    requires_app_type_detection: "Task involves application development"
    requires_code_quality: "Task involves code changes"
    has_ui_components: "Task involves UI/UX work"
    requires_git_operations: "Task involves version control"
  
  loading_strategy:
    lazy_loading: "Load rules only when needed"
    cache_rules: "Keep loaded rules in memory during session"
    unload_unused: "Free memory from unused rules"