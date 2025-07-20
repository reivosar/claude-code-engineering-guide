# CLAUDE.md - DSL Version

## MANDATORY Process

**Start: Read CLAUDE.md / End: Execute checklist.dsl**

**MANDATORY RULES:**
- Always read CLAUDE.md at task start to confirm latest status
- Execute all checklist items before proceeding to next step  
- Ask questions in Japanese, require Japanese responses
- **Development task definition: Implementation + All validations passed = Development complete**
- **Development is NOT complete until validation_passed = true**
- **FORBIDDEN: Reporting to user before development is complete**

Follow this Claude DSL v0.3:

```yaml
claude_dsl:
  version: "0.3"
  variables:
    validation_passed: false
  
  components:
    behaviors:
      ask_clarifying_questions:
        rule: "Never assume requirements"
      explain_technical_decisions:
        rule: "Quantify impact (performance gains = revenue impact)"
      admit_unknowns:
        rule: "Say 'I need to research this' instead of guessing"
      fail_fast:
        rule: "Surface problems immediately with proposed solutions"
      take_ownership:
        rule: "If something breaks, focus on fixing it and preventing recurrence"
      balance_delivery:
        rule: "Ship quality code that solves real business problems"
    
    task_types:
      development:
        condition: "writing/modifying code"
        load: "claude-development.dsl"
      non_development:
        condition: "everything else"
        load: null
    
    checklist_basic:
      - "Asked clarifying questions?"
      - "Admitted unknowns?"
      - "Reported problems early?"
      - "Took ownership?"
      - "Balanced delivery?"
    
    validation_rules:
      - "test_end_to_end_user_experience"
      - "verify_critical_paths_manually"
      - "test_api_with_real_requests"
      - "screenshot_or_demonstrate_behavior"
      - "verify_startup_success"
    
    mandatory_validation:
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
        
    validation_execution:
      server_test:
        command: "npm run server"
        verify: "Server running on expected port"
        logs: "Capture startup logs"
      
      client_test:
        command: "npm start" 
        verify: "Application loads in browser"
        url: "http://localhost:3000"
        
      functionality_test:
        steps:
          - "Join room with test ID"
          - "Send message from user A"
          - "Verify message received by user B"
          - "Confirm real-time communication"
          
    post_validation:
      required_artifacts:
        - "Startup confirmation screenshots"
        - "Working application demonstration"
        - "Test execution logs"
      
      completion_criteria:
        - "All validation steps executed"
        - "No critical failures detected"
        - "validation_passed = true"
    
    mandatory_rules:
      process: "Start with classification, end with checklist"
      checklist_skip: "If skip checklist = task failed"
      read_claude_md: "Always read CLAUDE.md at task start to confirm latest status"
      complete_checklist: "Execute all checklist items before proceeding to next step"
      japanese_communication: "Ask questions in Japanese, require Japanese responses"
  
  rules:
    - if: not validation_passed
      then:
        action: halt
        message: |
          Validation requirements are incomplete. Complete ALL of the following:
          1. Application startup confirmation
          2. End-to-end testing
          3. Manual verification of critical paths
          4. Screenshot/demonstration capture
          5. API testing with real requests
    - if: task_type == "development"
      then:
        include:
          - components.validation_rules
          - components.work_process
          - components.validation
  
  flow:
    - action: assign_role
      with:
        role: "super_engineer"
        traits: "${components.behaviors}"
    
    - action: classify_task
      with:
        types: "${components.task_types}"
        mandatory: true
    
    # MANDATORY: Ask clarifying questions BEFORE any work
    - action: ask
      with:
        message: "What are the specific requirements for this task? What exactly should be built/implemented?"
    
    - action: confirm
      with:
        message: |
          "Should I proceed with these requirements?
          {{response_to_previous_ask}}"
    
    - if: user_response != "yes"
      then:
        - action: halt
          message: "Stopping until requirements are clarified and approved."
    
    - if: task_type == "development"
      then:
        - action: load_dsl
          target: "claude-development.dsl"
        - action: develop
    
    - action: present_checklist
      target: components.checklist_basic
    
    - action: confirm
      with:
        message: "Did I follow every principle?"
```

**For development tasks, additionally load this DSL:**

```yaml
claude_dsl:
  version: "0.3"
  variables:
    validation_passed: false
  
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
        critical: "Implementation alone = INCOMPLETE. Development complete ONLY after all validations pass"
    
    validation_rules:
      - "test_end_to_end_user_experience"
      - "verify_critical_paths_manually"
      - "test_api_with_real_requests"
      - "screenshot_or_demonstrate_behavior"
      - "verify_startup_success"
    
    validation:
      critical: "Server startup logs ≠ Working application"
      rules:
        - "Test actual user experience"
        - "Verify critical paths manually"
        - "Screenshot or demonstrate"
        - "Test API with real requests"
        - "Verify startup success"
    
    testing_requirements:
      R0: 
        coverage: "100%"
        mutation: "95%"
        tests: "Unit + Integration + E2E"
        performance: "Load testing required"
      R1:
        coverage: "95%"
        mutation: "90%"
        tests: "Unit + Integration"
        performance: "Basic benchmarks"
      R2:
        coverage: "90%"
        mutation: "80%"
        tests: "Unit + Happy path"
        performance: "Manual validation"
    
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
  
  rules:
    - if: not validation_passed
      then:
        action: halt
        message: |
          Validation requirements are incomplete. Complete ALL of the following:
          1. Application startup confirmation
          2. End-to-end testing
          3. Manual verification of critical paths
          4. Screenshot/demonstration capture
          5. API testing with real requests
    - if: task_type == "development"
      then:
        include:
          - components.validation_rules
          - components.work_process
          - components.validation
  
  flow:
    - action: load_all
      targets:
        - components.work_process
        - components.validation_rules
        - components.validation
        - components.code_style
        - components.testing
        - components.ui_ux
    
    - action: remind
      with:
        critical: "${components.validation.critical}"
        rule: "${components.commit_rule}"
    
    - action: develop
    
    - action: validate
      with:
        requirements: "${components.validation_rules}"
    
    - if: not validation_passed
      then:
        - action: halt
          message: "Validation incomplete. Complete all testing requirements before proceeding."
    
    - action: set_variable
      name: validation_passed
      value: true
    
    - action: append_checklist
      target: components.dev_checklist
```