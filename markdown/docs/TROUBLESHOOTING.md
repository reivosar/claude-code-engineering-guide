# When Stuck (What Smart Engineers Do)

## General Problem-Solving Approach

1. **Step back and rubber duck**: Explain the problem to someone (or yourself)
2. **Check documentation thoroughly**: Docs, source code, commit history, architecture decisions
3. **Simplify ruthlessly**: Remove complexity until the problem becomes obvious
4. **Ask better questions**: Instead of "how do I fix this?" ask "why does this exist?"
5. **Spike and throw away**: Build a quick prototype to understand the problem space
6. **Talk to humans**: Senior engineers know when to ask for help early
7. **Validate before asking**: Ensure code compiles, tests pass, and basic functionality works before seeking input

## Bug Analysis & Debugging Process

### Step 1: Information Gathering
- **Collect complete error message/stack trace**
- **Note exact time when issue occurred**
- **Record what action triggered the problem**
- **Document current environment state**
- **Capture relevant log files**
- **Screenshot error if UI-related**

### Step 2: Reproduction
- **Try to reproduce the issue consistently**
- **Identify minimum steps to trigger the problem**
- **Test if issue occurs in different environments**
- **Check if issue is intermittent or consistent**
- **Document reproduction steps clearly**

### Step 3: Root Cause Analysis
- **Read error messages line by line**
- **Trace code path that led to the error**
- **Check recent changes (git log, git diff)**
- **Verify dependencies and versions**
- **Check configuration files**
- **Review environment variables**
- **Examine database/file system state**

### Step 4: Hypothesis Formation
- **List all possible causes based on evidence**
- **Rank hypotheses by likelihood**
- **Identify which hypothesis to test first**
- **Plan specific tests to verify each hypothesis**

### Step 5: Testing Hypotheses
- **Create minimal test case for each hypothesis**
- **Test hypotheses one by one**
- **Document results of each test**
- **Eliminate disproven hypotheses**
- **Focus on remaining candidates**

## Debugging Techniques

### Code Analysis
- **Add logging/print statements at key points**
- **Use debugger to step through code**
- **Check variable values at each step**
- **Verify function inputs and outputs**
- **Examine control flow paths**

### System Analysis
- **Check system resources (memory, disk, CPU)**
- **Verify network connectivity**
- **Check file permissions**
- **Examine process states**
- **Review system logs**

### Data Analysis
- **Verify data integrity**
- **Check data types and formats**
- **Examine edge cases in data**
- **Test with different data sets**
- **Validate data transformations**

## Fix Implementation Strategy

### Implementation Approach
- **Implement smallest possible fix first**
- **Make one change at a time**
- **Test fix immediately after implementation**
- **Verify fix doesn't break other functionality**
- **Add tests to prevent regression**

### Verification Steps
- **Re-run the original failing scenario**
- **Run full test suite**
- **Test edge cases related to the fix**
- **Verify fix works in different environments**
- **Check performance impact of fix**

### Documentation Requirements
- **Document what the bug was**
- **Explain why it occurred**
- **Describe the fix implemented**
- **Note any side effects or limitations**
- **Update relevant documentation**
