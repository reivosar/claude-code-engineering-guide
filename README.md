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
- 37.4% token reduction vs Markdown
- Most efficient syntax
- Structured definitions

### [YAML Version](yaml/)
- **Standard YAML format**
- 27.8% token reduction vs Markdown
- Clean, structured syntax
- Industry-standard format

## Which Should You Choose?

| Use Case | Recommended | Reason |
|----------|-------------|--------|
| Maximum token efficiency | DSL | 37.4% token reduction |
| Industry standard preference | YAML | Standard format, 27.8% reduction |
| Simple setup & readability | Markdown | Natural language, baseline |
| Claude Code beginners | Markdown | Easiest to understand |
| Structured config preference | YAML | Clean syntax, wide support |

## Performance Comparison

### File Count & Lines
| Format | File Count | Total Lines | Change |
|--------|------------|-------------|--------|
| Markdown | 10 files | 1,264 lines | Baseline |
| DSL | 30 files | 1,573 lines | **Modular structure** |
| YAML | 30 files | 1,473 lines | **Efficient modular** |

### Token Usage

#### All Tasks (Full Framework Load)
| Format | Token Count | Change |
|--------|-------------|--------|
| Markdown | ~7,041 tokens | Baseline |
| YAML | ~5,084 tokens | **27.8% reduction** |
| DSL | ~4,404 tokens | **37.4% reduction** |

**Note**: All versions load their complete frameworks. DSL achieves best efficiency through syntax optimization.

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
| **Token Efficiency** | Baseline (7,041 tokens) | **Best (4,404 tokens)** | Good (5,084 tokens) |
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