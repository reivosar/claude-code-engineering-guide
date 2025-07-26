components:
  security_validation_by_type:
    web_application:
      tests: [
        XSS vulnerability testing (extends coding-rules/testing-strategy.dsl security tests),
        directory traversal testing,
        CSRF token validation,
        security header verification
      ]
    
    cli_application:
      tests: [
        command injection testing (extends coding-rules/testing-strategy.dsl security tests),
        path traversal testing,
        privilege escalation testing
      ]
    
    api_service:
      tests: [
        SQL injection testing (extends coding-rules/testing-strategy.dsl security tests),
        authentication bypass testing,
        rate limiting verification,
        input validation testing
      ]
  
  mandatory_security_verification:
    halt_condition: validation_passed = false
    enforcement: STRICT - Immediate halt on security validation failure
    
    type_specific_requirements:
      rule: Load security requirements based on detected application type
      universal_requirements: Always apply universal security requirements
      
    completion_criteria: [
      Universal Critical requirements: 100% satisfied,
      Type-specific Critical requirements: 100% satisfied,
      Universal + Type-specific High requirements: 100% satisfied,
      Type-specific Medium requirements: 80% or more satisfied,
      All applicable security tests: Pass,
      validation_passed = true
    ]