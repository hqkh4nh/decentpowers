---
name: implementing
description: Use to build an approved detailed spec task by task in the current session - tests required, single-agent by default, subagents only for large or parallel tasks.
---

# Implementing

Build the spec yourself, in this session, one task at a time. Single-agent is the default: it is cheaper, keeps context tight (long context degrades - "context rot"), and avoids the ~15× token cost and coordination failures of multi-agent. Reach for subagents only when a task genuinely earns it.

**Announce:** "I'm using implementing to build this spec."

## Before you start

- Read the spec's Tasks, Acceptance at a glance, and Global constraints. Note the order (`depends on`) and what is parallel-safe (`[P]`).
- **Optional isolation:** if this work should not touch the current workspace, create a worktree first (`git worktree add .worktrees/<branch> -b <branch>`). Otherwise work on a feature branch - never commit straight to `main`/`master` without consent.
- **Progress ledger:** keep a running record at `.decentpowers/progress.md` (git-ignored). Tick one line per finished task; record the commit per acceptance criterion: `AC-1: done (commit <sha7>)`. After a compaction, trust the ledger and `git log` over memory - never redo a task or AC already marked done.

## Per task

Work each task to its deliverable, test-first. Do not commit per task - the commit boundary is one acceptance criterion (below).

1. **Test first.** Write a real test for the new behavior and watch it fail - a test you never saw fail proves nothing. Red-green ordering within the task is your call; the requirement is a genuine failing test before you trust the code. (Throwaway spikes and pure config are the only exceptions - ask if unsure.)
2. **Implement** the minimal code to satisfy the task's `Verifies: AC-n`. Stay inside the task's `files`. YAGNI - do not build beyond the AC.
3. **Run the task's `Verify`** command. Read the output.
4. **Self-check** the diff against the ACs the task verifies. Did you meet them, and nothing extra?
5. **Record** the task: tick its checkbox in the spec and its line in the ledger.

Do not move to the next task while tests or the verify command are red.

## Commit per acceptance criterion

When every task that `Verifies` an AC is done and the AC is green, make **one commit for that AC**, message referencing it (e.g. `feat: AC-2 filter tasks by status`). Group all of the AC's tasks - tests and implementation together - into that single commit; do not commit each task. A large feature then lands in a handful of atomic, traceable commits instead of dozens.

Between tasks inside one AC, code sits uncommitted in the working tree - after a compaction, the ledger's task ticks plus `git status` tell you where to resume. Record the commit in the ledger per AC: `AC-2: done (commit <sha7>)`.

If an AC feels big enough to want a mid-way checkpoint commit, it is too big - split it in the spec rather than emitting tiny fragmented commits.

## When to use a subagent

Default to doing it yourself. Dispatch a subagent only when:

- a task is `[L]` and benefits from isolated context, or
- several `[P]` tasks can run truly in parallel with no shared files.

Then hand the subagent a self-contained brief: its task text, the interfaces it consumes and produces, the global constraints, and where to report. Give it only what it needs - not your session history. Verify its work against the diff and the ACs yourself; an agent's "success" is not evidence.

State the trade-off honestly: a subagent costs roughly 15× the tokens of an inline turn and adds a coordination failure mode. Use it when the task's value clears that bar, not by default.

## When stuck

A bug, an unexpected failing test, behavior you cannot explain → stop and use **debugging**. Do not pile guesses on top of each other.

## When all tasks are done

Invoke **verifying** for the whole-branch deterministic gate and review pass. Do not claim completion yet - that is verifying's job.
