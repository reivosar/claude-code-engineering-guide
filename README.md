# Claude Code Engineering Guide

Streamlined engineering framework optimized for token efficiency and pragmatic excellence.

## Overview

This repository provides a modular engineering framework for building production-ready software with Claude Code. It dramatically reduces context window usage (75% token reduction) while maintaining strict professional standards.

## Key Features

- 🎯 **Token-Optimized**: 33-line core framework (6,000→1,500 tokens for non-dev tasks)
- 🔄 **Modular Documentation**: Read only what you need, when you need it
- 👤 **Professional Principles**: Mission-critical mindset with sustainable practices
- 🏗️ **Risk-Aware Excellence**: R0/R1/R2 classification for appropriate quality gates
- ⚡ **Enforced Validation**: Mandatory checklists prevent shortcuts
- 📋 **Task Classification**: Automatic routing to development vs non-development workflows

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

4. **Start building**: Claude Code automatically loads CLAUDE.md (33 lines vs 122)

## Documentation Structure

### Core Framework (Always Read)
- **[CLAUDE.md](CLAUDE.md)**: Universal principles and mandatory workflow (33 lines)
- **[docs/CHECKLIST.md](docs/CHECKLIST.md)**: Task completion verification (26 lines)

### Development-Specific (Read Only for Dev Tasks)
- **[docs/DEVELOPMENT.md](docs/DEVELOPMENT.md)**: Coding standards, UI/UX, security requirements (83 lines)
- **[docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)**: When stuck guidance (7 lines)

## Workflow

**Every Task**: CLAUDE.md → Work → CHECKLIST.md

1. **Start**: Read CLAUDE.md (professional principles + task classification)
2. **Development Tasks**: Also read docs/DEVELOPMENT.md 
3. **Work**: Apply appropriate standards
4. **Complete**: Verify with docs/CHECKLIST.md

## Token Efficiency

| Task Type | Old Framework | New Framework | Savings |
|-----------|---------------|---------------|---------|
| Non-Development | ~6,000 tokens | ~1,500 tokens | **75%** |
| Development | ~6,000 tokens | ~4,500 tokens | **25%** |

## Professional Principles

- **Ask clarifying questions BEFORE coding**: Never assume requirements
- **Admit when you don't know**: Research instead of guessing
- **Validate before requesting feedback**: Code compiles, tests pass, functionality works
- **Risk-aware classification**: R0/R1/R2 for appropriate quality gates
- **Business impact focus**: Quantify technical decisions

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

**Mission**: Token-efficient engineering excellence through modular documentation and enforced validation.