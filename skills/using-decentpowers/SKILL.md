---
name: using-decentpowers
description: Use when starting any conversation — establishes how to find and use decentpowers skills and the workflow they form.
---

# Using decentpowers

You have decentpowers: a small set of workflow skills that keep two disciplines intact — **no code before an approved design**, and **no "done" without verification evidence** — while staying lean and cheap to run.

## The one principle

**Evidence over claims.** Prefer judgment backed by evidence — a test you ran, a diff you read, output you saw — over assertions, and over mechanical checklists. When a skill gives you a rule, it is because the evidence says it earns its place, not for ritual.

## Instruction priority

1. Your human partner's explicit instructions (CLAUDE.md, direct requests) — highest.
2. decentpowers skills — override default behavior where they conflict.
3. Default system behavior — lowest.

## How to use skills

Use the Skill tool to load a skill, then follow what it says. Do not read SKILL.md files by hand — load them so they activate. When a skill plausibly applies, invoke it.

One hard gate: **before any creative work — a feature, a component, new behavior — go through `brainstorming` first.** That gate is not negotiable. The rest is judgment.

## The workflow

```
brainstorming  →  writing-spec  →  implementing  →  verifying  →  finishing
   (design,        (one detailed    (single-agent     (deterministic   (merge / PR
    approve)        spec file)       build, tests)      gate + review)   / cleanup)
```

`debugging` is called whenever a bug, test failure, or surprising behavior appears — at any point.

- **brainstorming** — turn an idea into an approved design through dialogue. Present a design and get approval before any implementation.
- **writing-spec** — turn the approved design into one layered "detailed spec" (acceptance criteria + tasks + how to verify). Spec and plan are the same file.
- **implementing** — build the spec task by task, in this session, yourself. Tests are required. Reach for subagents only when a task is genuinely large or parallel.
- **verifying** — run the deterministic gate (tests, build, lint, types, acceptance) and one light judgment review. Evidence before any "done".
- **finishing** — integrate the branch: merge, PR, or clean up.

## Rationalizations to catch

| Thought | Reality |
|---|---|
| "This is too simple to design" | Simple tasks hide the costliest assumptions. Brainstorm briefly, then go. |
| "I'll verify later / it should pass" | "Should" is not evidence. Run the check now. |
| "I'll just start coding" | Creative work goes through brainstorming first. |
| "Tests after are fine" | A test you never watched fail proves nothing. |
