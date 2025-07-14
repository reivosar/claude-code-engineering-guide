# Claude Code Engineering Guide

Mission-critical software development framework with risk-aware excellence and pragmatic engineering principles.

## Overview

This repository provides a comprehensive engineering framework for building production-ready software with Claude Code. It balances strict quality standards with practical development velocity through risk-stratified processes.

## Key Features

- 🎯 **Risk-Aware Excellence**: R0/R1/R2 classification for appropriate quality gates
- 👤 **Super Engineer Mindset**: Mission-critical approach with sustainable practices  
- 🏗️ **Pragmatic Architecture**: OO Exercise rules with sensible exceptions
- 🔒 **Security-First**: SAST/DAST, regulatory compliance, zero-trust principles
- 📊 **Business-Aligned**: Quantified impact assessment and ROI tracking
- 🚀 **Scalable Processes**: From experimental features to production-critical systems
- 🔄 **Maintainable Documentation**: Structured separation with context efficiency

## Quick Start

1. **Copy core configuration**:
   ```bash
   cp CLAUDE.md your-project/
   ```

2. **Optional: Copy detailed guidelines**:
   ```bash
   cp -r docs/ your-project/
   ```

3. **Customize for your stack**: Update tool references and team structure

4. **Start building**: Claude Code will automatically load CLAUDE.md

## Documentation Structure

### Core Framework
- **[CLAUDE.md](CLAUDE.md)**: Essential principles, risk framework, and process overview
- **Automatic loading**: Claude Code reads this automatically for context

### Detailed Implementation Guides
- **[docs/CODE_STYLE.md](docs/CODE_STYLE.md)**: OO Exercise rules with examples and exceptions
- **[docs/TESTING.md](docs/TESTING.md)**: Risk-stratified testing requirements and procedures
- **[docs/QUALITY_GATES.md](docs/QUALITY_GATES.md)**: Static analysis, security scans, performance targets
- **[docs/REPO_FLOW.md](docs/REPO_FLOW.md)**: Branch strategy, PR templates, review processes

## Risk Classification System

| Risk Level | Use Cases | Requirements |
|------------|-----------|--------------|
| **R0 (Mission-Critical)** | Payment systems, security features | 100% coverage, 3+ reviewers, stakeholder approval |
| **R1 (Important)** | Core business logic, user features | 95% coverage, 2+ reviewers, performance testing |
| **R2 (Experimental)** | A/B tests, research features | 90% coverage, 1 reviewer, basic validation |

## Engineering Principles

### Work Process
- **Requirements clarity first**: Ask "what exactly should this do?" until crystal clear
- **Risk assessment**: Classify every change appropriately 
- **Fail fast, report early**: Surface problems immediately with solutions
- **Business impact quantification**: Connect technical decisions to business value

### Quality Standards
- **Zero-tolerance static analysis**: 0 errors, 0 warnings across all risk levels
- **Differential coverage**: Apply standards to changed code when touching legacy
- **Security-first**: SAST/DAST scanning, regulatory compliance verification
- **Performance targets**: Risk-appropriate SLA/SLI monitoring

### Pragmatic Exceptions
- **Large refactors**: ADR approval process for >400 LOC changes
- **Legacy integration**: Differential coverage rules for gradual improvement
- **Hotfix workflows**: Bypass full coverage for critical production fixes

## For Teams

### Developer Experience
- **Fast feedback**: Pre-commit hooks catch issues early
- **Clear ownership**: Front-matter metadata defines maintainers
- **Flexible processes**: Risk-appropriate requirements prevent over-engineering

### Business Alignment
- **Impact quantification**: PR templates require business justification
- **ROI tracking**: Performance improvements linked to revenue impact
- **Stakeholder validation**: R0 changes require business owner sign-off

## Contributing

We welcome improvements to this engineering framework:

1. **For principle changes**: Open an issue for discussion first
2. **For implementation details**: Submit PR to relevant docs/ file
3. **For new patterns**: Include risk assessment and business justification

### Contribution Process
```bash
git checkout -b improvement/your-change
# Make focused changes with clear business value
git commit -m "TYPE: Brief description with impact assessment"
# Follow our own PR template and review process
```

## License

MIT License - see [LICENSE](LICENSE) for details.

## Related Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Anthropic Engineering Blog](https://www.anthropic.com/engineering)
- [Object-Oriented Exercise Rules](https://williamdurand.fr/2013/06/03/object-calisthenics/)

---

**Mission**: Sustainable engineering excellence through pragmatic standards and risk-aware processes.