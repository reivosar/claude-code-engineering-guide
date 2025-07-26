variables:
  design_system: Digital Agency Design System
  accessibility_standard: WCAG 2.1 AA
  supported_browsers: [
    Chrome (latest 2),
    Firefox (latest 2),
    Safari (latest 2),
    Edge (latest 2)
  ]
  
  breakpoints:
    mobile: 320
    tablet: 768
    desktop: 1024
    wide: 1440

components:
  design_system_compliance:
    system: "${variables.design_system}"
    rules: [
      use official components only,
      NO CUSTOM CSS without approval,
      follow design tokens strictly,
      maintain consistent spacing
    ]
    
    exceptions:
      process: Document and get approval
      criteria: Business critical requirement
  
  accessibility_requirements:
    standard: "${variables.accessibility_standard}"
    mandatory: [
      keyboard navigation support,
      screen reader compatibility,
      color contrast compliance,
      focus indicators visible,
      alt text for images,
      ARIA labels where needed
    ]
    
    testing: [
      automated accessibility scans (see coding-rules/testing-strategy.dsl for accessibility tests),
      manual keyboard testing,
      screen reader testing
    ]
  
  responsive_design:
    breakpoints: "${variables.breakpoints}"
    principles: [
      mobile-first approach,
      fluid typography,
      flexible images,
      progressive enhancement
    ]
    
    testing_requirements: [
      test all breakpoints,
      test orientation changes,
      test touch interactions
    ]
  
  performance_standards:
    metrics:
      FCP: < 1.8s
      LCP: < 2.5s
      FID: < 100ms
      CLS: < 0.1
    note: These metrics should be monitored via coding-rules/monitoring-logging.dsl
    
    optimization: [
      lazy load images,
      code split by route,
      minimize bundle size,
      cache static assets
    ]