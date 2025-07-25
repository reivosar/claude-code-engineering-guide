claude_dsl:
  version: "0.3"
  
  variables:
    doc_types:
      - "API documentation"
      - "Code comments"
      - "README files"
      - "Architecture docs"
      - "User guides"
      - "Deployment docs"
    
    required_sections:
      readme:
        - "Project description"
        - "Installation"
        - "Usage"
        - "Configuration"
        - "Contributing"
        - "License"
      
      api:
        - "Endpoint description"
        - "Parameters"
        - "Response format"
        - "Error codes"
        - "Examples"
  
  components:
    code_documentation:
      functions:
        required:
          - "Purpose description"
          - "Parameter descriptions"
          - "Return value description"
          - "Throws/Errors documented"
        
        format: |
          /**
           * Brief description of what the function does
           * 
           * @param {Type} name - Description
           * @returns {Type} Description
           * @throws {ErrorType} When this happens
           */
      
      classes:
        required:
          - "Class purpose"
          - "Usage examples"
          - "Public API documentation"
          - "Important notes"
    
    api_documentation:
      openapi: "3.0.0"
      required_fields: "${variables.required_sections.api}"
      
      examples:
        - "Success response example"
        - "Error response example"
        - "Request example"
        - "cURL command"
    
    readme_standards:
      sections: "${variables.required_sections.readme}"
      
      badges:
        - "Build status"
        - "Test coverage"
        - "Version"
        - "License"
      
      formatting:
        - "Use consistent heading levels"
        - "Include code examples"
        - "Add screenshots where helpful"
        - "Keep it concise"
    
    architecture_docs:
      required:
        - "System overview diagram"
        - "Component descriptions"
        - "Data flow"
        - "Technology choices"
        - "Decision rationale"
      
      diagrams:
        - "Use standard notation"
        - "Keep diagrams simple"
        - "Version control diagrams"
        - "Update with code changes"