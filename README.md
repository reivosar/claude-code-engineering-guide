# Claude Code Engineering Guide

Streamlined engineering framework optimized for token efficiency and pragmatic excellence.

## Two Versions Available

This repository provides the same engineering guide in two different formats:

### [Markdown Version](markdown/)
- **Traditional Markdown format**
- Works directly with Claude Code
- Natural language readability
- Load only what you need

### [DSL Version](dsl/)  
- **Claude DSL v0.3 format**
- Up to 84.6% token reduction
- Structured definitions
- Conditional logic and flow control

## Which Should You Choose?

| Use Case | Recommended | Reason |
|----------|-------------|--------|
| Mostly simple tasks | Markdown | Minimal token usage |
| Mostly development tasks | DSL | Massive token reduction |
| Claude Code beginners | Markdown | Simple setup |
| Advanced control needed | DSL | Structured conditionals |

## Performance Comparison

### File Count & Lines
| Format | File Count | Total Lines | Change |
|--------|------------|-------------|--------|
| Markdown | 9 files | 591 lines | Baseline |
| DSL | 5 files | 398 lines | **33% reduction** |

### Token Usage

#### Non-Development Tasks
| Format | Token Count | Change |
|--------|-------------|--------|
| Markdown | ~484 tokens | Baseline |
| DSL | ~160 tokens | **67% reduction** |

#### Development Tasks
| Format | Token Count | Change |
|--------|-------------|--------|
| Markdown | ~5,518 tokens | Baseline |
| DSL | ~510 tokens | **90.8% reduction** |

### Key Differences

| Feature | Markdown Version | DSL Version |
|---------|------------------|-------------|
| **Claude Code Support** | ✅ Auto-loaded | ✅ Auto-loaded |
| **Setup** | Copy files only | Copy files only |
| **Readability** | High (natural language) | Structured (learning curve) |
| **Maintainability** | Distributed file management | Single DSL management |
| **Extensibility** | Markdown editing | YAML structure editing |
| **Conditional Logic** | Human judgment dependent | DSL automated processing |
| **Variables** | ❌ Not supported | ✅ Supported (risk levels, etc.) |
| **Token Efficiency** | Standard | Improved for development tasks |

## Quick Start

### Markdown Version
```bash
cp markdown/CLAUDE.md your-project/
cp -r markdown/docs/ your-project/
```

### DSL Version
1. See [dsl/README.md](dsl/README.md) for usage instructions
2. Load DSL at session start

## License

MIT License - see [LICENSE](LICENSE) for details.