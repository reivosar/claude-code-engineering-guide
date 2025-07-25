# Claude DSL Processing Flow

## 1. Overall System Architecture

### Current Modular Structure
```mermaid
graph TB
    Start([User starts task]) --> ReadClaude[Read CLAUDE.md<br/>10 lines]
    ReadClaude --> LoadEntry[Load entry-point.dsl<br/>Main orchestrator]
    LoadEntry --> LoadDev[Load development.dsl<br/>Task workflow]
    
    LoadDev --> ConditionalLoad{Task requirements}
    ConditionalLoad -->|Code quality| LoadCoding[behavior-rules/<br/>coding-rules/]
    ConditionalLoad -->|Security critical| LoadSecurity[security-rules/]
    ConditionalLoad -->|UI/UX work| LoadDesign[design-rules/]
    ConditionalLoad -->|Debugging| LoadDebug[behavior-rules/debugging]
    ConditionalLoad -->|All tasks| LoadValidation[validation-rules/]
    
    LoadCoding --> Execute[Execute task]
    LoadSecurity --> Execute
    LoadDesign --> Execute
    LoadDebug --> Execute
    LoadValidation --> Execute
    
    Execute --> Validate[validation-rules/<br/>verification process]
    Validate --> Check{validation_passed?}
    Check -->|false| Halt[IMMEDIATE HALT]
    Check -->|true| Complete[Execute checklist.dsl]
```

## 2. File Structure Overview

### Core System (Always Loaded)
```mermaid
graph LR
    CLAUDE[CLAUDE.md<br/>Entry point<br/>10 lines] --> Entry[entry-point.dsl<br/>Main orchestrator<br/>94 lines]
    Entry --> Dev[development.dsl<br/>Workflow control<br/>119 lines]
    Dev --> Checklist[checklist.dsl<br/>Final verification<br/>31 lines]
```

### Modular Rule Categories (Conditional Loading)
```mermaid
graph TD
    Dev[development.dsl] --> BehaviorRules[behavior-rules/<br/>7 files, 312 lines]
    Dev --> CodingRules[coding-rules/<br/>4 files, 201 lines]
    Dev --> DesignRules[design-rules/<br/>3 files, 114 lines]
    Dev --> SecurityRules[security-rules/<br/>5 files, 218 lines]
    Dev --> ValidationRules[validation-rules/<br/>4 files, 172 lines]
    Dev --> GitRules[git-rules/<br/>2 files, 54 lines]
    
    BehaviorRules --> B1[communication-behavior.dsl]
    BehaviorRules --> B2[work-process-behavior.dsl]
    BehaviorRules --> B3[unexpected-situation-behavior.dsl]
    BehaviorRules --> B4[debugging-analysis-behavior.dsl]
    
    SecurityRules --> S1[universal-security.dsl]
    SecurityRules --> S2[application-security.dsl]
    SecurityRules --> S3[architecture-security.dsl]
    SecurityRules --> S4[security-validation.dsl]
    
    ValidationRules --> V1[correctness-verification.dsl]
    ValidationRules --> V2[verification-process.dsl]
    ValidationRules --> V3[validation-enforcement.dsl]
```

## 3. Development Task Detailed Flow

```mermaid
graph TD
    DevStart([Development task start]) --> Questions[Clarifying questions<br/>in Japanese]
    Questions --> UserConfirm{User approval?}
    UserConfirm -->|No| Stop[Stop execution]
    UserConfirm -->|Yes| SetVar[validation_passed = false]
    
    SetVar --> LoadBehavior[Load behavior-rules/<br/>communication, work-process]
    LoadBehavior --> RiskAssess[Risk assessment<br/>R0/R1/R2]
    RiskAssess --> LoadConditional[Conditional rule loading<br/>based on task requirements]
    
    LoadConditional --> Implement[Code implementation]
    Implement --> StartValidation[Load validation-rules/<br/>verification-process.dsl]
    
    StartValidation --> Syntactic[Syntactic correctness<br/>Build/compile success]
    Syntactic --> Functional[Functional correctness<br/>Primary workflows]
    Functional --> Integration[Integration correctness<br/>API/DB/auth tests]
    Integration --> Practical[Practical correctness<br/>End-to-end scenarios]
    
    Practical --> SecurityCheck[Load security-rules/<br/>security-validation.dsl]
    SecurityCheck --> AllValidated{All validations complete?}
    AllValidated -->|No| LoadUnexpected[Load behavior-rules/<br/>unexpected-situation-behavior.dsl]
    LoadUnexpected --> HaltDev[IMMEDIATE HALT<br/>Block user reporting]
    AllValidated -->|Yes| SetTrue[validation_passed = true]
    SetTrue --> ReportOK[Allow user reporting]
```

## 4. Conditional Loading Logic

