---
name: verifying
description: Use before claiming work is complete, fixed, or passing — runs the deterministic gate (tests, build, lint, types, acceptance) and one light judgment review, with evidence before any claim.
---

# Verifying

Two layers: a **deterministic gate** that must pass, and **one judgment-review pass** that catches what machines miss. Deterministic checks are reliable; an LLM grading itself is not — so the machine checks are the gate and the review is advisory.

**Announce:** "I'm using verifying before calling this done."

## The iron law

```
No completion claim without fresh verification evidence.
```

If you have not run the verifying command **in this message**, you cannot say it passes. Not "should pass", not "looks right" — run it, read the output, then state the result with the evidence.

## The deterministic gate (must pass)

1. **Run the full checks** — the project's tests, build, lint, and type-check. Full runs, not partial. Read exit codes and failure counts.
2. **Acceptance** — re-read the spec's **Acceptance at a glance**. Each AC must have fresh evidence behind it (a passing test, observed output). List any AC you cannot back.
3. **End-to-end** — run the spec's `End-to-end verification`.

Any failure means the work is not done. Report the actual state with the output, fix, and re-run.

| Claim | Needs | Not enough |
|---|---|---|
| Tests pass | Test output: 0 failures, this run | "should pass", a previous run |
| Build works | Build exit 0 | linter passed |
| Bug fixed | The original symptom now passes a test | code changed, assumed fixed |
| AC met | That AC exercised and observed | "tests pass" in general |

## The judgment-review pass (advisory, one pass)

After the gate is green, do one review for what deterministic checks cannot see: logic errors, scope drift (built more or less than the ACs), unclear boundaries, missing error handling. Either review the diff yourself with fresh eyes, or dispatch one reviewer subagent given the diff and the acceptance criteria — not your history.

This is **one pass, not a loop.** Triage findings: fix Critical and Important now; note Minor for later. If a finding is wrong, push back with evidence — the test or code that proves it. Default the pass for substantial diffs; you may skip it for an `[S]`, single-file, mechanical change.

## Then

Gate green and review triaged → invoke **finishing** to integrate the branch.
