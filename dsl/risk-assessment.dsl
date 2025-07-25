claude_dsl:
  version: "0.3"
  
  variables:
    risk_levels:
      R0:
        name: "Critical"
        description: "System failure affects entire business"
        examples:
          - "Payment processing"
          - "User authentication"
          - "Data integrity"
      
      R1:
        name: "High"
        description: "Feature failure affects user experience"
        examples:
          - "Core features"
          - "Data processing"
          - "API endpoints"
      
      R2:
        name: "Medium"
        description: "Feature failure has limited impact"
        examples:
          - "UI enhancements"
          - "Analytics"
          - "Non-critical features"
  
  components:
    risk_classification:
      questions:
        - "What happens if this fails in production?"
        - "How many users are affected?"
        - "Is there financial impact?"
        - "Is there data loss risk?"
        - "Is there security impact?"
      
      criteria:
        R0: "Business critical OR Financial impact OR Data loss"
        R1: "Core functionality OR Many users affected"
        R2: "Everything else"
    
    risk_mitigation:
      R0:
        testing: "Comprehensive test suite required"
        review: "Senior engineer review mandatory"
        monitoring: "Real-time alerts required"
        rollback: "Instant rollback plan required"
      
      R1:
        testing: "Full test coverage required"
        review: "Peer review required"
        monitoring: "Standard monitoring"
        rollback: "Rollback plan documented"
      
      R2:
        testing: "Standard test coverage"
        review: "Standard review process"
        monitoring: "Basic monitoring"
        rollback: "Standard deployment process"
    
    failure_analysis:
      required_questions:
        - "How can this break in production?"
        - "What are the failure modes?"
        - "What is the blast radius?"
        - "How do we detect failures?"
        - "How do we recover?"