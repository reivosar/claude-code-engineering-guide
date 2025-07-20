# Claude Code Engineering Guide - DSL Version

Structured engineering guide in Claude DSL v0.3 format

## Usage

### Method 1: Main DSL (Recommended)

1. **At session start, instruct**:
   ```
   Follow claude-main.dsl for complete DSL execution.
   ```

### Method 2: Split DSL (Advanced)

1. **At session start, instruct**:
   ```
   Follow this Claude DSL v0.3:
   [claude-core.dsl content]
   ```

2. **For development tasks, additionally**:
   ```
   For development tasks, also load this DSL:
   [claude-development.dsl content]
   ```

### Method 3: Unified DSL

1. **At session start, instruct**:
   ```
   Follow this Claude DSL v0.3:
   [claude-engineering-guide.dsl content]
   ```

## File Structure

### Main DSL (Recommended)
- `CLAUDE.md` - Entry point with mandatory rules (15 lines, ~80 tokens)
- `claude-main.dsl` - Main DSL execution logic (140 lines, ~600 tokens)

### Split Version (Advanced)
- `claude-core.dsl` - Core functionality (59 lines, ~190 tokens)
- `claude-development.dsl` - Development-specific (73 lines, ~240 tokens)
- `checklist.dsl` - Shared checklists (31 lines, ~170 tokens)
- `validation-rules.dsl` - Program correctness validation (63 lines, ~280 tokens)
- `app-types.dsl` - Application type definitions (62 lines, ~270 tokens)

### Unified Version
- `claude-engineering-guide.dsl` - Full functionality (326 lines, ~1,250 tokens)

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