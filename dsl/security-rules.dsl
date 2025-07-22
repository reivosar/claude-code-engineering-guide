claude_dsl:
  version: "0.3"
  
  components:
    universal_security_requirements:
      critical:
        input_validation:
          - "Validate all external inputs"
          - "Implement proper data type checking"
          - "Handle null/undefined values safely"
          - "Prevent injection attacks through input sanitization"
        
        error_handling:
          - "Never expose sensitive information in error messages"
          - "Log security events appropriately"
          - "Fail securely (default deny)"
          - "Implement proper exception handling"
        
        authentication_authorization:
          - "Implement proper authentication (if applicable)"
          - "Enforce authorization checks"
          - "Secure credential storage"
          - "Session management security"
      
      high:
        data_protection:
          - "Encrypt sensitive data at rest"
          - "Secure data transmission"
          - "Implement proper key management"
          - "Follow data privacy regulations"
        
        logging_monitoring:
          - "Log security-relevant events"
          - "Protect log integrity"
          - "Monitor for security incidents"
          - "Implement audit trails"
    
    application_type_security:
      web_application:
        critical:
          - "Prohibit innerHTML usage (use DOM manipulation)"
          - "Configure Content-Security-Policy"
          - "Disable directory listing"
          - "Prohibit access outside document root"
          - "Set security headers (X-Frame-Options, X-XSS-Protection)"
        high:
          - "Implement CORS properly"
          - "Force HTTPS in production"
          - "Validate all form inputs"
          - "Implement rate limiting"
        medium:
          - "Set secure cookie flags"
          - "Implement CSRF protection"
          - "Validate file uploads"
      
      cli_application:
        critical:
          - "Validate command line arguments"
          - "Prevent command injection"
          - "Secure file path handling"
          - "Validate environment variables"
        high:
          - "Implement proper exit codes"
          - "Secure temporary file usage"
          - "Validate configuration files"
        medium:
          - "Implement logging for security events"
          - "Handle signals properly"
      
      desktop_application:
        critical:
          - "Validate all file operations"
          - "Prevent path traversal attacks"
          - "Secure inter-process communication"
          - "Validate user inputs in GUI"
        high:
          - "Implement secure update mechanisms"
          - "Protect local data storage"
          - "Validate external file formats"
        medium:
          - "Implement application signing"
          - "Secure network communications"
      
      api_service:
        critical:
          - "Implement proper authentication"
          - "Validate all API inputs"
          - "Prevent SQL injection"
          - "Rate limiting implementation"
        high:
          - "Implement proper CORS"
          - "API versioning security"
          - "Secure API documentation"
          - "Input/output validation"
        medium:
          - "API monitoring and logging"
          - "Implement API keys securely"
      
      library_package:
        critical:
          - "Validate all public API inputs"
          - "Prevent code injection in dynamic features"
          - "Secure dependency management"
          - "Memory safety (if applicable)"
        high:
          - "Implement secure defaults"
          - "Validate configuration options"
          - "Thread safety considerations"
        medium:
          - "Document security assumptions"
          - "Implement security testing"
      
      mobile_application:
        critical:
          - "Secure local data storage"
          - "Validate all user inputs"
          - "Secure network communications"
          - "Protect against reverse engineering"
        high:
          - "Implement certificate pinning"
          - "Secure biometric authentication"
          - "Platform permission handling"
        medium:
          - "Application tampering detection"
          - "Secure backup handling"
      
      microservice:
        critical:
          - "Secure service-to-service communication"
          - "Implement proper authentication"
          - "Validate all API inputs"
          - "Network segmentation"
        high:
          - "Service mesh security"
          - "Container security"
          - "Secrets management"
        medium:
          - "Distributed tracing security"
          - "Load balancer security"
      
      batch_processing:
        critical:
          - "Validate input data files"
          - "Secure file processing"
          - "Prevent injection in data processing"
          - "Secure output file handling"
        high:
          - "Implement job authentication"
          - "Secure data transformation"
          - "Error handling in batch jobs"
        medium:
          - "Audit batch operations"
          - "Monitor resource usage"
    
    architecture_security:
      monolithic:
        - "Internal component isolation"
        - "Database connection security"
        - "Session management"
        - "Single point of failure mitigation"
      
      microservices:
        - "Service mesh security"
        - "Inter-service authentication"
        - "API gateway security"
        - "Service discovery security"
        - "Container security"
      
      serverless:
        - "Function isolation"
        - "Event source validation"
        - "Cold start security"
        - "Resource limit enforcement"
        - "Vendor lock-in considerations"
      
      event_driven:
        - "Event validation"
        - "Message queue security"
        - "Event ordering integrity"
        - "Publisher/subscriber authentication"
        - "Event replay protection"
    
    security_validation_by_type:
      web_application:
        tests:
          - "XSS vulnerability testing"
          - "Directory traversal testing"
          - "CSRF token validation"
          - "Security header verification"
      
      cli_application:
        tests:
          - "Command injection testing"
          - "Path traversal testing"
          - "Privilege escalation testing"
      
      api_service:
        tests:
          - "SQL injection testing"
          - "Authentication bypass testing"
          - "Rate limiting verification"
          - "Input validation testing"
    
    mandatory_security_verification:
      halt_condition: "security_validation_passed = false"
      enforcement: "STRICT - Immediate halt on security validation failure"
      
      type_specific_requirements:
        rule: "Load security requirements based on detected application type"
        universal_requirements: "Always apply universal security requirements"
        
      completion_criteria:
        - "Universal Critical requirements: 100% satisfied"
        - "Type-specific Critical requirements: 100% satisfied" 
        - "Universal + Type-specific High requirements: 100% satisfied"
        - "Type-specific Medium requirements: 80% or more satisfied"
        - "All applicable security tests: Pass"
        - "security_validation_passed = true"