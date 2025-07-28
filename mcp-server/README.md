# DSL MCP Server

MCP (Model Context Protocol) server for Claude Code Engineering Guide DSL rules.

## Installation

### 1. Clone the repository
```bash
git clone https://github.com/username/claude-code-engineering-guide.git
cd claude-code-engineering-guide
```

### 2. Install the MCP server globally
```bash
cd mcp-server
npm install -g .
```

### 3. Add MCP server to Claude Desktop

#### Step 1: Locate Claude Desktop config file
```bash
# The config file location
~/Library/Application Support/Claude/claude_desktop_config.json
```

#### Step 2: Edit or create the config file
If the file doesn't exist, create it:
```bash
mkdir -p "~/Library/Application Support/Claude"
touch "~/Library/Application Support/Claude/claude_desktop_config.json"
```

#### Step 3: Add MCP server configuration
Edit the file and add the MCP server:

```json
{
  "mcpServers": {
    "dsl-rules": {
      "command": "claude-dsl",
      "args": ["/full/path/to/claude-code-engineering-guide/dsl"]
    }
  }
}
```

**Important**: 
- Use the absolute path to your cloned repository's `dsl` folder
- Replace `/full/path/to/` with your actual path
- Ensure JSON syntax is valid

#### Step 4: If you have existing MCP servers
If your config already has other MCP servers, add the new one:

```json
{
  "mcpServers": {
    "existing-server": {
      "command": "some-other-command"
    },
    "dsl-rules": {
      "command": "claude-dsl",
      "args": ["/full/path/to/claude-code-engineering-guide/dsl"]
    }
  }
}
```

### 4. Restart Claude Desktop completely

Quit and restart Claude Desktop for the MCP server to be loaded.

## Usage

After installation, Claude will have access to:

- `@dsl-rules` - List available DSL resources
- `@dsl-rules claude.md` - Show session instructions
- `@dsl-rules security-rules` - Show security rules
- `/apply-dsl-rules` - Apply DSL rules for development
- `/security-check web_application` - Run security validation

## Features

### Resources
- **claude.md** - Session entry point and instructions
- **Category DSL** - behavior-rules, coding-rules, security-rules, etc.
- **Individual DSL files** - Direct access to each DSL file

### Slash Commands
- **/apply-dsl-rules** - Apply all DSL rules for development tasks
- **/security-check** - Security validation by application type

### Tools
- **validate-dsl-compliance** - Check code compliance with DSL rules

## MCP Integration Details

### What is MCP?
Model Context Protocol (MCP) is Claude Desktop's standard for connecting external tools and data sources. This DSL MCP server provides:

- **Resources**: Access DSL files via `@dsl-rules`
- **Prompts**: Pre-built commands like `/apply-dsl-rules`
- **Tools**: Code validation and compliance checking

### How it works
1. Claude Desktop starts the `claude-dsl` process
2. Communication happens via stdin/stdout (no network ports)
3. DSL rules are loaded on-demand when requested
4. Changes to DSL files are reflected immediately

### Benefits

1. **Token savings** - Load only needed rules (saves 4,404+ tokens)
2. **Real-time updates** - DSL file changes apply immediately
3. **Conditional loading** - Load appropriate rules based on task type
4. **Security** - No network exposure, local process only

## Troubleshooting MCP Integration

### MCP server not appearing in Claude
1. Check config file syntax with `cat "~/Library/Application Support/Claude/claude_desktop_config.json" | jq`
2. Verify `claude-dsl` command exists: `which claude-dsl`
3. Test MCP server manually: `claude-dsl /path/to/dsl/folder`
4. Check Claude Desktop logs for MCP errors

### DSL rules not loading
1. Verify DSL folder path is absolute and exists
2. Check DSL folder contains `CLAUDE.md` and `*.dsl` files
3. Test path: `ls -la /your/path/to/dsl/`

### Multiple MCP servers
You can run multiple MCP servers simultaneously. Each needs a unique name in the config.