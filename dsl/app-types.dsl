application type specific validation:
  web application:
    startup: Server starts and serves content
    ui: Frontend loads and displays correctly
    api: Backend endpoints respond properly
    integration: Frontend-backend communication works
    
  cli application:
    execution: Command runs with various arguments
    output: Produces correct output format
    error handling: Handles invalid inputs gracefully
    integration: Integrates with system environment
    
  desktop application:
    startup: Application launches successfully
    ui: Interface renders and responds
    file operations: File I/O operations work
    integration: OS integration functions correctly
    
  api service:
    endpoints: All endpoints respond correctly
    data processing: Request/response handling works
    authentication: Auth mechanisms function
    integration: Database and external service connections
    
  library package:
    interface: Public API functions work as documented
    behavior: Functions return expected results
    error handling: Exceptions handled appropriately
    integration: Works in target environments
    
  mobile application:
    startup: App launches on target platform
    ui: Interface adapts to screen sizes
    platform features: Device-specific features work
    integration: Platform APIs function correctly
    
  microservice:
    startup: Service starts and registers
    endpoints: All endpoints respond correctly
    communication: Inter-service communication works
    integration: Service mesh integration functions
    
  batch processing:
    execution: Batch jobs run to completion
    data processing: Input data processed correctly
    output: Results written to expected destinations
    integration: Scheduler and monitoring integration

validation by architecture:
  monolithic: [
    Single application startup verification,
    Internal component integration,
    Database connectivity,
    End-to-end user flows
  ]
    
  microservices: [
    Individual service startup,
    Inter-service communication,
    API gateway functionality,
    Service discovery,
    Load balancing
  ]
    
  serverless: [
    Function deployment verification,
    Event trigger functionality,
    Resource provisioning,
    Integration with cloud services
  ]
    
  event driven: [
    Event publisher functionality,
    Event consumer processing,
    Message queue integration,
    Event ordering and delivery
  ]