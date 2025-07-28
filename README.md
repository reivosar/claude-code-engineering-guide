# Claude Code Engineering Guide - DSL Version

Modular engineering framework in Claude DSL v0.3 format with MCP server support for Claude Desktop.

## Quick Setup

```bash
git clone https://github.com/username/claude-code-engineering-guide.git
cd claude-code-engineering-guide
chmod +x setup-claude-dsl.sh
./setup-claude-dsl.sh
```

Choose your integration method:
1. **MCP Server (Recommended)** - Auto-load rules on demand, 0 tokens
2. **Manual DSL Loading** - Copy CLAUDE.md, use 4,404 tokens

## MCP Server Benefits

| Method | Token Usage | Setup | Real-time Updates |
|--------|-------------|--------|-------------------|
| **MCP Server** | **0 tokens** | One-time setup | ✅ Automatic |
| **Manual DSL** | 4,404 tokens | Per session | ❌ Manual reload |
| **Markdown** | 7,041 tokens | Per session | ❌ Manual reload |

## Architecture Overview

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

mcp-server/                 # MCP server for Claude Desktop
├── mcp-handler.js          # Main MCP handler
├── cli.js                  # Command line interface
└── package.json            # NPM package configuration
```

## Usage

### With MCP Server (After Setup)
In Claude Desktop:
- `@dsl-rules` - List available DSL resources
- `@dsl-rules claude.md` - Show session instructions
- `@dsl-rules security-rules` - Show security rules
- `/apply-dsl-rules` - Apply DSL rules for development
- `/security-check web_application` - Run security validation

### Manual DSL Loading
```
Follow entry-point.dsl for complete DSL execution.
```

## File Structure Details

### Core Files (Always Loaded)
- **`CLAUDE.md`** (15 lines) - Mandatory session entry point
- **`entry-point.dsl`** (247 lines) - Main DSL orchestrator
- **`development.dsl`** (138 lines) - Development workflow

### Module Categories

#### behavior-rules/ (7 files, 312 lines)
Claude's operational behaviors and error handling

#### coding-rules/ (4 files, 201 lines)
Code quality and development standards

#### design-rules/ (3 files, 114 lines)
UI/UX standards and documentation

#### security-rules/ (5 files, 218 lines)
Comprehensive security requirements

#### validation-rules/ (4 files, 172 lines)
Correctness verification and validation

#### git-rules/ (2 files, 54 lines)
Git workflow and operations

### Support Files
- **`checklist.dsl`** (25 lines) - Final verification checklist
- **`app-types.dsl`** (62 lines) - Application type definitions
- **`risk-assessment.dsl`** (41 lines) - Risk evaluation framework

## Key Features

### 1. MCP Server Integration
- **Zero token usage**: Rules loaded on-demand
- **Real-time updates**: File changes apply immediately
- **Conditional loading**: Task-appropriate rules only

### 2. Modular Rule System
- **Category organization**: Clear separation of concerns
- **Cross-references**: Unified variables prevent duplication
- **Extensible architecture**: Easy to add new categories

### 3. Token Efficiency Comparison

| Version | Files | Lines | Tokens | Efficiency |
|---------|-------|-------|--------|------------|
| **MCP Server** | 30 files | 1,573 lines | **0 tokens** | **100% reduction** |
| **DSL** | 30 files | 1,573 lines | ~4,404 tokens | 37% reduction |
| **YAML** | 30 files | 1,473 lines | ~5,084 tokens | 28% reduction |
| **Markdown** | 10 files | 1,264 lines | ~7,041 tokens | Baseline |

## Manual Installation

If the setup script fails:

### MCP Server
```bash
cd mcp-server
npm install
npm install -g .
```

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "dsl-rules": {
      "command": "claude-dsl",
      "args": ["/absolute/path/to/this/repo/dsl"]
    }
  }
}
```

### Manual DSL
Copy `dsl/CLAUDE.md` contents and paste into Claude sessions.

## Troubleshooting

### Setup Script Issues
- **Permission denied**: `chmod +x setup-claude-dsl.sh`
- **npm errors**: Use `sudo npm install -g .` if needed
- **Command not found**: Check PATH includes npm global bin

### MCP Server Issues
```bash
# Test MCP server
claude-dsl /path/to/dsl/folder

# Verify installation
claude-dsl --help
```

### Claude Desktop Issues
1. Restart Claude Desktop after config changes
2. Check config file syntax is valid JSON
3. Verify DSL folder path is absolute

## License

MIT License - see [LICENSE](LICENSE) for details.