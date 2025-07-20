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
- `claude-core.dsl` - Core functionality (59 lines, ~190 tokens)
- `claude-development.dsl` - Development-specific (67 lines, ~240 tokens)
- `checklist.dsl` - Shared checklists (31 lines, ~170 tokens)

### Unified Version
- `claude-engineering-guide.dsl` - Full functionality (326 lines, ~1,250 tokens)

## Token Efficiency

| Task Type | Markdown | Split DSL | Unified DSL | Reduction |
|-----------|----------|-----------|-------------|-----------|
| Non-dev | 484 | 190 | 1,250 | 60.7% reduction |
| Development | 5,518 | 430 | 1,250 | 92.2% reduction |

## Benefits

- **Massive token reduction** (up to 92.2%)
- **Structured definitions** (variables, components, rules)
- **Conditional logic and flow control**
- **Single file management**
- **Modular checklist system** with shared components