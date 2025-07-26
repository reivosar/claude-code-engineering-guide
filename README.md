# Claude Code Engineering Guide

Streamlined engineering framework optimized for token efficiency and pragmatic excellence.

## Three Versions Available

This repository provides the same engineering guide in three different formats:

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

### [YAML Version](yaml/)
- **Standard YAML format**
- Clean, structured syntax
- Better token efficiency than DSL
- Industry-standard format

## Which Should You Choose?

| Use Case | Recommended | Reason |
|----------|-------------|--------|
| Mostly simple tasks | Markdown | Minimal token usage |
| Development tasks (structured) | YAML | Clean syntax, efficient |
| Development tasks (advanced) | DSL | Conditional logic, flow control |
| Claude Code beginners | Markdown | Simple setup |
| Industry standard preference | YAML | Standard format, wide support |

## Performance Comparison

### File Count & Lines
| Format | File Count | Total Lines | Change |
|--------|------------|-------------|--------|
| Markdown | 9 files | 591 lines | Baseline |
| DSL | 30 files | 1,489 lines | **Modular structure** |
| YAML | 30 files | ~1,200 lines | **Efficient modular** |

### Token Usage

#### Non-Development Tasks
| Format | Token Count | Change |
|--------|-------------|--------|
| Markdown | ~484 tokens | Baseline |
| DSL | ~160 tokens | **67% reduction** |
| YAML | ~140 tokens | **71% reduction** |

#### Development Tasks
| Format | Token Count | Change |
|--------|-------------|--------|
| Markdown | ~5,518 tokens | Baseline |
| DSL | ~510 tokens | **90.8% reduction** |
| YAML | ~420 tokens | **92.4% reduction** |

### Key Differences

| Feature | Markdown Version | DSL Version | YAML Version |
|---------|------------------|-------------|-------------|
| **Claude Code Support** | ✅ Auto-loaded | ✅ Auto-loaded | ✅ Auto-loaded |
| **Setup** | Copy files only | Copy files only | Copy files only |
| **Readability** | High (natural language) | Structured (learning curve) | High (clean syntax) |
| **Maintainability** | Distributed file management | Modular DSL management | Standard YAML editing |
| **Extensibility** | Markdown editing | DSL structure editing | YAML structure editing |
| **Conditional Logic** | Human judgment dependent | DSL automated processing | Standard YAML processing |
| **Variables** | ❌ Not supported | ✅ Supported (risk levels, etc.) | ✅ Supported (standard format) |
| **Token Efficiency** | Standard | Improved for development tasks | **Best for development tasks** |
| **Industry Standard** | ❌ Documentation format | ❌ Custom format | ✅ Widely supported |

## Quick Start

### Markdown Version
```bash
cp markdown/CLAUDE.md your-project/
cp -r markdown/docs/ your-project/
```

### DSL Version
1. See [dsl/README.md](dsl/README.md) for usage instructions
2. Load DSL at session start

### YAML Version
1. See [yaml/README.md](yaml/README.md) for usage instructions
2. Load entry-point.yml at session start

## License

MIT License - see [LICENSE](LICENSE) for details.