---
id: SPEC-NNN
title: <feature>
status: draft            # draft | approved | implemented
verify: "<one command that proves the whole feature works>"
acceptance: [AC-1, AC-2, AC-3]   # pointers only — not a second copy
---

# <Feature> — Detailed Spec

> 2–3 sentences: what + why. A reviewer can triage from this alone.

## Acceptance at a glance        # the contract: stable IDs + RFC-2119 verbs
- **AC-1** (MUST)  — When <trigger>, the system shall <response>.   # EARS-lite
- **AC-2** (MUST)  — The system shall <X>.
- **AC-3** (SHOULD) — <cross-cutting rule, checklist-style>
  - [ ] sub-check if needed

## Scope
- **In:**  …
- **Out:** …                     # explicit out-of-scope

## Requirements & design notes   # the "HOW" — prose, not line-by-line code
<intent, constraints, technical decisions; name files/interfaces inline>
- **Global constraints:** <version floors, naming/copy, magic values — verbatim>

## Tasks                         # unit of review AND unit of subagent split
- [ ] **T1** [M] <title> — files: `src/x.ts` — Verifies: AC-1 — Verify: `npm test x`
- [ ] **T2** [S][P] <title> — files: `src/y.ts` — Verifies: AC-2 — Verify: `npm run build`
- [ ] **T3** [L] <title> — files: `src/z.ts` (depends on T1) — Verifies: AC-3 — Verify: `npm test z`

## End-to-end verification       # matches frontmatter `verify`
<command / steps proving the whole feature works>

## Open questions
- [NEEDS CLARIFICATION: …]        # MUST be empty before status: approved
