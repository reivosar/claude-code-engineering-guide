components:
  test_failure_behavior:
    on_test_failure: [
      analyze failure reason,
      fix the underlying issue,
      re-run the failed test,
      repeat until all tests pass,
      never skip failing tests
    ]
    
    failure_analysis: [
      read error messages carefully,
      identify root cause not symptoms,
      check recent changes that might cause failure,
      verify environment and dependencies
    ]
    
    fix_strategy: [
      make minimal changes to fix the issue,
      test the fix in isolation if possible,
      ensure fix doesn't break other functionality,
      document what was fixed and why
    ]
  
  validation_failure_behavior:
    on_validation_failure: [
      stop current execution immediately,
      report specific failure details,
      implement required fixes,
      re-run validation from the beginning,
      continue only when validation_passed = true
    ]
    
    retry_policy: [
      fix and retry until success,
      no limit on retry attempts,
      each retry must address the failure cause,
      never proceed with failing validations
    ]
  
  build_failure_behavior:
    on_build_failure: [
      read compilation errors line by line,
      fix syntax and import errors,
      resolve dependency issues,
      re-run build process,
      repeat until build succeeds
    ]
    
    common_fixes: [
      check for missing imports,
      verify function signatures,
      fix syntax errors,
      resolve type mismatches
    ]