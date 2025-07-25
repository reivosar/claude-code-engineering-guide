claude_dsl:
  version: "0.3"
  
  flow:
    - action: load_external
      files:
        - "security-rules/universal-security.dsl"
        - "security-rules/application-security.dsl"
        - "security-rules/architecture-security.dsl"
        - "security-rules/security-validation.dsl"