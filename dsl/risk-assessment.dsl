variables:
  risk_levels:
    R0:
      name: Critical
      description: System failure affects entire business
      examples: [
        payment processing,
        user authentication,
        data integrity
      ]
    
    R1:
      name: High
      description: Feature failure affects user experience
      examples: [
        core features,
        data processing,
        API endpoints
      ]
    
    R2:
      name: Medium
      description: Feature failure has limited impact
      examples: [
        UI enhancements,
        analytics,
        non-critical features
      ]

components:
  risk_classification:
    questions: [
      what happens if this fails in production,
      how many users are affected,
      is there financial impact,
      is there data loss risk,
      is there security impact
    ]
    
    criteria:
      R0: Business critical OR Financial impact OR Data loss
      R1: Core functionality OR Many users affected
      R2: Everything else
  
  risk_mitigation:
    R0:
      testing: Comprehensive test suite required
      review: Senior engineer review mandatory
      monitoring: Real-time alerts required
      rollback: Instant rollback plan required
    
    R1:
      testing: Full test coverage required
      review: Peer review required
      monitoring: Standard monitoring
      rollback: Rollback plan documented
    
    R2:
      testing: Standard test coverage
      review: Standard review process
      monitoring: Basic monitoring
      rollback: Standard deployment process
  
  failure_analysis:
    required_questions: [
      how can this break in production,
      what are the failure modes,
      what is the blast radius,
      how do we detect failures,
      how do we recover
    ]