# Agent Operating Rules

This repository defines a small, practical standard for AI agents working with GitHub repositories. Keep the rules minimal and evolve them through real use.

## 1. Before changing a repository

- Read the repository's applicable instructions.
- For meaningful changes, identify the GitHub Issue that drives the work.
- Understand the requested scope before editing.

## 2. Normal change flow

Use this flow unless the repository explicitly says otherwise:

`Issue → Branch → Change → Validate → Commit → Pull Request`

Do not directly modify `main` for normal development work.

## 3. Validation

Before reporting work as complete, run the relevant available checks (for example tests, lint, type checks, or build checks).

Do not disable, weaken, or remove validation merely to make a change pass.

## 4. Stop and ask

Stop and request human direction when:

- the request is materially ambiguous;
- the action is destructive or security-sensitive;
- production systems or data may be affected;
- repository governance or permissions would change;
- the requested action conflicts with these rules.

## 5. Minimal change

Prefer the smallest change that satisfies the Issue. Do not add unrelated refactors, dependencies, or architecture changes.

## 6. Progressive disclosure

Keep this file short. Add a rule only when real work shows that the rule is needed. Prefer specific, testable rules over long explanations.

## 7. This standard is itself governed

Changes to this standard should normally be driven by a GitHub Issue and delivered through the same workflow.
