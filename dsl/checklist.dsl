claude_dsl:
  version: "0.3"
  
  components:
    checklists:
      professional_behavior:
        - "Asked clarifying questions instead of assuming?"
        - "Admitted when I didn't know something?"
        - "Reported problems early with solutions?"
        - "Took ownership of issues?"
        - "Balanced perfectionism with delivery?"
      work_process:
        - "Clarified requirements obsessively?"
        - "Assessed risk level first?"
        - "Defined success criteria upfront?"
        - "Thought about failure modes?"
        - "Validated before requesting feedback?"
      classification:
        - "Read required additional files?"
        - "Followed appropriate process for task type?"
      development_specific:
        - "All validation requirements executed"
        - "Actual functionality tested (not just logs)"
        - "UI follows Design System (if applicable)"
        - "Security requirements verified"
        - "Code quality gates passed"
        - "Ask permission before committing any files"
      final:
        - "Did I follow every principle like my job depends on it?"
    
    error_states:
      skip_checklist: "If you skip this checklist = You failed the task"