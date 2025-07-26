variables:
  complexity_limits:
    cyclomatic: 10
    cognitive: 15
    depth: 4
  
  function_limits:
    lines: 50
    parameters: 5
    return_points: 3
  
  file_limits:
    lines: 500
    imports: 20
    exports: 10

components:
  readability_rules:
    principle: Readability > Cleverness
    naming: [
      use descriptive names,
      avoid abbreviations,
      use consistent naming conventions
    ]
    
    comments: [
      document WHY not WHAT,
      keep comments up-to-date,
      remove commented-out code
    ]
  
  complexity_rules:
    cyclomatic: "≤${variables.complexity_limits.cyclomatic}"
    cognitive: "≤${variables.complexity_limits.cognitive}"
    nesting: "≤${variables.complexity_limits.depth} levels"
  
  function_rules:
    size: "≤${variables.function_limits.lines} lines"
    parameters: "≤${variables.function_limits.parameters}"
    responsibility: Single responsibility principle
    side_effects: Minimize side effects
  
  file_organization:
    structure: [
      imports at top,
      constants after imports,
      types/interfaces next,
      main logic follows,
      exports at bottom
    ]
    
    size: "≤${variables.file_limits.lines} lines per file"
  
  error_handling: [
    Always handle errors explicitly,
    Use specific error types,
    Provide meaningful error messages,
    Log errors appropriately (see coding-rules/monitoring-logging.dsl for log levels)
  ]