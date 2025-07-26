components:
  architecture_security:
    monolithic: [
      internal component isolation,
      database connection security,
      session management,
      single point of failure mitigation
    ]
    
    microservices: [
      service mesh security,
      inter-service authentication,
      API gateway security,
      service discovery security,
      container security
    ]
    
    serverless: [
      function isolation,
      event source validation,
      cold start security,
      resource limit enforcement,
      vendor lock-in considerations
    ]
    
    event_driven: [
      event validation,
      message queue security,
      event ordering integrity,
      publisher/subscriber authentication,
      event replay protection
    ]