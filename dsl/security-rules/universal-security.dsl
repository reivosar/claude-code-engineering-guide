universal_security_requirements:
  critical:
    input_validation: [
      validate all external inputs,
      implement proper data type checking,
      handle null/undefined values safely,
      prevent injection attacks through input sanitization
    ]
    
    error_handling: [
      never expose sensitive information in error messages,
      log security events appropriately (see coding-rules/monitoring-logging.dsl for log levels),
      fail securely (default deny),
      implement proper exception handling
    ]
    
    authentication_authorization: [
      implement proper authentication (if applicable),
      enforce authorization checks,
      secure credential storage,
      session management security
    ]
  
  high:
    data_protection: [
      encrypt sensitive data at rest,
      secure data transmission,
      implement proper key management,
      follow data privacy regulations
    ]
    
    logging_monitoring: [
      log security-relevant events (see coding-rules/monitoring-logging.dsl for standards),
      protect log integrity,
      monitor for security incidents,
      implement audit trails
    ]