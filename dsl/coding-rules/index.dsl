claude_dsl:
  version: "0.3"
  
  flow:
    - action: load_external
      files:
        - "coding-rules/code-style.dsl"
        - "coding-rules/testing-strategy.dsl"
        - "coding-rules/monitoring-logging.dsl"