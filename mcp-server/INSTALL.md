# Installation Guide

## Quick Setup (Recommended)

Use the setup script from the repository root:

```bash
git clone https://github.com/username/claude-code-engineering-guide.git
cd claude-code-engineering-guide
chmod +x setup-claude-dsl.sh
./setup-claude-dsl.sh
```

Choose option 1 for MCP Server installation.

## Manual Installation

If the setup script fails:

### 1. Clone the repository
```bash
git clone https://github.com/username/claude-code-engineering-guide.git
cd claude-code-engineering-guide
```

### 2. Install the MCP server
```bash
cd mcp-server
npm install
npm install -g .
```

### 3. Verify installation
```bash
claude-dsl --help
```

### 4. Configure Claude Desktop

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "dsl-rules": {
      "command": "claude-dsl",
      "args": ["/absolute/path/to/claude-code-engineering-guide/dsl"]
    }
  }
}
```

**Replace `/absolute/path/to/` with your actual clone path.**

### 5. Restart Claude Desktop

## Alternative: Direct GitHub Install

Install directly from GitHub (if repository is public):
```bash
npm install -g git+https://github.com/username/claude-code-engineering-guide.git#main:mcp-server
```

Then use the same Claude Desktop configuration above.

## Troubleshooting

### Permission denied on setup script
```bash
chmod +x setup-claude-dsl.sh
```

### Command not found
If `claude-dsl` command is not found after installation:
```bash
npm list -g claude-dsl  # Check if installed
which claude-dsl        # Check if in PATH
```

### Permission errors on npm install
```bash
sudo npm install -g .
```

### Claude Desktop not loading MCP server
1. Check config file syntax is valid JSON
2. Verify DSL folder path is absolute
3. Restart Claude Desktop completely