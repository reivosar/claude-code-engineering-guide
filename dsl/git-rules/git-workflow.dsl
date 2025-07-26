variables:
  branch_prefixes:
    feature: feature/
    bugfix: bugfix/
    hotfix: hotfix/
    release: release/
    chore: chore/
  
  commit_types: [
    feat: new feature,
    fix: bug fix,
    docs: documentation,
    style: formatting,
    refactor: code restructuring,
    test: test updates,
    chore: maintenance
  ]

components:
  branch_strategy:
    naming: "${variables.branch_prefixes}"
    rules: [
      branch from main/master,
      use descriptive names,
      include ticket number if applicable,
      keep branches short-lived
    ]
    
    examples: [
      feature/add-user-authentication,
      bugfix/fix-login-redirect,
      hotfix/patch-security-vulnerability
    ]
  
  commit_standards:
    format: <type>(<scope>): <subject>
    types: "${variables.commit_types}"
    rules: [
      use imperative mood,
      keep subject line under 72 chars,
      explain WHY in body if needed,
      reference issues/tickets
    ]
    
    body_format: |
      <subject>
      
      <body - explain WHY not WHAT>
      
      Closes #<issue>
  
  pr_requirements:
    description: [
      summary of changes,
      testing approach,
      screenshots if UI changes,
      breaking changes noted
    ]
    
    checklist: [
      tests pass,
      code reviewed,
      documentation updated,
      no console errors
    ]
  
  merge_strategy:
    default: squash and merge
    exceptions: [
      feature branches: merge commit,
      release branches: merge commit
    ]
    
    rules: [
      require PR approval,
      pass all CI checks,
      update from main before merge
    ]