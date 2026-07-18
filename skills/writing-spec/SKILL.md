---
name: writing-spec
description: Use after a design is approved in brainstorming, to turn it into one layered detailed spec (acceptance criteria, tasks, and how to verify) before touching code.
---

# Writing the Detailed Spec

One file holds the whole contract: intent, acceptance criteria, scope, design notes, the task breakdown, and how to verify. Spec and plan are the same document - there is no separate plan. `brainstorming` wrote the upper layers; you add the lower ones.

**Announce:** "I'm using writing-spec to complete the detailed spec."

## What you add

Open the spec file `brainstorming` started (`docs/specs/YYYY-MM-DD-<topic>.md`). It already has the summary, **Acceptance at a glance**, **Scope**, **Requirements & design notes**, and **Open questions**. You append two layers and finalize:

1. **Tasks** - the build, decomposed into reviewable units.
2. **End-to-end verification** - the command(s)/steps that prove the whole feature works; mirror it in the frontmatter `verify` field.

Then set `status: approved` once Open questions is empty.

## The spec format

Follow `spec-template.md` in this skill's directory - it is the source of truth for structure. Layout (progressive disclosure): frontmatter → one-line summary → Acceptance at a glance → Scope → Requirements & design notes → Tasks → End-to-end verification → Open questions. A human skims top-down; an agent jumps to the layer it needs.

## Acceptance criteria

Stable IDs (`AC-1`, `AC-2`) with RFC-2119 verbs (MUST / SHOULD). Pick the lightest form that stays unambiguous:

- **Default - EARS-lite one-liner:** `When <trigger>, the system shall <response>.` or `The system shall <X>.`
- **Cross-cutting / non-functional:** a checklist bullet, with sub-checks if needed.
- **When the criterion should double as a runnable test:** Given/When/Then - and note in design notes that it maps to a test.

## Tasks - the right altitude

A task is the smallest unit worth a fresh reviewer's gate and its own verify. Not line-by-line code: capable implementers turn an explicit contract into code. Each task carries exactly enough to be split out (even to a subagent) and checkpointed:

```
- [ ] **T1** [M] <title> - files: `src/x.ts` - Verifies: AC-1 - Verify: `npm test x`
- [ ] **T2** [S][P] <title> - files: `src/y.ts` - Verifies: AC-2 - Verify: `npm run build`
- [ ] **T3** [L] <title> - files: `src/z.ts` (depends on T1) - Verifies: AC-3 - Verify: `npm test z`
```

- **ID** - stable (`T1`), never reused.
- **Size** - `[S]` / `[M]` / `[L]`. Signals whether `implementing` does it inline (default) or reaches for a subagent (`[L]`, or a batch of `[P]`).
- **`[P]`** - parallel-safe: touches different files, no dependency.
- **`depends on`** - ordering when it exists.
- **files** - the boundary; what this task may touch.
- **Verifies: AC-n** - inline traceability. Every AC must be verified by at least one task. Group or order tasks by the AC they serve: the commit boundary in `implementing` is one commit per AC, so that grouping must be visible here.
- **Verify: <command>** - the deterministic check that proves this task.

Fold setup, config, and docs into the task whose deliverable needs them. Split only where a reviewer could reject one task while approving its neighbor.

**AC altitude sets the commit count.** An AC is a user-visible behavior, not a micro-step - aim for roughly 3-6 per feature. Because `implementing` commits once per AC, chopping ACs too fine makes commits re-explode; keeping them at behavior altitude keeps history to a handful of atomic commits.

## Global constraints

Copy the spec's project-wide constraints (version floors, naming/copy rules, exact magic values) verbatim into Requirements & design notes. Every task inherits them.

## No placeholders

Every part must carry real content. These are failures: a "to-be-decided" stub, "handle edge cases" with no specifics, a task that names no files or no verify command, an acceptance criterion no task verifies, a name or type spelled two ways across tasks.

## Self-review

With fresh eyes, against the spec:

1. **Coverage** - every AC has ≥1 task that `Verifies` it. Add tasks for gaps.
2. **Placeholder scan** - none of the above.
3. **Consistency** - file paths, names, and types match across tasks; the `verify` frontmatter matches End-to-end verification.

Fix inline.

## Handoff

Spec complete and `status: approved`. Offer execution:

> "Detailed spec is ready at `<path>`. I'll build it with **implementing** - single-agent in this session, tests required, verifying after. For any `[L]` or batched `[P]` tasks I'll consider a subagent (it costs ~15× the tokens, so only when it earns it). Want me to start?"

On yes: invoke **implementing**.
