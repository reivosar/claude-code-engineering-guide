# Claude Code Engineering Guide - DSL Version

Modular engineering framework in Claude DSL v0.3 format with category-specific rule organization.

## Quick Start

### Simple Method (Recommended)
```
Follow entry-point.dsl for complete DSL execution.
```

### Advanced Method (Full Control)
```
Follow this Claude DSL v0.3:
[Copy entry-point.dsl content here]
```

## Architecture Overview

The DSL system uses a **modular architecture** with category-specific directories for better organization and maintainability:

```
dsl/
├── entry-point.dsl          # Main orchestrator
├── development.dsl          # Development workflow
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
- **`entry-point.dsl`** (94 lines) - Main DSL orchestrator with component loading
- **`development.dsl`** (119 lines) - Development workflow with conditional module loading

### Module Categories

#### behavior-rules/ (7 files, 312 lines)
Claude's operational behaviors and error handling:
- `communication-behavior.dsl` - User interaction patterns
- `work-process-behavior.dsl` - Task execution workflows
- `task-classification-behavior.dsl` - Task type identification
- `failure-recovery-behavior.dsl` - Error recovery strategies
- `unexpected-situation-behavior.dsl` - Handling unforeseen events
- `debugging-analysis-behavior.dsl` - Problem diagnosis methods
- `index.dsl` - Module loader

#### coding-rules/ (4 files, 201 lines)
Code quality and development standards:
- `code-style.dsl` - Readability, complexity, and organization rules
- `testing-strategy.dsl` - Testing requirements and methodologies
- `monitoring-logging.dsl` - Logging standards and metrics collection
- `index.dsl` - Module loader

#### design-rules/ (3 files, 114 lines)
UI/UX standards and documentation:
- `ui-ux-standards.dsl` - Design system compliance and accessibility
- `documentation.dsl` - Documentation requirements and standards
- `index.dsl` - Module loader

#### security-rules/ (5 files, 218 lines)
Comprehensive security requirements:
- `universal-security.dsl` - Cross-cutting security requirements
- `application-security.dsl` - App-specific security measures
- `architecture-security.dsl` - System-level security design
- `security-validation.dsl` - Security testing and verification
- `index.dsl` - Module loader

#### validation-rules/ (4 files, 172 lines)
Correctness verification and validation:
- `correctness-verification.dsl` - Code correctness checking
- `verification-process.dsl` - Testing and validation workflows
- `validation-enforcement.dsl` - Enforcement mechanisms
- `index.dsl` - Module loader

#### git-rules/ (2 files, 54 lines)
Git workflow and operations:
- `git-workflow.dsl` - Git operations and commit standards
- `index.dsl` - Module loader

### Support Files
- **`checklist.dsl`** (31 lines) - Final verification checklist
- **`app-types.dsl`** (62 lines) - Application type definitions
- **`risk-assessment.dsl`** (41 lines) - Risk evaluation framework

## Key Features

### 1. Conditional Loading
```yaml
action: load_on_demand
condition: requires_code_quality
files: [
  coding-rules/index.dsl
]
```

### 2. Variable System
```yaml
variables:
  design_system: Digital Agency Design System
  validation_passed: false
```

### 3. Standardized Array Format
All arrays now use consistent multi-line formatting:
```yaml
items: [
  first_item,
  second_item,
  third_item
]
```

### 4. Cross-References
Modules reference each other to eliminate duplication:
- Security rules reference logging standards from coding-rules
- Design rules reference monitoring from coding-rules
- All modules use unified validation variables

### 5. Hierarchical Index System
Each category has an `index.dsl` that loads related files, enabling:
- Selective loading based on task requirements
- Clear dependency management
- Easier maintenance and updates

## Token Efficiency

### Current Statistics (After Array Formatting)
| Metric | Count |
|--------|-------|
| **Total Files** | 30 DSL files |
| **Total Lines** | 1,573 lines |
| **Token Usage** | ~4,404 tokens (always full load) |

### Loading Architecture
**Important**: DSL version always loads all files through entry-point.dsl. There is no conditional loading despite development.dsl containing conditional logic (which is never executed independently).

| Loading Method | Files Loaded | Token Count | Use Case |
|----------------|--------------|-------------|----------|
| **Standard** | All 30 files via entry-point.dsl | ~4,404 tokens | All tasks |

**Note**: The conditional loading mechanisms in development.dsl are unused because entry-point.dsl loads all files upfront.

### Recent Improvements
- **Array Formatting**: Standardized all arrays to multi-line format for better readability
- **YAML Conversion**: Converted YAML lists to consistent array format
- **Quote Removal**: Eliminated unnecessary quotes from array elements
- **Syntax Optimization**: DSL syntax provides better token efficiency than YAML

### Version Comparison (All Full Load)
| Version | Files | Lines | Tokens | Token Efficiency |
|---------|-------|-------|--------|------------------|
| **Markdown** | 10 files | 1,264 lines | ~7,041 tokens | Baseline |
| **YAML** | 30 files | 1,473 lines | ~5,084 tokens | 27.8% reduction |
| **DSL** | 30 files | 1,573 lines | ~4,404 tokens | **37.4% reduction** |

**Key Insight**: DSL achieves best token efficiency through syntax optimization, not conditional loading.

## Usage Patterns

### For All Tasks
```
Follow entry-point.dsl for complete DSL execution.
```
→ Always loads all 30 files (~4,404 tokens)

**Note**: Regardless of task complexity, the DSL version loads the complete framework. The benefit is comprehensive coverage with optimized syntax efficiency.

## Benefits of Modular Architecture

### 1. **Maintainability**
- Clear separation of concerns
- Easy to update specific rule categories
- Consistent cross-references prevent duplication

### 2. **Syntax Efficiency**
- DSL syntax more concise than YAML/JSON
- Reduced token count through optimized language constructs
- Better token density per line of configuration

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
2. **DSL Execution**: Process `entry-point.dsl`
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
Modify `development.dsl` to customize which modules load for specific task types:

```yaml
action: load_on_demand
condition: custom_condition
files: [
  custom-rules/index.dsl
]
```

### Variable Customization
Update variables in individual modules to customize behavior:
- Design system selection in `design-rules/ui-ux-standards.dsl`
- Security standards in `security-rules/universal-security.dsl`
- Code quality thresholds in `coding-rules/code-style.dsl`

## Troubleshooting

### Common Issues
1. **Module Not Loading**: Check condition logic in `development.dsl`
2. **Variable Conflicts**: Ensure variable names are consistent across modules
3. **Missing Cross-References**: Verify references point to correct module paths

### Debug Information
- All files use DSL version 0.3
- Variables use consistent naming: `validation_passed`, `design_system`
- Cross-references use relative paths: `coding-rules/monitoring-logging.dsl`