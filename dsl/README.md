# Claude Code Engineering Guide - DSL Version

Structured engineering guide in Claude DSL v0.3 format

## Usage

### Method 1: Split DSL (Recommended)

1. **At session start, instruct**:
   ```
   Follow this Claude DSL v0.3:
   [Copy claude-core.dsl content here]
   ```

2. **For development tasks, additionally**:
   ```
   For development tasks, also load this DSL:
   [Copy claude-development.dsl content here]
   ```

### Method 2: Unified DSL

1. **At session start, instruct**:
   ```
   Follow this Claude DSL v0.3:
   [Copy claude-engineering-guide.dsl content here]
   ```

## File Structure

### Split Version (Recommended)
- `claude-core.dsl` - Core functionality (61 lines, ~400 tokens)
- `claude-development.dsl` - Development-specific (69 lines, ~450 tokens)

### Unified Version
- `claude-engineering-guide.dsl` - Full functionality (354 lines, ~2,832 tokens)

## Token Efficiency

| Task Type | Markdown | Split DSL | Unified DSL | Reduction |
|-----------|----------|-----------|-------------|-----------|
| Non-dev | 484 | 400 | 2,832 | 17% reduction |
| Development | 5,518 | 850 | 2,832 | 84.6% reduction |

## Benefits

- **Massive token reduction** (up to 84.6%)
- **Structured definitions** (variables, components, rules)
- **Conditional logic and flow control**
- **Single file management**