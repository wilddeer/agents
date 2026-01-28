# SpecOps

Skills and subagents for spec-driven development. Spec-first approach: research, define, execute. No ambiguity, no guessing.

## What it does

**The problem:** Agents lose context between sessions. They jump to execution without discussion, make unexpected changes, forget decisions, repeat work.

**The solution:** Specs as persistent memory. Every task gets a spec committed to version control — agents can pick up exactly where they left off.

**How it works:**

1. **Research** — Investigate the problem, gather context, document findings in `research.md`
2. **Spec** — Define the solution with unambiguous steps in `spec.md`
3. **Execute** — Follow the spec literally, step by step
4. **Review** — Each step gets reviewed before committing
5. **Track** — Progress tracked in `progress.md`, gaps flagged and filled

Specs live in your repo and get committed. They survive sessions, editors, and model changes.

**Core principles:**
- Discussion by default — when input is ambiguous, discuss don't act
- Define before use — no vague or undefined terms
- Propose, show, confirm — never change without explicit approval
- One thing at a time — no bundled changes
- Don't assume, verify — research and check, never guess

## Contents

| Type | Name | Description |
|------|------|-------------|
| Skill | `spec-development` | Research, discuss, and write specs |
| Skill | `spec-execution` | Execute specs literally, track progress |
| Skill | `spec-step-execution` | Execute a single step from a spec |
| Skill | `spec-step-review` | Review implementation against spec |
| Agent | `spec-step-executor` | Subagent for executing individual spec steps |
| Agent | `spec-step-reviewer` | Subagent for reviewing implementation against spec |

Skills are usually automatically exposed as commands (`/spec-development`, `/spec-execution`).

## Installation

### Universal (recommended)

```bash
npx skills add wilddeer/specops
```

See [skills.sh](https://skills.sh/) for details.

### Cursor (manual install)

Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/wilddeer/specops/v4.1.0/install.ps1 | iex
```

macOS/Linux:
```bash
curl -fsSL https://raw.githubusercontent.com/wilddeer/specops/v4.1.0/install.sh | bash
```

This installs skills to `~/.cursor/skills/specops/` and agents to `~/.cursor/agents/`.

To uninstall, remove `~/.cursor/skills/specops/` and `~/.cursor/agents/spec-step-executor.md`.

### Claude Code

```bash
# Add marketplace
/plugin marketplace add wilddeer/specops

# Install the plugin
/plugin install specops@wilddeer-specops
```

## Acknowledgements

Inspired by [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent.

## License

MIT
