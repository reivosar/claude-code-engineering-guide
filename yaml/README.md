# Claude Code Engineering Guide - YAML Version

Modular engineering framework in Claude YAML v0.3 format with category-specific rule organization.

## Quick Start

### Simple Method (Recommended)
```
Follow entry-point.yml for complete YAML execution.
```

### Advanced Method (Full Control)
```
Follow this Claude YAML v0.3:
[Copy entry-point.yml content here]
```

## Architecture Overview

The YAML system uses a **modular architecture** with category-specific directories for better organization and maintainability:

```
yaml/
├── entry-point.yml          # Main orchestrator
├── development.yml          # Development workflow
├── CLAUDE.md               # Session entry point
├── behavior-rules/         # Claude's operational behaviors
├── coding-rules/           # Code quality and standards
├── design-rules/           # UI/UX and documentation
├── git-rules/              # Git workflow operations
├── security-rules/         # Security requirements
└── validation-rules/       # Correctness verification
```

## File Structure Details

### Core Files (Always Loaded)
- **`CLAUDE.md`** (15 lines) - Mandatory session entry point
- **`entry-point.yml`** (94 lines) - Main YAML orchestrator with component loading
- **`development.yml`** (119 lines) - Development workflow with conditional module loading

### Module Categories

#### behavior-rules/ (7 files, 312 lines)
Claude's operational behaviors and error handling:
- `communication-behavior.yml` - User interaction patterns
- `work-process-behavior.yml` - Task execution workflows
- `task-classification-behavior.yml` - Task type identification
- `failure-recovery-behavior.yml` - Error recovery strategies
- `unexpected-situation-behavior.yml` - Handling unforeseen events
- `debugging-analysis-behavior.yml` - Problem diagnosis methods
- `index.yml` - Module loader

#### coding-rules/ (4 files, 201 lines)
Code quality and development standards:
- `code-style.yml` - Readability, complexity, and organization rules
- `testing-strategy.yml` - Testing requirements and methodologies
- `monitoring-logging.yml` - Logging standards and metrics collection
- `index.yml` - Module loader

#### design-rules/ (3 files, 114 lines)
UI/UX standards and documentation:
- `ui-ux-standards.yml` - Design system compliance and accessibility
- `documentation.yml` - Documentation requirements and standards
- `index.yml` - Module loader

#### security-rules/ (5 files, 218 lines)
Comprehensive security requirements:
- `universal-security.yml` - Cross-cutting security requirements
- `application-security.yml` - App-specific security measures
- `architecture-security.yml` - System-level security design
- `security-validation.yml` - Security testing and verification
- `index.yml` - Module loader

#### validation-rules/ (4 files, 172 lines)
Correctness verification and validation:
- `correctness-verification.yml` - Code correctness checking
- `verification-process.yml` - Testing and validation workflows
- `validation-enforcement.yml` - Enforcement mechanisms
- `index.yml` - Module loader

#### git-rules/ (2 files, 54 lines)
Git workflow and operations:
- `git-workflow.yml` - Git operations and commit standards
- `index.yml` - Module loader

### Support Files
- **`checklist.yml`** (31 lines) - Final verification checklist
- **`app-types.yml`** (62 lines) - Application type definitions
- **`risk-assessment.yml`** (41 lines) - Risk evaluation framework

## Key Features

### 1. Conditional Loading
```yaml
action: load_on_demand
condition: "requires_code_quality"
files:
  - "coding-rules/index.yml"
```

### 2. Variable System
```yaml
variables:
  design_system: "Digital Agency Design System"
  validation_passed: false
```

### 3. Cross-References
Modules reference each other to eliminate duplication:
- Security rules reference logging standards from coding-rules
- Design rules reference monitoring from coding-rules
- All modules use unified validation variables

### 4. Hierarchical Index System
Each category has an `index.yml` that loads related files, enabling:
- Selective loading based on task requirements
- Clear dependency management
- Easier maintenance and updates

## Token Efficiency

### Current Statistics
| Metric | Count |
|--------|-------|
| **Total Files** | 30 YAML files |
| **Total Lines** | 1,489 lines |
| **Estimated Tokens** | ~1,800-2,400 tokens (full load) |

### Loading Strategies
| Strategy | Files Loaded | Estimated Tokens | Use Case |
|----------|--------------|------------------|----------|
| **Minimal** | entry-point.yml only | ~400 tokens | Simple tasks |
| **Conditional** | Based on task type | ~800-1,200 tokens | Development tasks |
| **Full Load** | All modules | ~2,400 tokens | Complex projects |

### Compared to Markdown Version
- **Markdown**: 9 files, 591 lines, ~740 tokens (always loaded)
- **YAML**: 30 files, 1,489 lines, **conditional loading** (400-2,400 tokens)

## Usage Patterns

### For Simple Tasks
```
Follow entry-point.yml for complete YAML execution.
```
→ Loads only core files (~400 tokens)

### For Development Projects
```
Follow entry-point.yml for complete YAML execution.
```
→ Conditionally loads relevant modules (~800-1,200 tokens)

### For Complex Security Projects
```
Follow entry-point.yml for complete YAML execution.
```
→ Loads all security and validation modules (~1,800 tokens)

## Benefits of Modular Architecture

### 1. **Maintainability**
- Clear separation of concerns
- Easy to update specific rule categories
- Consistent cross-references prevent duplication

### 2. **Performance**
- Load only what's needed for the task
- Reduced token usage for simple tasks
- Conditional loading based on requirements

### 3. **Extensibility**
- Add new rule categories easily
- Extend existing categories without affecting others
- Version consistency across all modules (v0.3)

### 4. **Clarity**
- Category-specific organization
- Clear file naming conventions
- Hierarchical index system for easy navigation

## Processing Flow

1. **Session Start**: Load `CLAUDE.md`
2. **YAML Execution**: Process `entry-point.yml`
3. **Task Analysis**: Determine required modules
4. **Conditional Loading**: Load relevant rule categories
5. **Cross-Reference Resolution**: Apply unified variables and references
6. **Execution**: Follow loaded rules and workflows

## Migration from Previous Versions

### From Single-File DSL
- Rules are now organized by category
- Variables are unified across modules
- Loading is now conditional and optimized

### From Markdown Version
- All functionality preserved
- Added structured conditional logic
- Significant token reduction for development tasks

## Advanced Configuration

### Custom Loading Patterns
Modify `development.yml` to customize which modules load for specific task types:

```yaml
action: load_on_demand
condition: "custom_condition"
files:
  - "custom-rules/index.yml"
```

### Variable Customization
Update variables in individual modules to customize behavior:
- Design system selection in `design-rules/ui-ux-standards.yml`
- Security standards in `security-rules/universal-security.yml`
- Code quality thresholds in `coding-rules/code-style.yml`

## Troubleshooting

### Common Issues
1. **Module Not Loading**: Check condition logic in `development.yml`
2. **Variable Conflicts**: Ensure variable names are consistent across modules
3. **Missing Cross-References**: Verify references point to correct module paths

### Debug Information
- All files use YAML version 0.3
- Variables use consistent naming: `validation_passed`, `design_system`
- Cross-references use relative paths: `coding-rules/monitoring-logging.yml`