# Code Style Guidelines (Language-Agnostic Core)

## Core Principles -- Applicable to Any Programming Language

| #   | Principle                            | Limits/Targets | Why it matters                                                                     |
| --- | ------------------------------------ | -------------- | ---------------------------------------------------------------------------------- |
| 1   | **Readability over cleverness**      | -              | Code is read far more than it is written; optimize for the next engineer.          |
| 2   | **Fail fast & validate early**       | -              | Detect invalid input/state at the boundary; simplify downstream logic.             |
| 3   | **Limit complexity**                 | Cyclomatic ≤10, Cognitive ≤15, Nesting ≤4 levels | Keep reasoning tractable and maintainable. |
| 4   | **Single responsibility**            | -              | One reason to change -> easier testing & parallel development.                      |
| 5   | **Small units**                      | ≤50 lines per function, ≤5 parameters, ≤3 return points | Easier to understand, test, and maintain.                        |
| 6   | **Immutability preferred**           | -              | Reduces shared-state bugs; explicit mutation zones if unavoidable.                 |
| 7   | **Clear, intention-revealing names** | No abbreviations | Use descriptive names, avoid abbreviations, use consistent naming conventions.                                |
| 8   | **Early returns / guard clauses**    | -              | Flatten nesting; highlight exceptional paths first.                                |
| 9   | **Consistent error handling**        | -              | Use the idiomatic pattern of the language (exceptions, Result, Either, etc.).      |
| 10  | **Test-driven mindset**              | -              | Write tests along with code; follow risk-stratified coverage table in TESTING.md.  |

### Detailed Complexity Limits
- **Cyclomatic complexity**: ≤10 per function/method
- **Cognitive complexity**: ≤15 per function/method  
- **Nesting depth**: ≤4 levels maximum
- **Function size**: ≤50 logical lines per function
- **Parameters**: ≤5 parameters per function
- **Return points**: ≤3 return points per function
- **File size**: ≤500 lines per file, ≤20 imports, ≤10 exports

### Readability Rules
- **Naming**: Use descriptive names, avoid abbreviations, use consistent naming conventions
- **Comments**: Document WHY, not WHAT; keep comments up-to-date; remove commented-out code
- **Structure**: Imports at top, constants after imports, types/interfaces next, main logic follows, exports at bottom

### Error Handling Standards
- **Always handle errors explicitly**
- **Use specific error types**
- **Provide meaningful error messages**
- **Log errors appropriately** (see QUALITY_GATES.md for logging standards)

**Remember**: these rules are descriptive, not prescriptive dogma--when a well-documented exception yields measurable benefit, capture it in an ADR and proceed.

## Language-Specific Layer

- **Follow the primary community style guide** for the language (e.g., PEP 8 for Python, Go FMT, Rust fmt, Google Java, StandardJS, etc.).
- **Auto-format and lint** in the pre-commit hook (eslint, flake8, golangci-lint, rustfmt + clippy, ...).
- **Use idiomatic constructs**: e.g., pattern matching in Scala/Rust, list comprehensions in Python, pipelines in Elixir.
- **Leverage official tooling** for dependency management, build, and docs.

If a language requires stricter or divergent conventions, create a short overlay file in `docs/LANGUAGE_OVERRIDES/<language>.md` that references the canonical guide rather than duplicating it.

## Pragmatic Exceptions

| Scenario                                    | Permitted Deviation                         | Requirements                                                                   |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------------------------------------------ |
| **Generated code** (ORM, proto, gRPC stubs) | Formatting & complexity rules waived        | Keep in `generated/` directory; never modify by hand.                          |
| **Performance-critical path**               | May break immutability or complexity limits | Provide profiling data + ADR sign-off.                                         |
| **Legacy integration wrapper**              | Naming/structure may mirror upstream API    | Mark with `@legacy-bridge` annotation + unit tests that pin expected behavior. |

## Contributing Checklist

1. **Code passes formatter/linter** with zero errors.
2. **Complexity check** (cyclo, radon, etc.) within thresholds or ADR attached.
3. **Risk-level tests** meet coverage/mutation targets.
4. **Public APIs & domain terms** documented.
5. **No TODO/FIXME** left in committed code.

