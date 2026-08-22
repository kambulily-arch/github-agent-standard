# Agent Operating Rules

This repository defines a small, practical standard for AI agents working with GitHub repositories. Keep the rules minimal and evolve them through real use.

## 1. Before changing a repository

- Read the repository's applicable instructions.
- For meaningful changes, identify the GitHub Issue that drives the work.
- Before creating an Issue, search existing Issues and reuse an existing relevant Issue instead of creating a duplicate.
- Understand the requested scope and completion criteria before editing.
- The external agent bootstrap is mandatory for governed work. It must be loaded before any repository change. If it cannot be loaded, stop as `BLOCKED` and do not modify the repository.

## 2. Normal change flow

Use this flow unless the repository explicitly says otherwise:

`Issue → Branch → Change → Validate → Commit → Pull Request → Merge → Final Verification → Issue completion`

Do not directly modify `main` for normal development work. Repository branch protection should enforce this technically where available.

## 3. Issue lifecycle

An Issue tracks the work until it is actually delivered.

- Do not close an Issue merely because code was edited, committed, or a PR was opened.
- An Issue is complete when its completion criteria are satisfied, relevant validation has passed, and the change has been merged into the target branch (or the Issue's stated delivery condition is otherwise satisfied).
- Prefer linking the PR with `Closes #<issue>` so GitHub closes the Issue when the PR is merged.
- If automatic closure cannot occur, close the Issue only after confirming the delivery condition is satisfied.
- If a PR is still open or blocked, normally keep the Issue open.
- After completing a task, verify that no unintended duplicate or orphaned Issues were created.

## 4. Final verification

Before reporting a task as complete, explicitly verify:

- the intended Issue is identified;
- the change is on the intended branch;
- the change is committed;
- the Pull Request exists and is linked to the Issue when a PR is required;
- relevant validation and required CI checks passed for the latest PR head;
- a required check that is missing, pending indefinitely, not triggered, inaccessible, or otherwise unknown is not treated as passed;
- the PR is merged when merge is part of the delivery condition;
- the Issue has the correct final state;
- no unintended repository objects (duplicate Issues, unnecessary branches, or abandoned PRs) were created.

If the PR head changed after review or validation, repeat the affected checks before merge.

Do not report `COMPLETED` unless the applicable final checks pass. `UNKNOWN`, `NOT RUN`, and `INACCESSIBLE` are not equivalent to `PASS`.

## 5. Task states and handoff

An agent may end a task in one of these states:

- `IN_PROGRESS` — work is actively continuing in the current execution.
- `COMPLETED` — the delivery condition and final verification are satisfied.
- `BLOCKED` — progress requires an external condition, permission, information, or human decision.
- `DEFERRED` — work is intentionally left for a later execution, with the reason and next action recorded.

When ending as `BLOCKED` or `DEFERRED`, do not close the Issue. Record what is complete, what remains, why work stopped, and the next action needed so another execution can resume safely.

Do not claim completion when the agent's own capabilities, permissions, missing context, or validation failures prevent completion.

## 6. Validation and self-review

Before reporting work as complete, run the relevant available checks and inspect the current PR diff.

Self-review is not independent approval. An agent must never fabricate or claim an independent reviewer approval. In a single-user repository, the PR author may merge its own PR when repository protections permit and the required automated checks and self-review have passed.

Do not disable, weaken, remove, or bypass validation merely to make a change pass.

## 7. Risk gates

Normal changes may be completed by a single agent after automated validation, self-review, and final verification.

Treat these as high-risk governance or operational changes:

- `AGENTS.md`;
- `AGENT_BOOTSTRAP_MEMORY.md`;
- `.github/workflows/`;
- `.github/ISSUE_TEMPLATE/`;
- `.github/PULL_REQUEST_TEMPLATE.md`;
- branch protection or repository permission changes;
- production, destructive, security-sensitive, or irreversible operations.

For high-risk changes, the agent may prepare and validate the change but must obtain explicit human confirmation before the final merge/action. CI may flag the change, but CI cannot prove that a human—not an agent—performed the confirmation. Never represent self-review as human confirmation.

## 8. Stop and ask

Stop and request human direction when:

- the request is materially ambiguous;
- a high-risk action requires human confirmation;
- production systems or data may be affected;
- repository governance or permissions would change;
- the requested action conflicts with these rules;
- a required platform control cannot be established or verified for a high-risk change.

When stopping, leave a clear handoff state rather than silently abandoning work.

## 9. Minimal change

Prefer the smallest change that satisfies the Issue. Do not add unrelated refactors, dependencies, or architecture changes.

## 10. Generated artifacts

Files explicitly marked as generated are derived from source data and must not be manually maintained. Change their generator or source, then regenerate them. Automation must be able to reproduce the committed generated output deterministically.

## 11. Self-detected governance violations

If an agent discovers that it violated repository governance, it must stop expanding the violation, record the incident in an Issue, and correct the resulting state through the normal Branch → PR → Validation workflow. Do not hide the incident or claim completion until correction and final verification are complete.

## 12. Progressive disclosure

Keep this file short. Add a rule only when real work shows that the rule is needed. Prefer specific, testable rules over long explanations.

## 13. This standard is itself governed

Changes to this standard should normally be driven by a GitHub Issue and delivered through the same workflow.
