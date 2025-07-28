#!/usr/bin/env node
import { spawn } from 'child_process';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Get DSL path from command line argument
const dslPath = process.argv[2] || './dsl';

// Check if DSL folder exists
const resolvedPath = path.resolve(dslPath);
if (!fs.existsSync(resolvedPath)) {
  console.error(`Error: DSL folder not found at ${resolvedPath}`);
  console.error('Usage: claude-dsl [path-to-dsl-folder]');
  process.exit(1);
}

if (!fs.existsSync(path.join(resolvedPath, 'CLAUDE.md'))) {
  console.error(`Error: CLAUDE.md not found in ${resolvedPath}`);
  console.error('This does not appear to be a valid DSL folder');
  process.exit(1);
}

// Set environment variable and spawn server
process.env.DSL_ROOT = resolvedPath;

console.error(`Starting DSL MCP Server...`);
console.error(`DSL folder: ${process.env.DSL_ROOT}`);

const server = spawn('node', [path.join(__dirname, 'mcp-handler.js')], {
  stdio: 'inherit',
  env: process.env
});

server.on('error', (err) => {
  console.error('Failed to start server:', err);
  process.exit(1);
});

server.on('exit', (code) => {
  process.exit(code || 0);
});