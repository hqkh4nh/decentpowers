---
name: finishing
description: Use when implementation is complete and verified, to integrate the work - merge, PR, or cleanup - after a final evidence check.
---

# Finishing a Development Branch

Verify once more, detect the workspace, present clear options, execute the choice, clean up.

**Announce:** "I'm using finishing to complete this work."

## 1. Final verification

Run the project's tests one more time. If anything fails, stop - show the failures and fix before integrating. Do not merge or open a PR on red.

## 2. Detect the workspace

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
```

`GIT_DIR == GIT_COMMON` → normal repo, no worktree to clean. Otherwise you are in a worktree; clean it up only if you created it (path under `.worktrees/`).

## 3. Base branch

```bash
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

Or ask: "This branch split from main - correct?"

## 4. Present options

```
Implementation complete. What would you like to do?

1. Merge back to <base> locally
2. Push and open a Pull Request
3. Keep the branch as-is
4. Discard this work

Which option?
```

Keep it to these four - no extra explanation.

## 5. Execute

- **Merge locally:** `cd` to the main repo root, `git checkout <base> && git pull && git merge <branch>`, re-run tests on the merged result, then (if you own the worktree) remove it and `git branch -d <branch>`.
- **PR:** `git push -u origin <branch>` and open the PR. Keep the worktree - it is needed for review iteration.
- **Keep as-is:** report the branch and worktree path. Leave both.
- **Discard:** show exactly what will be deleted (branch, commits, worktree) and require a typed `discard`. Then `cd` to main root, remove the worktree if you own it, `git branch -D <branch>`.

## Never

Merge on failing tests · delete work without typed confirmation · force-push unless asked · remove a worktree you did not create or before the merge succeeded · run `git worktree remove` from inside the worktree.
