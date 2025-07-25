# Task Completion Checklist

**BEFORE REPORTING TASK COMPLETION, YOU MUST:**

## Professional Behavior Check

- Asked clarifying questions instead of assuming?
- Admitted when I didn't know something?
- Reported problems early with solutions?
- Took ownership of issues?
- Balanced perfectionism with delivery?

## Work Process Check

- Clarified requirements obsessively?
- Assessed risk level first?
- Defined success criteria upfront?
- Thought about failure modes?
- Validated before requesting feedback?

## Task Classification Check

- Read required additional files (if development task)?
- Followed appropriate process for task type?

## Mandatory Verification Steps (Development Tasks)

### Program Correctness Verification

#### Syntactic Correctness
- [ ] **Build process completes successfully**
- [ ] **Application starts without crashes**
- [ ] **No syntax or import errors**
- [ ] **Code compiles/runs without errors**

#### Functional Correctness
- [ ] **Execute primary user workflows**
- [ ] **Verify expected outputs for given inputs**
- [ ] **Test edge cases and error conditions**
- [ ] **Core features work as intended**

#### Integration Correctness
- [ ] **API endpoints respond correctly**
- [ ] **Database operations succeed**
- [ ] **External service connections work**
- [ ] **Authentication/authorization functions**
- [ ] **Components communicate correctly**

#### Practical Correctness
- [ ] **Complete realistic usage scenarios**
- [ ] **Verify business logic implementation**
- [ ] **Test with realistic data volumes**
- [ ] **Confirm performance under normal load**
- [ ] **End-to-end user scenarios complete successfully**

### Mandatory Validation Requirements

**ALL MUST BE COMPLETED:**
- [ ] **Run unit tests if available**
- [ ] **Verify startup success**
- [ ] **Test end-to-end user experience**
- [ ] **Verify critical paths manually**
- [ ] **Test API with real requests**

### Required Evidence

- [ ] **Startup confirmation screenshots**
- [ ] **Working application demonstration**
- [ ] **Test execution logs**
- [ ] **No critical failures detected**

## Validation Enforcement

- **Halt condition**: validation_passed = false
- **Enforcement**: STRICT - No exceptions
- **Definition**: Development task = Implementation + All validations passed
- **User report rule**: NO user reporting until validation_passed = true

## Completion Criteria

- [ ] **All validation steps executed**
- [ ] **No critical failures detected**
- [ ] **validation_passed = true**
- [ ] **All evidence artifacts collected**

## Final Verification

- "Did I follow every principle like my job depends on it?"
- "Is validation_passed = true?"
- "Do I have concrete evidence of working functionality?"

**If you skip this checklist = You failed the task**
**If validation_passed ≠ true = You failed the task**
