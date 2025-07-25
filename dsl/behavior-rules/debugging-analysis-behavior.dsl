claude_dsl:
  version: "0.3"
  
  components:
    bug_analysis_process:
      step1_information_gathering:
        - "Collect complete error message/stack trace"
        - "Note exact time when issue occurred"
        - "Record what action triggered the problem"
        - "Document current environment state"
        - "Capture relevant log files"
        - "Screenshot error if UI-related"
      
      step2_reproduction:
        - "Try to reproduce the issue consistently"
        - "Identify minimum steps to trigger the problem"
        - "Test if issue occurs in different environments"
        - "Check if issue is intermittent or consistent"
        - "Document reproduction steps clearly"
      
      step3_root_cause_analysis:
        - "Read error messages line by line"
        - "Trace code path that led to the error"
        - "Check recent changes (git log, git diff)"
        - "Verify dependencies and versions"
        - "Check configuration files"
        - "Review environment variables"
        - "Examine database/file system state"
      
      step4_hypothesis_formation:
        - "List all possible causes based on evidence"
        - "Rank hypotheses by likelihood"
        - "Identify which hypothesis to test first"
        - "Plan specific tests to verify each hypothesis"
      
      step5_testing_hypotheses:
        - "Create minimal test case for each hypothesis"
        - "Test hypotheses one by one"
        - "Document results of each test"
        - "Eliminate disproven hypotheses"
        - "Focus on remaining candidates"
    
    debugging_techniques:
      code_analysis:
        - "Add logging/print statements at key points"
        - "Use debugger to step through code"
        - "Check variable values at each step"
        - "Verify function inputs and outputs"
        - "Examine control flow paths"
      
      system_analysis:
        - "Check system resources (memory, disk, CPU)"
        - "Verify network connectivity"
        - "Check file permissions"
        - "Examine process states"
        - "Review system logs"
      
      data_analysis:
        - "Verify data integrity"
        - "Check data types and formats"
        - "Examine edge cases in data"
        - "Test with different data sets"
        - "Validate data transformations"
    
    fix_implementation:
      fix_strategy:
        - "Implement smallest possible fix first"
        - "Make one change at a time"
        - "Test fix immediately after implementation"
        - "Verify fix doesn't break other functionality"
        - "Add tests to prevent regression"
      
      verification_steps:
        - "Re-run the original failing scenario"
        - "Run full test suite"
        - "Test edge cases related to the fix"
        - "Verify fix works in different environments"
        - "Check performance impact of fix"
      
      documentation:
        - "Document what the bug was"
        - "Explain why it occurred"
        - "Describe the fix implemented"
        - "Note any side effects or limitations"
        - "Update relevant documentation"