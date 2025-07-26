variables:
  doc_types: [
    API documentation,
    code comments,
    README files,
    architecture docs,
    user guides,
    deployment docs
  ]
  
  required_sections:
    readme: [
      project description,
      installation,
      usage,
      configuration,
      contributing,
      license
    ]
    
    api: [
      endpoint description,
      parameters,
      response format,
      error codes,
      examples
    ]

components:
  code_documentation:
    functions:
      required: [
        purpose description,
        parameter descriptions,
        return value description,
        throws/errors documented
      ]
      
      format: |
        /**
         * Brief description of what the function does
         * 
         * @param {Type} name - Description
         * @returns {Type} Description
         * @throws {ErrorType} When this happens
         */
    
    classes:
      required: [
        class purpose,
        usage examples,
        public API documentation,
        important notes
      ]
  
  api_documentation:
    openapi: 3.0.0
    required_fields: "${variables.required_sections.api}"
    
    examples: [
      success response example,
      error response example,
      request example,
      cURL command
    ]
  
  readme_standards:
    sections: "${variables.required_sections.readme}"
    
    badges: [
      build status,
      test coverage,
      version,
      license
    ]
    
    formatting: [
      use consistent heading levels,
      include code examples,
      add screenshots where helpful,
      keep it concise
    ]
  
  architecture_docs:
    required: [
      system overview diagram,
      component descriptions,
      data flow,
      technology choices,
      decision rationale
    ]
    
    diagrams: [
      use standard notation,
      keep diagrams simple,
      version control diagrams,
      update with code changes
    ]