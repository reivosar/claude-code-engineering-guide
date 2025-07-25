# Claude Code Engineering Guide - Markdown Version

Comprehensive engineering framework in traditional Markdown format with enhanced content integration from DSL version.

## Usage

1. Copy **CLAUDE.md** to your project root
2. Copy **docs/ folder** to your project root  
3. Claude Code automatically loads CLAUDE.md

## File Structure

### Core Files
- `CLAUDE.md` - Main entry point with mandatory rules (76 lines)
- `docs/DEVELOPMENT.md` - Development requirements with behavior integration (206 lines)
- `docs/CHECKLIST.md` - Comprehensive completion checklist with validation rules (93 lines)

### Specialized Documentation
- `docs/CODE_STYLE.md` - Language-agnostic coding standards (64 lines)
- `docs/TESTING.md` - Risk-stratified testing requirements (127 lines)
- `docs/QUALITY_GATES.md` - Security rules and monitoring standards (216 lines)
- `docs/REPO_FLOW.md` - Git workflow and repository management (199 lines)
- `docs/TROUBLESHOOTING.md` - Systematic debugging methodology (96 lines)
- `docs/CONFIGURATION.md` - Environment and customization guide (181 lines)

**Total**: 10 files, 1,286 lines

## Key Features

### Enhanced from DSL Integration
- **Behavior Rules Integration**: Communication patterns, work processes, error handling
- **Comprehensive Security Coverage**: Universal, application-specific, and architecture-specific requirements
- **Detailed Validation Process**: Four-level correctness verification (syntactic, functional, integration, practical)
- **Systematic Debugging**: Five-step bug analysis and resolution methodology
- **Configuration Management**: Design system variability and conditional loading strategies

### Content Highlights
- **Risk-Stratified Coverage**: R0 (100%/100%/95%), R1 (95%/90%/90%), R2 (90%/85%/80%)
- **Security by Application Type**: Web, API, CLI, Mobile, Microservices, Serverless
- **Performance Standards**: FCP <1.8s, LCP <2.5s, FID <100ms, CLS <0.1
- **Validation Enforcement**: STRICT - No exceptions, validation_passed = true required

## Loading Strategies

### Minimal Load (Simple Tasks)
- `CLAUDE.md` + `docs/CHECKLIST.md`
- ~150-200 lines

### Development Load (Code Tasks)
- `CLAUDE.md` + `docs/DEVELOPMENT.md` + referenced files
- ~500-800 lines as needed

### Full Load (Complex Projects)
- All files available for comprehensive coverage
- 1,286 lines total

## Benefits

- **Human-Friendly**: Natural language format optimized for readability
- **Modular Loading**: Load only what you need for each task type
- **DSL Content Parity**: All DSL rules and behaviors integrated in Markdown format
- **Direct Claude Code Integration**: Works seamlessly with Claude Code auto-loading
- **Comprehensive Coverage**: Behavior, security, validation, debugging, and configuration
- **Maintenance Efficiency**: 10 well-organized files vs 30+ DSL files