---
name: debugging
description: Use when you hit any bug, test failure, or unexpected behavior - find the root cause before proposing a fix.
---

# Debugging

Guessing wastes time and adds bugs. Find the root cause first, then fix it once.

**Core principle:** No fix before you understand the cause. A symptom patch is a failure, even when it makes the red go away.

## Use this for

Any test failure, crash, wrong output, performance cliff, build break, or "that's weird" - especially under time pressure, when a quick fix looks obvious, or when a previous fix did not hold. Simple bugs have root causes too.

## The loop

1. **Investigate.** Read the error and stack trace completely - they often name the cause. Reproduce it reliably; if you cannot, gather more data rather than guess. Check what changed recently (`git diff`, recent commits, new deps/config). In a multi-component path, add instrumentation at each boundary and run once to see *where* it breaks before deciding *why*.

2. **Trace to the source.** Follow the bad value backward - where did it originate, what passed it in - until you reach the origin. Fix at the source, not where the symptom surfaced. Compare against a working example in the same codebase and list every difference; do not assume "that cannot matter".

3. **One hypothesis at a time.** State it: "I think X is the cause because Y." Make the smallest change that tests it - one variable. Did it work? If not, form a new hypothesis; do not stack fixes. If you do not understand something, say so and dig, do not pretend.

4. **Fix at the root, with a test.** Write a failing test that reproduces the bug and watch it fail (the test-first discipline from `implementing`). Make one root-cause fix, then verify: the test passes, nothing else broke, the issue is actually gone.

## When fixes keep failing

After 3 failed fixes, stop fixing. The pattern - each fix uncovers new coupling elsewhere, or needs "massive refactoring" - means the architecture is wrong, not the hypothesis. Raise it with your human partner instead of attempting fix #4.

## Red flags - stop and return to investigation

"Quick fix now, investigate later" · "just try changing X" · several changes at once · "skip the test, I'll check by hand" · "it's probably X" · listing fixes before tracing the data flow · "one more attempt" after two failures.
