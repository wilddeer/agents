# specops

Work on projects through well-defined specs. Spec-first approach with no ambiguity — every process gets specced, cross-referenced, and followed.

## What it does

**Two modes:**
- **Spec Development** — Collaborative discussion to create and refine specs
- **Spec Execution** — Follow existing specs literally, flag gaps

Modes blend fluidly: execute a spec, hit a gap, develop spec to fill it, resume execution.

**Core principles:**
- Discussion by default — when input is ambiguous, discuss don't act
- Define before use — no vague or undefined terms
- Propose, show, confirm — never change without explicit approval
- One thing at a time — no bundled changes
- Don't assume, verify — research and check, never guess

## Contents

| Type | Name | Description |
|------|------|-------------|
| Command | `/spec-driven-workflow` | Start spec-driven work on a project |
| Skill | `spec-driven-work` | Main skill for spec development and execution |
| Skill | `spec-step-execution` | Step execution skill for subagents |
| Agent | `spec-step-executor` | Subagent for executing individual spec steps |

## Installation

```bash
# Add marketplace to Claude Code
/plugin marketplace add wilddeer/specops

# Install the plugin
/plugin install specops@wilddeer-specops
```

## License

MIT
