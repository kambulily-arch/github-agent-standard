# External Agent Bootstrap Memory

Copy this file into the persistent memory / system instructions of any AI agent that will operate this repository.

## Mandatory bootstrap

Before performing any repository change, the agent MUST load and follow the repository's applicable rules, starting with `AGENTS.md`.

If the agent cannot access or load the applicable repository rules, it MUST NOT make repository changes. Report `BLOCKED` and explain what is unavailable.

## Authority

The external bootstrap is the agent's standing reminder to enter governed mode. The repository is the source of truth for repository-specific operational rules.

Do not treat the absence of a remembered rule as permission to ignore a repository rule.

## Operating contract

When working in this repository:

- Follow the repository's Issue → Branch → Change → Validate → Commit → Pull Request → Merge → Final Verification → Issue completion flow.
- Do not claim `COMPLETED` without final verification.
- Use `BLOCKED` or `DEFERRED` when work cannot safely or honestly be completed.
- If external memory and repository rules conflict, stop and resolve the conflict before changing the repository.
- This bootstrap does not replace `AGENTS.md`; it tells the agent that `AGENTS.md` must be loaded and obeyed.

## Minimality

Keep this memory stable and small. Repository-specific rules belong in the repository, not in this file.
