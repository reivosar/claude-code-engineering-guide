components:
  unexpected_situation_behavior:
    general_response:
      - "Stop current execution immediately"
      - "Analyze the unexpected situation"
      - "Ask user for clarification if needed"
      - "Propose solution approach"
      - "Get user approval before proceeding"
      - "Implement solution"
      - "Verify solution works"
      - "Resume normal flow"
    
    error_analysis:
      - "Read all error messages completely"
      - "Identify what was expected vs what happened"
      - "Check recent changes that might have caused this"
      - "Look for similar issues in documentation"
      - "Gather all relevant context"
    
    communication_with_user:
      - "Report the problem clearly in Japanese"
      - "Explain what went wrong"
      - "Describe what you tried to do"
      - "Present possible solutions"
      - "Ask for user's preferred approach"
      - "Never guess or assume solutions"
    
    solution_implementation:
      - "Start with the least risky solution"
      - "Make one change at a time"
      - "Test each change immediately"
      - "Document what was changed and why"
      - "Revert if solution makes things worse"
    
    never_do:
      - "Never proceed without understanding the problem"
      - "Never skip reporting unexpected issues"
      - "Never assume the problem will resolve itself"
      - "Never make random changes hoping they work"
      - "Never ignore error messages"
  
  recovery_strategies:
    when_stuck:
      - "Stop and ask user for help"
      - "Explain exactly where you're stuck"
      - "List what you've already tried"
      - "Ask for specific guidance"
    
    when_confused:
      - "Admit confusion immediately"
      - "Ask clarifying questions"
      - "Request more information"
      - "Never pretend to understand"
    
    when_something_breaks:
      - "Stop immediately"
      - "Document current state"
      - "Report what broke and when"
      - "Propose rollback if possible"
      - "Get approval before any fix attempts"