components:
  application_type_security:
    web_application:
      critical: [
        prohibit innerHTML usage (use DOM manipulation),
        configure Content-Security-Policy,
        disable directory listing,
        prohibit access outside document root,
        set security headers (X-Frame-Options X-XSS-Protection)
      ]
      high: [
        implement CORS properly,
        force HTTPS in production,
        validate all form inputs,
        implement rate limiting
      ]
      medium: [
        set secure cookie flags,
        implement CSRF protection,
        validate file uploads
      ]
    
    cli_application:
      critical: [
        validate command line arguments,
        prevent command injection,
        secure file path handling,
        validate environment variables
      ]
      high: [
        implement proper exit codes,
        secure temporary file usage,
        validate configuration files
      ]
      medium: [
        implement logging for security events,
        handle signals properly
      ]
    
    desktop_application:
      critical: [
        validate all file operations,
        prevent path traversal attacks,
        secure inter-process communication,
        validate user inputs in GUI
      ]
      high: [
        implement secure update mechanisms,
        protect local data storage,
        validate external file formats
      ]
      medium: [
        implement application signing,
        secure network communications
      ]
    
    api_service:
      critical: [
        implement proper authentication,
        validate all API inputs,
        prevent SQL injection,
        rate limiting implementation
      ]
      high: [
        implement proper CORS,
        API versioning security,
        secure API documentation,
        input/output validation
      ]
      medium: [
        API monitoring and logging,
        implement API keys securely
      ]
    
    library_package:
      critical: [
        validate all public API inputs,
        prevent code injection in dynamic features,
        secure dependency management,
        memory safety (if applicable)
      ]
      high: [
        implement secure defaults,
        validate configuration options,
        thread safety considerations
      ]
      medium: [
        document security assumptions,
        implement security testing
      ]
    
    mobile_application:
      critical: [
        secure local data storage,
        validate all user inputs,
        secure network communications,
        protect against reverse engineering
      ]
      high: [
        implement certificate pinning,
        secure biometric authentication,
        platform permission handling
      ]
      medium: [
        application tampering detection,
        secure backup handling
      ]
    
    microservice:
      critical: [
        secure service-to-service communication,
        implement proper authentication,
        validate all API inputs,
        network segmentation
      ]
      high: [
        service mesh security,
        container security,
        secrets management
      ]
      medium: [
        distributed tracing security,
        load balancer security
      ]
    
    batch_processing:
      critical: [
        validate input data files,
        secure file processing,
        prevent injection in data processing,
        secure output file handling
      ]
      high: [
        implement job authentication,
        secure data transformation,
        error handling in batch jobs
      ]
      medium: [
        audit batch operations,
        monitor resource usage
      ]