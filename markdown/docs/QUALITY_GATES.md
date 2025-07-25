# Quality Gates

## Pre-commit Gates

### Mandatory Checks

- **Formatting**: Code formatting standards enforced
- **Linting**: Static analysis with zero tolerance for errors/warnings
- **Type checking**: Full type safety verification
- **Security linting**: Basic security rule enforcement
- **Unit tests**: Fast test suite execution (<30 seconds)

### Fast Feedback Loop

- Local pre-commit hooks block commits on failures
- Incremental checks focus on changed files only
- Cache previous results for unchanged code

## Static Analysis Standards

### Zero Tolerance Policy

- **0 errors**: No exceptions for any risk level
- **0 warnings**: Clean code standard across codebase
- **Security vulnerabilities**: Block on any new issues

### Analysis Categories

- **Code quality**: Complexity, maintainability, duplication
- **Security**: OWASP rules, injection vulnerabilities, data exposure
- **Performance**: Inefficient algorithms, memory leaks
- **Maintainability**: Code smells, architectural violations

## Security Scanning & Requirements

### Universal Security Requirements (All Applications)

#### Critical Security Requirements
- **Input Validation**:
  - Validate all external inputs
  - Implement proper data type checking
  - Handle null/undefined values safely
  - Prevent injection attacks through input sanitization

- **Error Handling**:
  - Never expose sensitive information in error messages
  - Log security events appropriately
  - Fail securely (default deny)
  - Implement proper exception handling

- **Authentication & Authorization**:
  - Implement proper authentication (if applicable)
  - Enforce authorization checks
  - Secure credential storage
  - Session management security

#### High Priority Security Requirements
- **Data Protection**:
  - Encrypt sensitive data at rest
  - Secure data transmission
  - Implement proper key management
  - Follow data privacy regulations

- **Logging & Monitoring**:
  - Log security-relevant events
  - Protect log integrity
  - Monitor for security incidents
  - Implement audit trails

### Application-Type Specific Security

#### Web Applications
- **Critical**: Prohibit innerHTML usage, Configure CSP, Set security headers, Disable directory listing
- **High**: Implement CORS properly, Force HTTPS, Validate form inputs, Rate limiting
- **Medium**: Secure cookie flags, CSRF protection, File upload validation

#### API Services
- **Critical**: Proper authentication, Validate API inputs, Prevent SQL injection, Rate limiting
- **High**: Proper CORS, API versioning security, Secure documentation, Input/output validation
- **Medium**: API monitoring/logging, Secure API keys

#### CLI Applications
- **Critical**: Validate command line arguments, Prevent command injection, Secure file paths
- **High**: Proper exit codes, Secure temporary files, Validate config files
- **Medium**: Security event logging, Handle signals properly

#### Mobile Applications
- **Critical**: Secure local storage, Validate user inputs, Secure network communication
- **High**: Certificate pinning, Secure biometric auth, Platform permissions
- **Medium**: Tampering detection, Secure backup handling

### Architecture-Specific Security

#### Microservices
- Service mesh security, Inter-service authentication, API gateway security, Container security

#### Monolithic
- Internal component isolation, Database connection security, Session management

#### Serverless
- Function isolation, Event source validation, Cold start security, Resource limits

#### Event-Driven
- Event validation, Message queue security, Event ordering integrity, Publisher/subscriber auth

### Static Application Security Testing (SAST)

- Source code vulnerability scanning
- Data flow analysis for injection attacks
- Cryptographic best practices verification
- Authentication and authorization checks

### Dynamic Application Security Testing (DAST)

- Runtime vulnerability scanning
- API security testing
- Input validation testing
- Session management verification

### Dependency Management

- Vulnerability scanning for all dependencies
- License compliance checking
- Outdated dependency alerts
- Supply chain security validation

## Monitoring & Logging Standards

### Log Levels & Guidelines
- **ERROR**: System errors, exceptions, failures
- **WARN**: Degraded performance, retry situations
- **INFO**: Important business events
- **DEBUG**: Detailed diagnostic information
- **TRACE**: Very detailed diagnostic information

### Required Log Fields
- **timestamp**: ISO 8601 format
- **level**: Log level (ERROR, WARN, INFO, DEBUG, TRACE)
- **message**: Human readable message
- **context**: Relevant context information
- **trace_id**: Distributed tracing identifier

### Sensitive Data Protection
- **Never log**: passwords, tokens, credit cards
- **Mask PII data**: Personal identifiable information
- **Structured logging**: JSON format required

### Metrics Collection
- **Business Metrics**: User actions, transaction success/failure, feature usage
- **Technical Metrics**: Response times, error rates, resource usage, queue depths
- **Web Vitals**: FCP <1.8s, LCP <2.5s, FID <100ms, CLS <0.1
- **Naming Convention**: service.component.metric (e.g., api.auth.login_attempts)

### Alerting Rules
- **P0 (Immediate)**: Service down, data loss, security breach, payment failures
- **P1 (1 hour)**: Degraded performance, high error rates, approaching limits
- **P2 (24 hours)**: Non-critical issues
- **P3 (Next sprint)**: Maintenance items

### Alert Content Requirements
- Clear problem description
- Impact assessment
- Runbook link
- Recent changes noted

## Performance Gates

### Response Time Targets

- **R0**: p95 <= 200ms, p99 <= 500ms
- **R1**: p95 <= 500ms, p99 <= 1000ms
- **R2**: Basic monitoring, no strict SLA

### Resource Utilization

- **Memory**: No memory leaks, efficient allocation
- **CPU**: Reasonable computational complexity
- **I/O**: Optimized database queries and API calls

### Scalability Requirements

- **R0**: Load tested to 10x expected traffic
- **R1**: Load tested to 2x expected traffic
- **R2**: Manual capacity planning

## Regulatory Compliance

### Data Protection

- **GDPR**: Personal data handling verification
- **PCI DSS**: Payment data security standards
- **SOX**: Financial data audit trails
- **HIPAA**: Healthcare data protection (if applicable)

### Automated Scanning

- Data classification and labeling
- Privacy impact assessment
- Audit trail verification
- Access control validation

## Business Validation Gates

### R0 Changes

- **Stakeholder sign-off**: Business owner approval required
- **Impact assessment**: Revenue/performance quantification
- **Rollback plan**: Detailed reversion procedures
- **Monitoring setup**: Business KPI tracking

### Documentation Requirements

- **Architecture Decision Records**: For significant design changes
- **Runbook updates**: Operational procedure changes
- **API documentation**: Public interface modifications
- **Security reviews**: Threat model updates
