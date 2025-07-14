---
risk-level: R1
maintainer: @dev-team
last-reviewed: 2025-07-14
purpose: Detailed coding standards and OO Exercise rules implementation
---

# Code Style Guidelines

## Object-Oriented Exercise Rules (Detailed)

### Rule 1: One Level of Indentation per Method
- Break down complex logic using Extract Method pattern
- Use early returns and guard clauses
- Maximum nesting level: 1

**Examples:**
```typescript
// ❌ Violation - Multiple indentation levels
processOrder(order: Order): void {
  if (order.isValid()) {
    if (order.isPaid()) {
      if (order.hasItems()) {
        // process logic
      }
    }
  }
}

// ✅ Compliant - Single level with early returns
processOrder(order: Order): void {
  if (!order.isValid()) return;
  if (!order.isPaid()) return;
  if (!order.hasItems()) return;
  
  executeOrderProcessing(order);
}
```

### Rule 2: No else Keywords
- Use early returns, guard clauses, and polymorphism
- Replace conditional logic with strategy pattern when complex

### Rule 3: Wrap All Primitives
- Create Value Objects for domain concepts
- Exception: Simple DTOs and internal data structures
- Enforce validation at construction time

### Rule 4: First-Class Collections
- Encapsulate collections in dedicated classes
- Provide domain-specific methods for collection operations
- Hide internal collection implementation

### Rule 5: One Dot per Line
- Avoid method chaining for better debugging
- Use intermediate variables with meaningful names
- Exception: Fluent interfaces for builders

### Rule 6: Don't Abbreviate
- Use intention-revealing names
- Prefer verbosity over brevity
- Exception: Well-known domain abbreviations

### Rule 7: Keep All Entities Small
- Maximum 50 lines per class OR cyclomatic complexity ≤10
- Single responsibility principle
- Extract classes when responsibilities diverge

### Rule 8: No Classes with More Than Two Instance Variables
- Use composition and delegation
- Exception: Aggregate root pattern with ADR approval
- Consider Value Objects for grouped data

### Rule 9: No Getters/Setters/Properties
- Follow "Tell, Don't Ask" principle
- Expose behavior, not data
- Exception: Simple data containers and framework requirements

## Pragmatic Exceptions

### ADR Required Exceptions
- Aggregate root patterns with complex state
- Framework integration requirements
- Performance-critical sections with profiling data
- Legacy system integration boundaries

### Automatic Exceptions
- Generated code (ORMs, serialization)
- Third-party library interfaces
- Configuration objects and DTOs