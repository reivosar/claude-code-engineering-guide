components:
  bug_analysis_process:
    step1_information_gathering: [
      collect complete error message/stack trace,
      note exact time when issue occurred,
      record what action triggered the problem,
      document current environment state,
      capture relevant log files,
      screenshot error if UI-related
    ]
    
    step2_reproduction: [
      try to reproduce the issue consistently,
      identify minimum steps to trigger the problem,
      test if issue occurs in different environments,
      check if issue is intermittent or consistent,
      document reproduction steps clearly
    ]
    
    step3_root_cause_analysis: [
      read error messages line by line,
      trace code path that led to the error,
      check recent changes (git log git diff),
      verify dependencies and versions,
      check configuration files,
      review environment variables,
      examine database/file system state
    ]
    
    step4_hypothesis_formation: [
      list all possible causes based on evidence,
      rank hypotheses by likelihood,
      identify which hypothesis to test first,
      plan specific tests to verify each hypothesis
    ]
    
    step5_testing_hypotheses: [
      create minimal test case for each hypothesis,
      test hypotheses one by one,
      document results of each test,
      eliminate disproven hypotheses,
      focus on remaining candidates
    ]
  
  debugging_techniques:
    code_analysis: [
      add logging/print statements at key points,
      use debugger to step through code,
      check variable values at each step,
      verify function inputs and outputs,
      examine control flow paths
    ]
    
    system_analysis: [
      check system resources (memory disk CPU),
      verify network connectivity,
      check file permissions,
      examine process states,
      review system logs
    ]
    
    data_analysis: [
      verify data integrity,
      check data types and formats,
      examine edge cases in data,
      test with different data sets,
      validate data transformations
    ]
  
  fix_implementation:
    fix_strategy: [
      implement smallest possible fix first,
      make one change at a time,
      test fix immediately after implementation,
      verify fix doesn't break other functionality,
      add tests to prevent regression
    ]
    
    verification_steps: [
      re-run the original failing scenario,
      run full test suite,
      test edge cases related to the fix,
      verify fix works in different environments,
      check performance impact of fix
    ]
    
    documentation: [
      document what the bug was,
      explain why it occurred,
      describe the fix implemented,
      note any side effects or limitations,
      update relevant documentation
    ]