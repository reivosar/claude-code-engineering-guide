variables:
  log_levels: [
    ERROR,
    WARN,
    INFO,
    DEBUG,
    TRACE
  ]
  
  metrics_types: [
    counter,
    gauge,
    histogram,
    summary
  ]
  
  alert_priorities:
    P0: Immediate action required
    P1: Action within 1 hour
    P2: Action within 24 hours
    P3: Review in next sprint

components:
  logging_standards:
    levels: "${variables.log_levels}"
    
    guidelines:
      ERROR: System errors, exceptions, failures
      WARN: Degraded performance, retry situations
      INFO: Important business events
      DEBUG: Detailed diagnostic information
      TRACE: Very detailed diagnostic information
    
    format:
      required_fields:
        - timestamp
        - level
        - message
        - context
        - trace_id
      
      structured: JSON format required
    
    sensitive_data: [
      never log passwords,
      never log tokens,
      mask PII data,
      redact credit cards
    ]
  
  metrics_collection:
    types: "${variables.metrics_types}"
    
    business_metrics: [
      user actions,
      transaction success/failure,
      feature usage,
      performance metrics
    ]
    
    technical_metrics: [
      response times,
      error rates,
      resource usage,
      queue depths,
      Web Vitals (FCP LCP FID CLS - see design-rules/ui-ux-standards.dsl for targets)
    ]
    
    naming_convention:
      format: service.component.metric
      examples: [
        api.auth.login_attempts,
        db.users.query_time
      ]
  
  alerting_rules:
    priorities: "${variables.alert_priorities}"
    
    P0_criteria: [
      service completely down,
      data loss occurring,
      security breach,
      payment failures
    ]
    
    P1_criteria: [
      degraded performance,
      high error rates,
      approaching limits
    ]
    
    alert_content: [
      clear problem description,
      impact assessment,
      runbook link,
      recent changes noted
    ]
  
  observability_stack:
    components:
      logging: Centralized log aggregation
      metrics: Time-series database
      tracing: Distributed tracing
      alerting: Alert management platform
    
    dashboards: [
      service health overview,
      business metrics,
      technical metrics,
      error tracking
    ]