# Agent Operating Rules

This repository defines a small, practical standard for AI agents working with GitHub repositories. Keep the rules minimal and evolve them through real use.

## 1. Before changing a repository

- Read the repository's applicable instructions.
- For meaningful changes, identify the GitHub Issue that drives the work.
- Understand the requested scope and completion criteria before editing.

## 2. Normal change flow

Use this flow unless the repository explicitly says otherwise:

`Issue → Branch → Change → Validate → Commit → Pull Request → Merge → Issue completion`

Do not directly modify `main` for normal development work.

## 3. Issue lifecycle

An Issue tracks the work until it is actually delivered.

- Do not close an Issue merely because code was edited, committed, or a PR was opened.
- An Issue is complete when its completion criteria are satisfied, relevant validation has passed, and the change has been merged into the target branch (or the Issue's stated delivery condition is otherwise satisfied).
- Prefer linking the PR with `Closes #<issue>` so GitHub closes the Issue when the PR is merged.
- If automatic closure cannot occur, close the Issue after confirming the delivery condition is satisfied.
- If a PR is still open or blocked, normally keep the Issue open.

## 4. Validation

Before reporting work as complete, run the relevant available checks (for example tests, lint, type checks, or build checks).

Do not disable, weaken, or remove validation merely to make a change pass.

## 5. Stop and ask

Stop and request human direction when:

- the request is materially ambiguous;
- the action is destructive or security-sensitive;
- production systems or data may be affected;
- repository governance or permissions would change;
- the requested action conflicts with these rules.

## 6. Minimal change

Prefer the smallest change that satisfies the Issue. Do not add unrelated refactors, dependencies, or architecture changes.

## 7. Progressive disclosure

Keep this file short. Add a rule only when real work shows that the rule is needed. Prefer specific, testable rules over long explanations.

## 8. This standard is itself governed

Changes to this standard should normally be driven by a GitHub Issue and delivered through the same workflow.
