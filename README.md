# decentpowers

Lean, pragmatic workflow skills for Claude Code. decentpowers keeps the two disciplines that make agentic coding trustworthy - **no code before an approved design**, and **no "done" without verification evidence** - and drops the rest of the ceremony.

It is a deliberate trim of [superpowers](https://github.com/obra/superpowers): 7 skills instead of 14, one detailed-spec file instead of separate spec + plan, single-agent by default instead of multi-agent, and a verification gate built on deterministic checks rather than an LLM grading itself.

## Why

The 2025-2026 evidence points one way for production work:

- Multi-agent runs cost ~15× the tokens of a single turn, and at equal budget single-agent matches or beats them ([Anthropic](https://www.anthropic.com/engineering/multi-agent-research-system), [Cognition](https://cognition.com/blog/dont-build-multi-agents)).
- An LLM judging its own work is unreliable as a gate, so the gate here is deterministic - tests, build, lint, types, acceptance criteria ([ACL EMNLP 2025](https://aclanthology.org/2025.findings-emnlp.1361.pdf)).
- Long context degrades ("context rot"), so keep it tight ([Chroma](https://www.morphllm.com/context-rot)).
- Capable models execute an explicit spec well; a separate line-by-line plan mostly burns tokens ([Addy Osmani](https://addyosmani.com/blog/good-spec/)).

## The workflow

```
brainstorming → writing-spec → implementing → verifying → finishing
```

`debugging` is available any time something breaks.

1. **brainstorming** - dialogue to a design you approve. Nothing gets built first.
2. **writing-spec** - one layered file: acceptance criteria, scope, design notes, tasks, and how to verify. Spec and plan are the same document.
3. **implementing** - build it task by task, yourself, with tests. Subagents only for large or parallel tasks.
4. **verifying** - deterministic gate + one light review. Evidence before any claim.
5. **finishing** - merge, PR, or clean up.

## Install

```
/plugin marketplace add <this-repo>
/plugin install decentpowers
```

The SessionStart hook loads the `using-decentpowers` bootstrap so the skills trigger at the right moments. Verify: open a fresh session and say *"Let's make a react todo list"* - `brainstorming` should start before any code.

## The detailed spec

One file per feature (`docs/specs/YYYY-MM-DD-<topic>.md`), written in layers you can skim top-down or an agent can drill into. See `skills/writing-spec/spec-template.md`.

## Extending

See `CONTRIBUTING.md`.

## License

MIT - see `LICENSE`.