### Task-Based Loading Strategy
```mermaid
graph TD
    TaskStart[Task Start] --> TaskType{Task Type Analysis}
    
    TaskType -->|Simple| MinimalLoad[Load: entry-point.dsl<br/>~400 tokens]
    TaskType -->|Development| DevLoad[Load: behavior-rules<br/>coding-rules<br/>~800-1200 tokens]
    TaskType -->|Security Critical| SecurityLoad[Load: security-rules<br/>validation-rules<br/>~1500 tokens]
    TaskType -->|Complex| FullLoad[Load: All categories<br/>~2400 tokens]
    
    MinimalLoad --> Execute1[Execute with basic rules]
    DevLoad --> Execute2[Execute with dev rules]
    SecurityLoad --> Execute3[Execute with security focus]
    FullLoad --> Execute4[Execute with full coverage]
```

### Loading Conditions in development.dsl
```yaml
# Conditional loading based on requirements
flow:
  - action: load_external
    files:
      - "behavior-rules/index.dsl"
  
  - action: load_on_demand
    condition: "requires_code_quality"
    files:
      - "coding-rules/index.dsl"
  
  - action: load_on_demand
    condition: "requires_security_focus"
    files:
      - "security-rules/index.dsl"
  
  - action: load_on_demand
    condition: "requires_ui_work"
    files:
      - "design-rules/index.dsl"
```

## 5. Validation Enforcement Flow

```mermaid
flowchart TD
    A[Task Implementation] --> B[Load validation-rules/verification-process.dsl]
    B --> C[Execute mandatory verification steps]
    C --> D{All steps complete?}
    
    D -->|No| E[Load behavior-rules/failure-recovery-behavior.dsl]
    E --> F[STRICT enforcement]
    F --> G[IMMEDIATE_HALT]
    F --> H[Block user reporting]
    F --> I[Load debugging-analysis-behavior.dsl]
    
    D -->|Yes| J[Load validation-rules/validation-enforcement.dsl]
    J --> K{validation_passed = true?}
    K -->|No| E
    K -->|Yes| L[Allow task completion]
    L --> M[Execute checklist.dsl]
    M --> N[Task finished]
```

## 6. Cross-Module References

### Unified Variable System
```mermaid
graph TD
    Dev[development.dsl] --> VarSet[Set: validation_passed = false]
    
    VarSet --> Sec[security-rules/security-validation.dsl]
    Sec --> SecCheck[Check: validation_passed = false]
    SecCheck --> SecHalt[Halt if validation_passed = false]
    
    VarSet --> Val[validation-rules/validation-enforcement.dsl]  
    Val --> ValCheck[Check: validation_passed = false]
    ValCheck --> ValHalt[Halt if validation_passed = false]
    
    VarSet --> Beh[behavior-rules/work-process-behavior.dsl]
    Beh --> BehCheck[Check: validation_passed = false] 
    BehCheck --> BehHalt[User report rule enforcement]
```

### Cross-Reference Network
```mermaid
graph LR
    Security[security-rules/universal-security.dsl] -.->|References| Logging[coding-rules/monitoring-logging.dsl]
    Design[design-rules/ui-ux-standards.dsl] -.->|References| Monitor[coding-rules/monitoring-logging.dsl]
    Testing[coding-rules/testing-strategy.dsl] -.->|References| SecurityTest[security-rules/security-validation.dsl]
    Validation[validation-rules/verification-process.dsl] -.->|References| TestStrategy[coding-rules/testing-strategy.dsl]
```

## 7. Token Efficiency Analysis

### Current Structure Benefits
```mermaid
graph LR
    A[Old Structure<br/>5 files, 398 lines] --> B[Limited modularity<br/>Fixed loading]
    
    C[New Structure<br/>30 files, 1,489 lines] --> D[High modularity<br/>Conditional loading]
    
    D --> E[Simple tasks: ~400 tokens<br/>Development: ~800-1200 tokens<br/>Complex: ~2400 tokens]
    
    B --> F[All tasks: ~510 tokens<br/>Fixed overhead]
```

### Loading Efficiency
| Strategy | Files Loaded | Estimated Tokens | Use Case |
|----------|--------------|------------------|----------|
| **Minimal** | entry-point.dsl only | ~400 tokens | Simple tasks |
| **Conditional** | Based on task type | ~800-1,200 tokens | Development tasks |
| **Full Load** | All modules | ~2,400 tokens | Complex projects |

## Key Benefits of Current Architecture

1. **Modular Design**: 6 rule categories with clear separation of concerns
2. **Conditional Loading**: Load only what's needed per task requirements  
3. **Variable Enforcement**: Unified `validation_passed` across all modules
4. **Cross-References**: Eliminate duplication through smart referencing
5. **Scalable Structure**: Easy to add new rule categories or extend existing ones
6. **Index System**: Hierarchical loading through index.dsl files
7. **Version Consistency**: All files use DSL v0.3 standard
8. **Japanese Communication**: Built-in language requirements across all modules