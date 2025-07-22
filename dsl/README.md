# Claude Code Engineering Guide - DSL Version

> 📝 **記事記載**: この内容は「[CLAUDE.mdにDSLを導入してみた](ブログURL)」で詳しく解説しています。Claude Codeのエンジニアリングガイドを従来のMarkdown形式からYAMLベースのDSL（Domain Specific Language）に変換し、最大90.8%のトークン削減を実現した取り組みです。

Structured engineering guide in Claude DSL v0.3 format

## Usage

### Method 1: Main DSL (Recommended)

1. **At session start, instruct**:
   ```
   Follow entry-point.dsl for complete DSL execution.
   ```

### Method 2: Split DSL (Advanced)

1. **At session start, instruct**:
   ```
   Follow this Claude DSL v0.3:
   [entry-point.dsl content]
   ```

2. **For development tasks, additionally**:
   ```
   For development tasks, also load this DSL:
   [development.dsl content]
   ```

### Method 3: Unified DSL

1. **At session start, instruct**:
   ```
   Follow this Claude DSL v0.3:
   [validation-rules.dsl content]
   ```

## File Structure

### Main DSL (Recommended)
- `CLAUDE.md` - Entry point with mandatory rules (15 lines, ~80 tokens)
- `entry-point.dsl` - Main DSL execution logic (94 lines, ~400 tokens)

### Split Version (Advanced)
- `development.dsl` - Development-specific (119 lines, ~350 tokens)
- `checklist.dsl` - Shared checklists (31 lines, ~170 tokens)
- `validation-rules.dsl` - Program correctness validation (63 lines, ~280 tokens)
- `app-types.dsl` - Application type definitions (62 lines, ~270 tokens)


## Token Efficiency

| Task Type | Markdown | Main DSL | Split DSL | Unified DSL | Best Reduction |
|-----------|----------|----------|-----------|-------------|----------------|
| Non-dev | 374 | 629 | 293 | 1,353 | 21.7% (Split) |
| Development | 3,764 | 1,508 | 1,341 | 1,353 | 64.4% (Split) |

*All calculations include actual file content tokens (word count × 1.25)

## Processing Flow

See [FLOW.md](FLOW.md) for detailed processing flow diagrams and explanations.

## Benefits

- **Significant token reduction** (up to 64.4% for development tasks)
- **Structured definitions** (variables, components, rules)
- **Conditional logic and flow control**
- **Modular file management** with selective loading
- **AI-optimized format** for improved parsing efficiency