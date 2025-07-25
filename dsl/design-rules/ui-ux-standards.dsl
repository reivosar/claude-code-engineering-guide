claude_dsl:
  version: "0.3"
  
  variables:
    design_system: "Digital Agency Design System"
    accessibility_standard: "WCAG 2.1 AA"
    supported_browsers:
      - "Chrome (latest 2)"
      - "Firefox (latest 2)"
      - "Safari (latest 2)"
      - "Edge (latest 2)"
    
    breakpoints:
      mobile: 320
      tablet: 768
      desktop: 1024
      wide: 1440
  
  components:
    design_system_compliance:
      system: "${variables.design_system}"
      rules:
        - "Use official components only"
        - "NO CUSTOM CSS without approval"
        - "Follow design tokens strictly"
        - "Maintain consistent spacing"
      
      exceptions:
        process: "Document and get approval"
        criteria: "Business critical requirement"
    
    accessibility_requirements:
      standard: "${variables.accessibility_standard}"
      mandatory:
        - "Keyboard navigation support"
        - "Screen reader compatibility"
        - "Color contrast compliance"
        - "Focus indicators visible"
        - "Alt text for images"
        - "ARIA labels where needed"
      
      testing:
        - "Automated accessibility scans (see coding-rules/testing-strategy.dsl for accessibility tests)"
        - "Manual keyboard testing"
        - "Screen reader testing"
    
    responsive_design:
      breakpoints: "${variables.breakpoints}"
      principles:
        - "Mobile-first approach"
        - "Fluid typography"
        - "Flexible images"
        - "Progressive enhancement"
      
      testing_requirements:
        - "Test all breakpoints"
        - "Test orientation changes"
        - "Test touch interactions"
    
    performance_standards:
      metrics:
        FCP: "< 1.8s"
        LCP: "< 2.5s"
        FID: "< 100ms"
        CLS: "< 0.1"
      note: "These metrics should be monitored via coding-rules/monitoring-logging.dsl"
      
      optimization:
        - "Lazy load images"
        - "Code split by route"
        - "Minimize bundle size"
        - "Cache static assets"