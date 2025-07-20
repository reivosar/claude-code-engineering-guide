# Claude DSL Processing Flow

## 1. 全体フロー概要

```mermaid
graph TB
    Start([ユーザーがタスク開始]) --> ReadClaude[CLAUDE.md読み込み]
    ReadClaude --> ClassifyTask{タスク分類}
    
    ClassifyTask -->|非開発タスク| LoadCore[core DSL読み込み<br/>190トークン]
    ClassifyTask -->|開発タスク| LoadDev[core + development DSL読み込み<br/>430トークン]
    
    LoadCore --> CoreFlow[コア処理実行]
    LoadDev --> DevFlow[開発処理実行]
    
    CoreFlow --> BasicCheck[基本チェックリスト]
    DevFlow --> Validate[必須検証実行]
    
    Validate --> ValidationCheck{validation_passed?}
    ValidationCheck -->|false| Halt[処理停止]
    ValidationCheck -->|true| DevCheck[開発チェックリスト]
    
    BasicCheck --> End([完了])
    DevCheck --> End
    Halt --> End
```

## 2. 開発タスクの詳細フロー

```mermaid
graph TD
    DevStart([開発タスク開始]) --> Questions[要件確認質問<br/>日本語で実施]
    Questions --> UserConfirm{ユーザー承認?}
    UserConfirm -->|No| Stop[処理停止]
    UserConfirm -->|Yes| SetVar[validation_passed = false]
    
    SetVar --> RiskAssess[リスク評価<br/>R0/R1/R2]
    RiskAssess --> Implement[コード実装]
    Implement --> MandatoryValidation[必須検証開始]
    
    MandatoryValidation --> ServerTest[サーバー起動確認]
    ServerTest --> ClientTest[クライアント起動確認]
    ClientTest --> E2ETest[エンドツーエンド機能テスト]
    E2ETest --> ManualTest[重要経路手動検証]
    ManualTest --> APITest[API実リクエストテスト]
    APITest --> Screenshot[スクリーンショット取得]
    
    Screenshot --> AllValidated{全検証完了?}
    AllValidated -->|No| HaltDev[即座に停止<br/>ユーザー報告禁止]
    AllValidated -->|Yes| SetTrue[validation_passed = true]
    SetTrue --> ReportOK[ユーザー報告許可]
```

## 3. DSLファイル構造と読み込み

```mermaid
graph LR
    CLAUDE[CLAUDE.md<br/>エントリーポイント] --> Core[claude-core.dsl<br/>59行 190トークン]
    CLAUDE --> Dev[claude-development.dsl<br/>67行 240トークン]
    CLAUDE --> Check[checklist.dsl<br/>31行 170トークン]
    
    Core --> CoreComp[基本動作<br/>タスク分類<br/>コアフロー]
    Dev --> DevComp[作業プロセス<br/>検証ルール<br/>開発チェックリスト]
    Check --> CheckComp[基本チェックリスト<br/>開発チェックリスト]
```

## 4. 条件分岐ロジック

```mermaid
graph TD
    TaskType{task_type判定} -->|development| LoadDevDSL[development DSL読み込み]
    TaskType -->|non-development| SkipDev[development DSL スキップ]
    
    LoadDevDSL --> ValidationVar{validation_passed?}
    ValidationVar -->|false| EnforceValidation[厳格な検証強制]
    ValidationVar -->|true| AllowComplete[完了許可]
    
    EnforceValidation --> BlockReport[ユーザー報告ブロック]
    EnforceValidation --> ForceValidation[検証完了を強制]
```

## 5. File Structure & Loading

```
CLAUDE.md (Entry Point)
├── claude-core.dsl (59 lines, ~190 tokens)
│   ├── Basic behaviors
│   ├── Task classification 
│   └── Core flow control
├── claude-development.dsl (67 lines, ~240 tokens)
│   ├── Work processes
│   ├── Validation rules
│   └── Development checklist
└── checklist.dsl (31 lines, ~170 tokens)
    ├── Basic checklist
    └── Development checklist
```

## 6. Token Efficiency Comparison

```mermaid
graph LR
    A[Markdown Version] -->|484 tokens| B[Non-dev tasks]
    A -->|5,518 tokens| C[Development tasks]
    
    D[DSL Version] -->|190 tokens| E[Non-dev tasks<br/>60.7% reduction]
    D -->|430 tokens| F[Development tasks<br/>92.2% reduction]
    
    G[Unified DSL] -->|1,250 tokens| H[All tasks<br/>Fixed overhead]
```

## 7. Conditional Loading Logic

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

## 8. Enforcement Mechanisms

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
6. **Japanese Communication**: Built-in language requirements