variables:
  log_levels:
    - ERROR
    - WARN
    - INFO
    - DEBUG
    - TRACE
  
  metrics_types:
    - counter
    - gauge
    - histogram
    - summary
  
  alert_priorities:
    P0: "Immediate action required"
    P1: "Action within 1 hour"
    P2: "Action within 24 hours"
    P3: "Review in next sprint"

components:
  logging_standards:
    levels: "${variables.log_levels}"
    
    guidelines:
      ERROR: "System errors, exceptions, failures"
      WARN: "Degraded performance, retry situations"
      INFO: "Important business events"
      DEBUG: "Detailed diagnostic information"
      TRACE: "Very detailed diagnostic information"
    
    format:
      required_fields:
        - timestamp
        - level
        - message
        - context
        - trace_id
      
      structured: "JSON format required"
    
    sensitive_data:
      - "Never log passwords"
      - "Never log tokens"
      - "Mask PII data"
      - "Redact credit cards"
  
  metrics_collection:
    types: "${variables.metrics_types}"
    
    business_metrics:
      - "User actions"
      - "Transaction success/failure"
      - "Feature usage"
      - "Performance metrics"
    
    technical_metrics:
      - "Response times"
      - "Error rates"
      - "Resource usage"
      - "Queue depths"
      - "Web Vitals (FCP, LCP, FID, CLS - see design-rules/ui-ux-standards.dsl for targets)"
    
    naming_convention:
      format: "service.component.metric"
      examples:
        - "api.auth.login_attempts"
        - "db.users.query_time"
  
  alerting_rules:
    priorities: "${variables.alert_priorities}"
    
    P0_criteria:
      - "Service completely down"
      - "Data loss occurring"
      - "Security breach"
      - "Payment failures"
    
    P1_criteria:
      - "Degraded performance"
      - "High error rates"
      - "Approaching limits"
    
    alert_content:
      - "Clear problem description"
      - "Impact assessment"
      - "Runbook link"
      - "Recent changes noted"
  
  observability_stack:
    components:
      logging: "Centralized log aggregation"
      metrics: "Time-series database"
      tracing: "Distributed tracing"
      alerting: "Alert management platform"
    
    dashboards:
      - "Service health overview"
      - "Business metrics"
      - "Technical metrics"
      - "Error tracking"