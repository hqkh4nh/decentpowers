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
- **Progress ledger:** keep a running record at `.decentpowers/progress.md` (git-ignored). One line per finished task: `T1: done (commits <base7>..<head7>)`. After a compaction, trust the ledger and `git log` over memory - never redo a task already marked done.

## Per task

Work the task to its deliverable, then verify and commit:

1. **Test first.** Write a real test for the new behavior and watch it fail - a test you never saw fail proves nothing. Red-green ordering within the task is your call; the requirement is a genuine failing test before you trust the code. (Throwaway spikes and pure config are the only exceptions - ask if unsure.)
2. **Implement** the minimal code to satisfy the task's `Verifies: AC-n`. Stay inside the task's `files`. YAGNI - do not build beyond the AC.
3. **Run the task's `Verify`** command. Read the output.
4. **Self-check** the diff against the ACs the task verifies. Did you meet them, and nothing extra?
5. **Commit** the task as one coherent commit. Group the test and implementation together; do not split a task into many tiny commits.
6. **Record** the task in the ledger and tick its checkbox in the spec.

Do not move to the next task while tests or the verify command are red.

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
