# Configuration Guide

## Design System Configuration

### Current Default
- **Design System**: Digital Agency Design System (https://design.digital.go.jp/)
- **Accessibility Standard**: WCAG 2.1 AA
- **Performance Targets**: FCP <1.8s, LCP <2.5s, FID <100ms, CLS <0.1

### Changing Design Systems

When business requirements demand using a different design system:

1. **Update Project Configuration**
   - Create/update `design-system.config.js` or equivalent
   - Set new design system variables:
   ```javascript
   module.exports = {
     designSystem: "New Design System Name",
     designSystemUrl: "https://example.com/design-system",
     accessibilityStandard: "WCAG 2.1 AA", // or new standard
     breakpoints: {
       mobile: 320,
       tablet: 768,
       desktop: 1024,
       wide: 1440
     }
   };
   ```

2. **Update Component References**
   - Replace design system component imports
   - Update CSS/styling references
   - Modify color tokens and spacing values

3. **Validate Compatibility**
   - Ensure new design system meets accessibility requirements
   - Verify performance targets are maintained
   - Test responsive design at all breakpoints

4. **Documentation**
   - Document reason for change
   - Update development guidelines
   - Notify team members of new standards

## Task-Based Loading Strategy

### Core Files (Always Load)
- `CLAUDE.md` - Entry point and mandatory rules
- `docs/DEVELOPMENT.md` - For development tasks

### Conditional Loading by Task Type

#### Simple Tasks
**Load**: Basic checklist only
- `docs/CHECKLIST.md`

#### Development Tasks  
**Load**: Full development stack
- `docs/DEVELOPMENT.md`
- `docs/CODE_STYLE.md`
- `docs/TESTING.md`
- `docs/QUALITY_GATES.md`
- `docs/REPO_FLOW.md`

#### Debugging/Troubleshooting
**Additional Load**:
- `docs/TROUBLESHOOTING.md`

#### Security-Critical Tasks
**Additional Load**:
- Security sections in `docs/QUALITY_GATES.md`
- Enhanced validation in `docs/CHECKLIST.md`

### Loading Optimization

#### For Token Efficiency
1. **Assess task complexity first**
2. **Load only required documentation**
3. **Reference other files when needed**
4. **Use file summaries in main files**

#### File Loading Priority
1. **High Priority**: CLAUDE.md, DEVELOPMENT.md, CHECKLIST.md
2. **Medium Priority**: CODE_STYLE.md, TESTING.md, QUALITY_GATES.md  
3. **Low Priority**: REPO_FLOW.md, TROUBLESHOOTING.md

## Environment Variables Support

### Configuration Files
Create project-specific configuration files for environment-dependent settings:

#### `claude-config.json`
```json
{
  "designSystem": "${DESIGN_SYSTEM:-Digital Agency Design System}",
  "environment": "${NODE_ENV:-development}",
  "securityLevel": "${SECURITY_LEVEL:-standard}",
  "performanceTargets": {
    "fcp": "${FCP_TARGET:-1800}",
    "lcp": "${LCP_TARGET:-2500}",
    "fid": "${FID_TARGET:-100}",
    "cls": "${CLS_TARGET:-0.1}"
  }
}
```

#### Environment Variables
```bash
# Design System Configuration
DESIGN_SYSTEM="Custom Design System"
DESIGN_SYSTEM_URL="https://custom.design.system"

# Performance Targets
FCP_TARGET=1500
LCP_TARGET=2000
FID_TARGET=80
CLS_TARGET=0.05

# Security Configuration
SECURITY_LEVEL=high
COMPLIANCE_REQUIREMENTS="GDPR,PCI"
```

### Usage in Development
1. **Load configuration at session start**
2. **Apply environment-specific settings**
3. **Override defaults with environment values**
4. **Validate configuration before proceeding**

## Modular Usage Patterns

### Pattern 1: Minimal Load
```markdown
For simple tasks:
1. Read CLAUDE.md
2. Execute task
3. Check CHECKLIST.md
```

### Pattern 2: Development Load
```markdown
For development tasks:
1. Read CLAUDE.md
2. Read DEVELOPMENT.md (includes references to other files)
3. Load specific files as needed:
   - CODE_STYLE.md for code quality
   - TESTING.md for test requirements  
   - QUALITY_GATES.md for security/performance
4. Execute CHECKLIST.md
```

### Pattern 3: Conditional Load
```markdown
Based on task requirements:
- Security-critical: Include all security sections
- Performance-critical: Include performance standards
- UI/UX work: Include design system configuration
- Debugging: Include TROUBLESHOOTING.md
```

## Customization Guidelines

### Project-Specific Overrides
Create project-specific override files:
- `project/CODE_STYLE_OVERRIDES.md`
- `project/TESTING_OVERRIDES.md`
- `project/SECURITY_OVERRIDES.md`

### Team Configuration
Adjust standards for team preferences:
- Code complexity limits
- Test coverage thresholds
- Review requirements
- Performance targets

### Compliance Configuration
For regulated environments:
- Enhanced security requirements
- Audit trail requirements
- Documentation standards
- Review processes