# Spec: Change Default Execution Mode to Direct

## Overview

Modify the `spec-driven-work` skill so that step execution defaults to direct (main process) execution rather than subagent delegation.

**Rationale:** Direct execution provides better control, allows step-by-step review, and makes gap handling easier. Most work (especially coding) benefits from this control. Subagents remain valuable for high-volume parallel work.

---

## Current State

The skill currently says:
> "Delegate step execution to `spec-step-executor` agents by default. The main process orchestrates; subagents execute."

Exceptions for direct execution are listed as:
- Step requires user interaction mid-execution
- High ambiguity / gaps likely

---

## Target State

**New default:** Execute steps directly in main process, sequentially.

**Subagent option:** Agent suggests subagent execution when criteria are met, explains rationale, and asks user preference.

---

## Changes Required

### 1. Update "Orchestration with Subagents" section

**From:** Subagents by default, direct as exception
**To:** Agent asks before execution, gives recommendation, user decides

### 2. Add execution mode prompt

Agent always asks before starting execution:

> "Before executing, how should I run the steps?
> - **Direct** (sequential, you review each step)
> - **Subagents** (parallel where possible, faster)
> 
> My recommendation: [direct/subagents] because [reason]."

### 3. Define recommendation criteria

**Recommend subagents when:**
- Many similar items to process (5+)
- Spec has actual implementation details (no room for interpretation)
- Items are independent (can truly run in parallel)

**Recommend direct when:**
- Fewer/varied items
- Spec has high-level instructions, room for interpretation
- Steps have dependencies or likely need user input

### 4. Update "When to execute directly" table

Replace with recommendation criteria table (above).

### 5. Add execution plan requirement to Spec Development

New requirement: specs must include an execution plan section:
- Execution mode (direct vs subagents)
- If subagents: which steps/items can run in parallel
- If parallel: max concurrent runners limit

### 6. Update execution flow

If spec defines execution plan → follow it (no ask)
If spec doesn't define execution plan → ask user with recommendation

---

## Steps

### Step 1: Finalize research
Complete research on criteria and wording.

### Step 2: Draft updated "Spec Execution Mode" section
Write the new text for the execution mode section (replaces "Orchestration with Subagents").

### Step 3: Draft execution plan requirement for Spec Development
Write the new requirement for specs to include execution plans.

### Step 4: Review drafts with user
Present the exact changes for confirmation.

### Step 5: Apply changes to skill file
Update `skills/spec-driven-work/SKILL.md` with confirmed changes.

### Step 6: Verify changes
Read the updated file and confirm it matches intent.

---

## Execution Plan

**Mode:** Direct execution
**Rationale:** Small, focused change with user review needed at each step. No parallel work.
