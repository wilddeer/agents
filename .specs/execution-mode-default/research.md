# Research Progress: Execution Mode Default Change

**Started:** 2026-01-24
**Status:** complete

---

## Objective

Determine how to modify the `spec-driven-work` skill to change the default step execution behavior from subagent-based to direct (main process) execution.

**Key questions:**
1. What triggers should prompt the agent to suggest subagent execution instead?
2. How should the agent present this option to the user?
3. What sections of the skill need to change?

---

## Defined Terms

| Term | Definition |
|------|------------|
| Direct execution | Steps executed in the main process, sequentially, with user able to review each step |
| Subagent execution | Steps delegated to `spec-step-executor` agents, can run in parallel |
| Main process | The primary agent conversation with the user |

---

## Findings

### Finding 1: "Detailed and unambiguous" definition
**Date:** 2026-01-24

For subagents to be appropriate, the spec must have actual implementation details - not high-level instructions like "Implement this part" without a detailed implementation guide or actual code.

If there's room for interpretation → not suitable for subagents.

Examples:
- **Good for subagents:** "For each competitor, visit their website, extract pricing from /pricing page, record in table with columns X, Y, Z"
- **Not for subagents:** "Research each competitor's pricing strategy" (room for interpretation)

---

## Decisions

### Decision 1: Agent always asks, gives opinion
**Date:** 2026-01-24

**Decision:** Agent always asks about execution mode before starting spec execution. Agent gives its recommendation with rationale, but user decides.

**Rationale:** User wants explicit control over execution mode for every spec. Asking ensures no assumptions are made.

### Decision 2: Spec generation must include execution plan
**Date:** 2026-01-24

**Decision:** When generating a spec, it's now a requirement to include an execution plan section that defines:
- Execution mode (direct vs subagents)
- If subagents: which steps/items can run in parallel
- If parallel: max concurrent runners limit

**Rationale:** Execution planning is part of spec design. The spec author knows the work best and should encode this intent. Agent follows the spec's execution plan if defined; asks only when not defined.

### Decision 3: Prompt wording approved
**Date:** 2026-01-24

**Decision:** Use this prompt format when asking about execution mode:

> "Before executing, how should I run the steps?
> - **Direct** (sequential, you review each step)
> - **Subagents** (parallel where possible, faster)
> 
> My recommendation: [direct/subagents] because [reason]."

**Rationale:** Clear, concise, gives user the choice with agent's informed opinion.

---

## Open Questions

1. ~~What specific criteria should trigger a subagent suggestion?~~ **ANSWERED:** See Finding 1 + Decision 1. Criteria: many similar items, spec has actual implementation details (no room for interpretation), items are independent.
2. ~~Should the spec be able to override the default and mandate subagents?~~ **ANSWERED:** See Decision 2. Yes, and it's now a requirement for spec generation to include an execution plan.
3. ~~How should the prompt to the user be worded?~~ **ANSWERED:** See Decision 3.
