# Governance Overview

This file is a concise map of how this repository governs AI-assisted work.

## Layers

1. `AGENT_BOOTSTRAP_MEMORY.md` — external memory to load into an AI agent before working in this repository.
2. `AGENTS.md` — repository-specific operating rules and source of truth for how work is performed.
3. GitHub Issues / Pull Requests — durable task state and delivery history.
4. `.github/workflows/` — automated validation and repository automation.
5. `REPOSITORY_INDEX.md` — generated structural index; never edit manually.

## Core lifecycle

`Load bootstrap → Read rules → Find/reuse Issue → Branch → Change → Validate → Commit → PR → CI → Merge → Final Verification → Issue completion`

## Task states

- `IN_PROGRESS` — active work.
- `COMPLETED` — delivery and final verification satisfied.
- `BLOCKED` — external condition or human decision required.
- `DEFERRED` — intentionally left for a later execution with a recorded next action.

## Important principle

The agent must not claim `COMPLETED` unless the applicable delivery conditions and final verification have actually been satisfied. If rules cannot be loaded, the agent must not modify the repository.

This overview is documentation, not a second source of truth. Detailed operational rules remain in `AGENTS.md`.
