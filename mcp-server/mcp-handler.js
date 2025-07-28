#!/usr/bin/env node
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  ListResourcesRequestSchema,
  ReadResourceRequestSchema,
  ListPromptsRequestSchema,
  GetPromptRequestSchema,
  CallToolRequestSchema,
  ListToolsRequestSchema
} from '@modelcontextprotocol/sdk/types.js';
import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';
import { glob } from 'glob';
import yaml from 'js-yaml';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Get DSL folder from environment variable or command line argument
const DSL_ROOT = process.env.DSL_ROOT || process.argv[2] || path.resolve(process.cwd(), 'dsl');

class DSLMCPServer {
  constructor() {
    this.server = new Server(
      {
        name: 'dsl-rules',
        version: '1.0.0',
      },
      {
        capabilities: {
          resources: {},
          prompts: {},
          tools: {}
        }
      }
    );
    
    this.claudeMd = null;
    this.dslFiles = new Map();
    this.setupHandlers();
  }

  async initialize() {
    console.error(`DSL Root Directory: ${DSL_ROOT}`);
    
    // Load CLAUDE.md
    try {
      this.claudeMd = await fs.readFile(path.join(DSL_ROOT, 'CLAUDE.md'), 'utf-8');
      console.error('CLAUDE.md loaded successfully');
    } catch (error) {
      console.error('CLAUDE.md not found in:', DSL_ROOT);
    }

    // Load all DSL files
    const dslPattern = path.join(DSL_ROOT, '**/*.dsl');
    const files = await glob(dslPattern);
    
    for (const file of files) {
      const relativePath = path.relative(DSL_ROOT, file);
      const content = await fs.readFile(file, 'utf-8');
      this.dslFiles.set(relativePath, {
        content,
        parsed: this.parseDSL(content)
      });
    }
    
    console.error(`Loaded ${this.dslFiles.size} DSL files from ${DSL_ROOT}`);
  }

  parseDSL(content) {
    try {
      return yaml.load(content);
    } catch (error) {
      return { raw: content, error: error.message };
    }
  }

  setupHandlers() {
    // List resources
    this.server.setRequestHandler(ListResourcesRequestSchema, async () => {
      const resources = [];
      
      // CLAUDE.md
      if (this.claudeMd) {
        resources.push({
          uri: 'dsl://claude.md',
          name: 'CLAUDE.md - Session Instructions',
          description: 'Main entry point and instructions',
          mimeType: 'text/markdown'
        });
      }
      
      // Group by category
      const categories = new Map();
      for (const [path, data] of this.dslFiles) {
        const category = path.split('/')[0] || 'root';
        if (!categories.has(category)) {
          categories.set(category, []);
        }
        categories.get(category).push(path);
      }
      
      // Category resources
      for (const [category, files] of categories) {
        resources.push({
          uri: `dsl://category/${category}`,
          name: `${category} (${files.length} files)`,
          description: `All ${category} DSL files`,
          mimeType: 'application/x-dsl'
        });
      }
      
      // Individual files
      for (const [path] of this.dslFiles) {
        resources.push({
          uri: `dsl://file/${path}`,
          name: path,
          description: `DSL file: ${path}`,
          mimeType: 'application/x-dsl'
        });
      }
      
      return { resources };
    });

    // Read resource
    this.server.setRequestHandler(ReadResourceRequestSchema, async (request) => {
      const { uri } = request.params;
      
      if (uri === 'dsl://claude.md') {
        return {
          contents: [{
            uri,
            mimeType: 'text/markdown',
            text: this.claudeMd
          }]
        };
      }
      
      if (uri.startsWith('dsl://category/')) {
        const category = uri.replace('dsl://category/', '');
        const files = [];
        
        for (const [path, data] of this.dslFiles) {
          if (path.startsWith(category + '/') || (category === 'root' && !path.includes('/'))) {
            files.push(`### ${path}\n\`\`\`yaml\n${data.content}\n\`\`\``);
          }
        }
        
        return {
          contents: [{
            uri,
            mimeType: 'text/plain',
            text: files.join('\n\n')
          }]
        };
      }
      
      if (uri.startsWith('dsl://file/')) {
        const filePath = uri.replace('dsl://file/', '');
        const data = this.dslFiles.get(filePath);
        
        if (data) {
          return {
            contents: [{
              uri,
              mimeType: 'application/x-dsl',
              text: data.content
            }]
          };
        }
      }
      
      throw new Error(`Resource not found: ${uri}`);
    });

    // List prompts
    this.server.setRequestHandler(ListPromptsRequestSchema, async () => {
      return {
        prompts: [
          {
            name: 'apply-dsl-rules',
            description: 'Apply all DSL rules for development',
            arguments: [
              {
                name: 'task_type',
                description: 'Type of task (development, non-development)',
                required: false
              }
            ]
          },
          {
            name: 'security-check',
            description: 'Run security validation based on app type',
            arguments: [
              {
                name: 'app_type',
                description: 'Application type (web_application, cli_application, etc.)',
                required: true
              }
            ]
          }
        ]
      };
    });

    // Get prompt
    this.server.setRequestHandler(GetPromptRequestSchema, async (request) => {
      const { name, arguments: args } = request.params;
      
      if (name === 'apply-dsl-rules') {
        const taskType = args?.task_type || 'development';
        return {
          description: 'Apply all DSL rules for the current task',
          messages: [
            {
              role: 'user',
              content: {
                type: 'text',
                text: `Follow the DSL rules for ${taskType} tasks:\n\n${this.claudeMd}\n\nExecute entry-point.dsl workflow.`
              }
            }
          ]
        };
      }
      
      if (name === 'security-check') {
        const appType = args?.app_type;
        const securityRules = this.dslFiles.get('security-rules/application-security.dsl');
        const validationRules = this.dslFiles.get('security-rules/security-validation.dsl');
        
        return {
          description: `Security validation for ${appType}`,
          messages: [
            {
              role: 'user',
              content: {
                type: 'text',
                text: `Run security validation for ${appType} application:\n\n${securityRules?.content}\n\n${validationRules?.content}`
              }
            }
          ]
        };
      }
      
      throw new Error(`Unknown prompt: ${name}`);
    });

    // List tools
    this.server.setRequestHandler(ListToolsRequestSchema, async () => {
      return {
        tools: [
          {
            name: 'validate-dsl-compliance',
            description: 'Check if code complies with DSL rules',
            inputSchema: {
              type: 'object',
              properties: {
                category: {
                  type: 'string',
                  description: 'DSL category to validate (coding-rules, security-rules, etc.)'
                },
                code: {
                  type: 'string',
                  description: 'Code to validate'
                }
              },
              required: ['category']
            }
          }
        ]
      };
    });

    // Call tool
    this.server.setRequestHandler(CallToolRequestSchema, async (request) => {
      const { name, arguments: args } = request.params;
      
      if (name === 'validate-dsl-compliance') {
        const { category, code } = args;
        const rules = [];
        
        for (const [path, data] of this.dslFiles) {
          if (path.startsWith(category + '/')) {
            rules.push(data.parsed);
          }
        }
        
        return {
          content: [
            {
              type: 'text',
              text: `Validation results for ${category}:\n- Found ${rules.length} rule files\n- Status: Check implementation against loaded rules`
            }
          ]
        };
      }
      
      throw new Error(`Unknown tool: ${name}`);
    });
  }

  async run() {
    await this.initialize();
    
    const transport = new StdioServerTransport();
    await this.server.connect(transport);
    console.error('DSL MCP Server running');
  }
}

const server = new DSLMCPServer();
server.run().catch(console.error);