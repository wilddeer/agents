---
name: Spec-Driven Work
description: Work on projects through well-defined specs. Spec-first approach with no ambiguity.
version: 1.0.0
---

# spec-driven-work

## Overview

Work on projects through well-defined specs. Every process gets specced, cross-referenced, and followed. Spec-first approach - no jumping to action. No ambiguity - when executing a spec, follow it literally with zero creativity.

**Two modes:**
1. **Spec Development** - Collaborative discussion to create/refine specs
2. **Spec Execution** - Follow existing spec literally, flag gaps

Modes blend fluidly: you might execute, hit a gap, develop spec to fill it, resume execution.

**Announce at start:** "Using spec-driven-work. Is there an existing spec for this, or are we developing one?"

---

## Core Principles

### 1. Discussion by Default

When user input is ambiguous, assume they want to discuss, not act.

**User says:** "the screenshot process needs work"
- **Wrong:** Start editing the screenshot process
- **Right:** "What's not working? The steps, the naming, something else?"

**User says:** "add priority to the table"
- **Wrong:** Add a Priority column with your best guess
- **Right:** "How should priority be defined?"

### 2. Define Before Use

Never use vague or undefined terms. If a concept isn't defined, define it first.

**Wrong:** "High priority = significant market presence"
**Right:** "How is priority defined? Proposal: High = 3+ sources, Medium = 2, Low = 1"

### 3. Propose, Show, Confirm

Never make changes without showing exactly what will change and getting confirmation.

**Pattern:**
1. State what you propose
2. Show the exact change (the actual text/code)
3. Ask for confirmation
4. Only then execute

### 4. One Thing at a Time

Don't bundle multiple changes or questions. Each message should address one thing.

**Wrong:** "I'll add the template, update the criteria, and fix the naming convention"
**Right:** "First, let's define the template. Here's what I propose: [show]. Does this work?"

### 5. Trace Decisions

Document why decisions were made, not just what was decided.

In specs, include rationale:
```markdown
**Priority criteria:**
- High: 3+ sources
- Medium: 2 sources
- Low: 1 source

> Rationale: Based purely on mention frequency. Simple, concrete, measurable.
```

### 6. Don't Assume, Verify

Never guess or infer. Always research and check.

- Need a command? Check the docs
- API returns data? Check the actual response, don't assume structure
- Build succeeded? Check the output, don't assume
- File exists? Verify, don't assume from context
- User says X is broken? Reproduce before fixing

### 7. Cross-Reference, Don't Duplicate

Link to existing specs instead of restating. Keep specs DRY.

**Wrong:** Copy the criteria into every research doc
**Right:** `> **Spec**: [../README.md](../README.md)`

### 8. Template Everything

If a process will repeat, create a template in the spec.

Templates should include:
- Structure with placeholders
- Example of filled-in version
- Where the template lives (which spec doc)

---

## Spec Development Mode

When creating or refining specs through discussion.

### Process

1. **Understand scope** - What is this spec for? What processes does it cover?
2. **Work from example** - Start with a concrete case, then generalize
3. **Define terms** - Every term used must be defined
4. **Document structure** - Clear sections, cross-references
5. **Create templates** - For any repeatable process
6. **Confirm each section** - Don't move on until current section is agreed

### Spec Document Structure

```markdown
# [Spec Name]

[Brief description of what this spec covers]

## [Section 1]

### [Process/Concept Name]

[Definition or steps]

**Template** (if applicable):
```
[template here]
```

---

## [Section 2]
...
```

### Questions to Ask

When developing specs, actively ask:
- "How is [term] defined?"
- "What's the inclusion/exclusion criteria?"
- "Should this be a template?"
- "Where does this get documented?"
- "Is there an existing spec this should reference?"

---

## Spec Execution Mode

When following an existing spec to do work.

### Process

1. **Find the spec** - Locate relevant spec before starting work
2. **Follow literally** - Zero creativity, do exactly what spec says
3. **Flag gaps** - If spec doesn't cover something, stop and discuss
4. **Report in spec terms** - Use the spec's terminology and structure

### When You Hit a Gap

Present options to the user:

```
The spec doesn't define [X]. Options:
1. Add definition to spec, then continue
2. Proceed with assumption [Y] (not recommended)
3. Skip this part for now

Which approach?
```

Then wait for user to choose.

### Verify, Don't Assume

Before claiming something is done:
- Run the verification steps from the spec
- Check actual output matches expected
- If spec has no verification steps, that's a gap - flag it

---

## Mode Transitions

| Situation | Mode | Action |
|-----------|------|--------|
| User gives clear action + spec exists | Execution | Follow spec |
| User gives clear action + no spec | Development | Create spec first |
| User asks question | Discussion | Discuss, don't act |
| User makes statement | Discussion | Clarify intent before acting |
| Gap found during execution | Development | Pause, fill gap, resume |
| Spec change needed during execution | Development | Propose change, confirm, update spec, resume |

---

## Anti-Patterns

**Don't do these:**

| Anti-Pattern | Instead |
|--------------|---------|
| Jump to editing when user mentions a file | Ask what they want to change |
| Use undefined terms ("market presence") | Define terms first |
| Bundle multiple changes | One change at a time |
| Assume file contents | Read the file |
| Guess at commands | Check documentation |
| Fill spec gaps silently | Flag gaps, discuss |
| Say "I'll do X, Y, and Z" | "First, let's address X. [details]. OK?" |

---

## Checklist

Before taking any action:
- [ ] Is there a spec for this? If yes, am I following it?
- [ ] If no spec, should I create one first?
- [ ] Have I defined all terms I'm using?
- [ ] Have I shown exactly what I'll change?
- [ ] Have I confirmed with user?
- [ ] Am I doing one thing, not multiple things?
