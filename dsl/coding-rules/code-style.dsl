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
    principle: "Readability > Cleverness"
    naming:
      - "Use descriptive names"
      - "Avoid abbreviations"
      - "Use consistent naming conventions"
    
    comments:
      - "Document WHY, not WHAT"
      - "Keep comments up-to-date"
      - "Remove commented-out code"
  
  complexity_rules:
    cyclomatic: "≤${variables.complexity_limits.cyclomatic}"
    cognitive: "≤${variables.complexity_limits.cognitive}"
    nesting: "≤${variables.complexity_limits.depth} levels"
  
  function_rules:
    size: "≤${variables.function_limits.lines} lines"
    parameters: "≤${variables.function_limits.parameters}"
    responsibility: "Single responsibility principle"
    side_effects: "Minimize side effects"
  
  file_organization:
    structure:
      - "Imports at top"
      - "Constants after imports"
      - "Types/Interfaces next"
      - "Main logic follows"
      - "Exports at bottom"
    
    size: "≤${variables.file_limits.lines} lines per file"
  
  error_handling:
    - "Always handle errors explicitly"
    - "Use specific error types"
    - "Provide meaningful error messages"
    - "Log errors appropriately (see coding-rules/monitoring-logging.dsl for log levels)"