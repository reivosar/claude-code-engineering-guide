---
risk-level: R1
maintainer: "@dev-team"
last-reviewed: "2025-07-15"
purpose: "Language-agnostic coding standards; language-specific details defer to respective community best practices"
---

# Code Style Guidelines (Language‑Agnostic Core)

## Core Principles — Applicable to Any Programming Language

| #   | Principle                            | Why it matters                                                                     |
| --- | ------------------------------------ | ---------------------------------------------------------------------------------- |
| 1   | **Readability over cleverness**      | Code is read far more than it is written; optimize for the next engineer.          |
| 2   | **Fail fast & validate early**       | Detect invalid input/state at the boundary; simplify downstream logic.             |
| 3   | **Limit complexity**                 | Target cyclomatic complexity ≤ 10 per function/method to keep reasoning tractable. |
| 4   | **Single responsibility**            | One reason to change → easier testing & parallel development.                      |
| 5   | **Small units**                      | Aim ≤ 50 logical lines per function, ≤ 400 per file/module.                        |
| 6   | **Immutability preferred**           | Reduces shared‑state bugs; explicit mutation zones if unavoidable.                 |
| 7   | **Clear, intention‑revealing names** | No unexplained abbreviations; domain terms allowed.                                |
| 8   | **Early returns / guard clauses**    | Flatten nesting; highlight exceptional paths first.                                |
| 9   | **Consistent error handling**        | Use the idiomatic pattern of the language (exceptions, Result, Either, etc.).      |
| 10  | **Test‑driven mindset**              | Write tests along with code; follow risk‑stratified coverage table in TESTING.md.  |

**Remember**: these rules are descriptive, not prescriptive dogma—when a well‑documented exception yields measurable benefit, capture it in an ADR and proceed.

## Language‑Specific Layer

- **Follow the primary community style guide** for the language (e.g., PEP 8 for Python, Go FMT, Rust fmt, Google Java, StandardJS, etc.).
- **Auto‑format and lint** in the pre‑commit hook (eslint, flake8, golangci‑lint, rustfmt + clippy, …).
- **Use idiomatic constructs**: e.g., pattern matching in Scala/Rust, list comprehensions in Python, pipelines in Elixir.
- **Leverage official tooling** for dependency management, build, and docs.

If a language requires stricter or divergent conventions, create a short overlay file in `docs/LANGUAGE_OVERRIDES/<language>.md` that references the canonical guide rather than duplicating it.

## Pragmatic Exceptions

| Scenario                                    | Permitted Deviation                         | Requirements                                                                   |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------------------------------------------ |
| **Generated code** (ORM, proto, gRPC stubs) | Formatting & complexity rules waived        | Keep in `generated/` directory; never modify by hand.                          |
| **Performance‑critical path**               | May break immutability or complexity limits | Provide profiling data + ADR sign‑off.                                         |
| **Legacy integration wrapper**              | Naming/structure may mirror upstream API    | Mark with `@legacy‑bridge` annotation + unit tests that pin expected behavior. |

## Contributing Checklist

1. **Code passes formatter/linter** with zero errors.
2. **Complexity check** (cyclo, radon, etc.) within thresholds or ADR attached.
3. **Risk‑level tests** meet coverage/mutation targets.
4. **Public APIs & domain terms** documented.
5. **No TODO/FIXME** left in committed code.

---

**Quality is a habit, not an act.**
