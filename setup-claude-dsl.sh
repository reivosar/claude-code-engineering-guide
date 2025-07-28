#!/bin/bash
# Claude Setup Script - Choose Your Integration Method

set -e

# Get current directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DSL_DIR="$REPO_DIR/dsl"
MCP_DIR="$REPO_DIR/mcp-server"

echo "Claude Code Engineering Guide Setup"
echo "===================================="
echo ""
echo "Choose how you want to use Claude with the DSL rules:"
echo ""
echo "1) MCP Server (Recommended) - Auto-load rules on demand, 0 tokens"
echo "2) Manual DSL Loading - Copy CLAUDE.md, use 4,404 tokens"
echo "3) Exit"
echo ""

while true; do
    read -p "Enter your choice (1-3): " choice
    case $choice in
        1)
            echo ""
            echo "Setting up MCP Server..."
            
            # Check if dsl folder exists
            if [ ! -d "$DSL_DIR" ]; then
                echo "Error: DSL folder not found at $DSL_DIR"
                exit 1
            fi
            
            # Check if mcp-server folder exists
            if [ ! -d "$MCP_DIR" ]; then
                echo "Error: MCP server folder not found at $MCP_DIR"
                exit 1
            fi
            
            # Install MCP server
            echo "Installing MCP server..."
            cd "$MCP_DIR"
            npm install
            npm install -g .
            
            # Verify installation
            if ! command -v claude-dsl &> /dev/null; then
                echo "Error: claude-dsl command not found after installation"
                exit 1
            fi
            
            echo "MCP server installed successfully!"
            
            # Generate Claude Desktop configuration
            CONFIG_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
            CONFIG_DIR="$(dirname "$CONFIG_FILE")"
            
            echo "Setting up Claude Desktop configuration..."
            
            # Create config directory if it doesn't exist
            mkdir -p "$CONFIG_DIR"
            
            # Create or update config file
            if [ -f "$CONFIG_FILE" ]; then
                echo "Backing up existing config..."
                cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
            fi
            
            # Generate new config
            cat > "$CONFIG_FILE" << EOF
{
  "mcpServers": {
    "dsl-rules": {
      "command": "claude-dsl",
      "cwd": "$REPO_DIR",
      "args": ["./dsl"]
    }
  }
}
EOF
            
            echo "Claude Desktop configuration updated!"
            echo "Config file: $CONFIG_FILE"
            
            echo ""
            echo "MCP Server setup complete!"
            echo ""
            echo "Next steps:"
            echo "1. Restart Claude Desktop"
            echo "2. In Claude, try: @dsl-rules"
            echo "3. Or use slash commands: /apply-dsl-rules"
            echo ""
            echo "DSL folder: $DSL_DIR"
            echo "MCP command: claude-dsl"
            break
            ;;
        2)
            echo ""
            echo "Setting up Manual DSL Loading..."
            
            # Check if CLAUDE.md exists
            if [ ! -f "$DSL_DIR/CLAUDE.md" ]; then
                echo "Error: CLAUDE.md not found at $DSL_DIR/CLAUDE.md"
                exit 1
            fi
            
            # Copy CLAUDE.md to project root for easy access
            CLAUDE_MD_TARGET="$REPO_DIR/CLAUDE.md"
            cp "$DSL_DIR/CLAUDE.md" "$CLAUDE_MD_TARGET"
            
            echo "CLAUDE.md copied to project root"
            echo "File location: $CLAUDE_MD_TARGET"
            
            echo ""
            echo "Manual DSL setup complete!"
            echo ""
            echo "Usage instructions:"
            echo "1. Copy the contents of CLAUDE.md"
            echo "2. Paste into Claude at the start of each session"
            echo "3. Follow the DSL workflow instructions"
            echo ""
            echo "Note: This method uses ~4,404 tokens per session"
            echo "Consider using MCP Server (option 1) for better efficiency"
            break
            ;;
        3)
            echo "Setup cancelled"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, or 3."
            ;;
    esac
done