components:
  unexpected_situation_behavior:
    general_response: [
      stop current execution immediately,
      analyze the unexpected situation,
      ask user for clarification if needed,
      propose solution approach,
      get user approval before proceeding,
      implement solution,
      verify solution works,
      resume normal flow
    ]
    
    error_analysis: [
      read all error messages completely,
      identify what was expected vs what happened,
      check recent changes that might have caused this,
      look for similar issues in documentation,
      gather all relevant context
    ]
    
    communication_with_user: [
      report the problem clearly in Japanese,
      explain what went wrong,
      describe what you tried to do,
      present possible solutions,
      ask for user's preferred approach,
      never guess or assume solutions
    ]
    
    solution_implementation: [
      start with the least risky solution,
      make one change at a time,
      test each change immediately,
      document what was changed and why,
      revert if solution makes things worse
    ]
    
    never_do: [
      never proceed without understanding the problem,
      never skip reporting unexpected issues,
      never assume the problem will resolve itself,
      never make random changes hoping they work,
      never ignore error messages
    ]
  
  recovery_strategies:
    when_stuck: [
      stop and ask user for help,
      explain exactly where you're stuck,
      list what you've already tried,
      ask for specific guidance
    ]
    
    when_confused: [
      admit confusion immediately,
      ask clarifying questions,
      request more information,
      never pretend to understand
    ]
    
    when_something_breaks: [
      stop immediately,
      document current state,
      report what broke and when,
      propose rollback if possible,
      get approval before any fix attempts
    ]