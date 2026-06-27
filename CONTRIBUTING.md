# Contributing to decentpowers

decentpowers is a small set of skills. Keep it small. Add a skill only when a distinct workflow stage genuinely needs one; prefer extending an existing skill.

## Skill structure

Each skill is a directory under `skills/<name>/` with a `SKILL.md`:

```markdown
---
name: <kebab-case, matches the directory>
description: <one line - when to use this skill; this is what triggers it>
---

# <Title>

<body>
```

Bundled references (templates, longer guides) live beside `SKILL.md` and are linked from it, loaded only when needed.

## Voice

Write principles, not mechanical checklists. State the few hard gates plainly - the design-approval gate, the evidence-before-done gate - and leave the rest to judgment. Prefer "show the evidence" over "always/never" lists. No generic filler.

## Before you ship a change

Run the structural gate:

```
bash scripts/check.sh
```

It must print `ALL CHECKS PASSED`. Then run the behavioral acceptance test: in a clean Claude Code session with the plugin installed, send *"Let's make a react todo list"* and confirm `brainstorming` auto-triggers before any code.
