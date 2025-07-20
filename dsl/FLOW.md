# Claude DSL Processing Flow

## 1. Overall Flow Overview

### Main DSL Flow (Recommended)
```mermaid
graph TB
    Start([User starts task]) --> ReadClaude[Read CLAUDE.md<br/>80 tokens]
    ReadClaude --> LoadMain[Load claude-main.dsl<br/>600 tokens]
    LoadMain --> ClassifyTask{Task classification}
    
    ClassifyTask -->|Non-development| CoreFlow[Execute core flow]
    ClassifyTask -->|Development| DevFlow[Execute dev flow<br/>+ load external DSLs]
    
    CoreFlow --> BasicCheck[Basic checklist]
    DevFlow --> Validate[Mandatory validation]
    
    Validate --> ValidationCheck{validation_passed?}
    ValidationCheck -->|false| Halt[HALT execution]
    ValidationCheck -->|true| DevCheck[Development checklist]
    
    BasicCheck --> End([Complete])
    DevCheck --> End
    Halt --> End
```

### Split DSL Flow (Advanced)
```mermaid
graph TB
    StartSplit([User starts task]) --> ReadClaudeSplit[Read CLAUDE.md]
    ReadClaudeSplit --> ClassifyTaskSplit{Task classification}
    
    ClassifyTaskSplit -->|Non-development| LoadCore[Load core DSL<br/>190 tokens]
    ClassifyTaskSplit -->|Development| LoadDev[Load core + dev DSL<br/>430 tokens]
    
    LoadCore --> CoreFlowSplit[Execute core flow]
    LoadDev --> DevFlowSplit[Execute dev flow]
    
    CoreFlowSplit --> BasicCheckSplit[Basic checklist]
    DevFlowSplit --> ValidateSplit[Mandatory validation]
    
    ValidateSplit --> ValidationCheckSplit{validation_passed?}
    ValidationCheckSplit -->|false| HaltSplit[HALT execution]
    ValidationCheckSplit -->|true| DevCheckSplit[Development checklist]
    
    BasicCheckSplit --> EndSplit([Complete])
    DevCheckSplit --> EndSplit
    HaltSplit --> EndSplit
```

## 2. Development Task Detailed Flow

```mermaid
graph TD
    DevStart([Development task start]) --> Questions[Clarifying questions<br/>in Japanese]
    Questions --> UserConfirm{User approval?}
    UserConfirm -->|No| Stop[Stop execution]
    UserConfirm -->|Yes| SetVar[validation_passed = false]
    
    SetVar --> RiskAssess[Risk assessment<br/>R0/R1/R2]
    RiskAssess --> Implement[Code implementation]
    Implement --> MandatoryValidation[Start mandatory validation]
    
    MandatoryValidation --> ServerTest[Server startup verification]
    ServerTest --> ClientTest[Client startup verification]
    ClientTest --> E2ETest[End-to-end functionality test]
    E2ETest --> ManualTest[Critical path manual verification]
    ManualTest --> APITest[API real request testing]
    APITest --> Screenshot[Screenshot capture]
    
    Screenshot --> AllValidated{All validations complete?}
    AllValidated -->|No| HaltDev[IMMEDIATE HALT<br/>Block user reporting]
    AllValidated -->|Yes| SetTrue[validation_passed = true]
    SetTrue --> ReportOK[Allow user reporting]
```

## 3. DSL File Structure and Loading

### Main DSL Structure (Recommended)
```mermaid
graph LR
    CLAUDE[CLAUDE.md<br/>Entry point<br/>15 lines, 80 tokens] --> Main[claude-main.dsl<br/>Main execution logic<br/>140 lines, 600 tokens]
    
    Main --> External1[validation-rules.dsl<br/>63 lines, 280 tokens]
    Main --> External2[app-types.dsl<br/>62 lines, 270 tokens]
    Main --> Dev[claude-development.dsl<br/>73 lines, 240 tokens]
```

### Split DSL Structure (Advanced)
```mermaid
graph LR
    CLAUDE_Split[CLAUDE.md<br/>Entry point] --> Core[claude-core.dsl<br/>59 lines, 190 tokens]
    CLAUDE_Split --> Dev_Split[claude-development.dsl<br/>67 lines, 240 tokens]
    CLAUDE_Split --> Check[checklist.dsl<br/>31 lines, 170 tokens]
    
    Core --> CoreComp[Basic behaviors<br/>Task classification<br/>Core flow]
    Dev_Split --> DevComp[Work processes<br/>Validation rules<br/>Dev checklist]
    Check --> CheckComp[Basic checklist<br/>Development checklist]
```

## 4. Conditional Logic

```mermaid
graph TD
    TaskType{task_type check} -->|development| LoadDevDSL[Load development DSL]
    TaskType -->|non-development| SkipDev[Skip dev DSL]
    
    LoadDevDSL --> ValidationVar{validation_passed?}
    ValidationVar -->|false| EnforceValidation[Strict validation enforcement]
    ValidationVar -->|true| AllowComplete[Allow completion]
    
    EnforceValidation --> BlockReport[Block user reporting]
    EnforceValidation --> ForceValidation[Force validation completion]
```

## 5. Token Efficiency Comparison

```mermaid
graph LR
    A[Markdown Version] -->|484 tokens| B[Non-dev tasks]
    A -->|5,518 tokens| C[Development tasks]
    
    D[DSL Version] -->|190 tokens| E[Non-dev tasks<br/>60.7% reduction]
    D -->|430 tokens| F[Development tasks<br/>92.2% reduction]
    
    G[Unified DSL] -->|1,250 tokens| H[All tasks<br/>Fixed overhead]
```

## 6. Conditional Loading Logic

```yaml
# Core DSL decides loading strategy
rules:
  - if: task_type == "development"
    then:
      include:
        - components.validation_rules
        - components.work_process  
        - components.validation
  - if: not validation_passed
    then:
      action: halt
      message: "Complete ALL validation requirements"
```

## 7. Enforcement Mechanisms

```mermaid
flowchart TD
    A[Task Execution] --> B{validation_passed?}
    B -->|false| C[STRICT enforcement]
    C --> D[IMMEDIATE_HALT]
    C --> E[Block user reporting]
    C --> F[Force validation completion]
    B -->|true| G[Allow task completion]
    G --> H[Present checklist]
    H --> I[Task finished]
```

## Key Benefits of DSL Approach

1. **Conditional Loading**: Only load what's needed per task type
2. **Variable Control**: `validation_passed` enforces completion
3. **Modular Design**: Separate concerns across files
4. **Token Efficiency**: 92.2% reduction for development tasks
5. **Strict Enforcement**: No exceptions to validation rules
6. **Language Requirements**: Built-in Japanese communication rules