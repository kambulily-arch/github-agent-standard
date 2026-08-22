# Agent Operating Rules

This repository defines a small, practical standard for AI agents working with GitHub repositories. Keep the rules minimal and evolve them through real use.

## 1. Before changing a repository

- Read the repository's applicable instructions.
- For meaningful changes, identify the GitHub Issue that drives the work.
- Before creating an Issue, search existing Issues and reuse an existing relevant Issue instead of creating a duplicate.
- Understand the requested scope and completion criteria before editing.
- Load the external agent bootstrap memory when available. It is a standing requirement for entering governed mode, but `AGENTS.md` remains the repository-specific source of truth.

## 2. Normal change flow

Use this flow unless the repository explicitly says otherwise:

`Issue → Branch → Change → Validate → Commit → Pull Request → Merge → Final Verification → Issue completion`

Do not directly modify `main` for normal development work.

## 3. Issue lifecycle

An Issue tracks the work until it is actually delivered.

- Do not close an Issue merely because code was edited, committed, or a PR was opened.
- An Issue is complete when its completion criteria are satisfied, relevant validation has passed, and the change has been merged into the target branch (or the Issue's stated delivery condition is otherwise satisfied).
- Prefer linking the PR with `Closes #<issue>` so GitHub closes the Issue when the PR is merged.
- If automatic closure cannot occur, close the Issue after confirming the delivery condition is satisfied.
- If a PR is still open or blocked, normally keep the Issue open.
- After completing a task, verify that no unintended duplicate or orphaned Issues were created.

## 4. Final verification

Before reporting a task as complete, explicitly verify:

- the intended Issue is identified;
- the change is on the intended branch;
- the change is committed;
- the Pull Request exists and is linked to the Issue when a PR is required;
- relevant CI and validation checks passed;
- the PR is merged when merge is part of the delivery condition;
- the Issue has the correct final state;
- no unintended repository objects (duplicate Issues, unnecessary branches, or abandoned PRs) were created.

Do not report `COMPLETED` unless the applicable final checks pass.

## 5. Task states and handoff

An agent may end a task in one of these states:

- `IN_PROGRESS` — work is actively continuing in the current execution.
- `COMPLETED` — the delivery condition and final verification are satisfied.
- `BLOCKED` — progress requires an external condition, permission, information, or human decision.
- `DEFERRED` — work is intentionally left for a later execution, with the reason and next action recorded.

When ending as `BLOCKED` or `DEFERRED`, do not close the Issue. Record what is complete, what remains, why work stopped, and the next action needed so another execution can resume safely.

Do not claim completion when the agent's own capabilities, permissions, missing context, or validation failures prevent completion.

## 6. Validation

Before reporting work as complete, run the relevant available checks (for example tests, lint, type checks, or build checks).

Do not disable, weaken, or remove validation merely to make a change pass.

## 7. Review and solo-maintainer policy

Independent review is preferred when another qualified reviewer is available, but a repository must remain operable when there is only one maintainer.

- A PR author must never pretend to provide an independent approval of their own PR.
- If there is no independent reviewer, the agent may merge its own PR only when all required automated checks pass, the change is within the Issue scope, the Final Verification checklist passes, and the change is not in a high-risk category.
- High-risk changes require explicit human confirmation before merge, even for a solo maintainer. High-risk includes destructive data changes, production-impacting changes, credential/permission/security changes, irreversible migrations, and changes that weaken or bypass governance controls.
- When explicit human confirmation is required but not yet provided, leave the PR open and record `BLOCKED: waiting for human confirmation`.
- Self-review is verification, not independent approval, and must be described accurately in the PR history.

## 8. Stop and ask

Stop and request human direction when:

- the request is materially ambiguous;
- the action is destructive or security-sensitive;
- production systems or data may be affected;
- repository governance or permissions would change;
- the requested action conflicts with these rules.

When stopping, leave a clear handoff state rather than silently abandoning work.

## 9. Self-detected governance violations

If an agent discovers that it has violated these rules:

1. Stop the violating line of work; do not compound the violation.
2. Record the violation in a dedicated GitHub Issue, unless an existing incident Issue already covers the same event.
3. State what happened, what repository state may be affected, and what correction is required.
4. Correct the state through the normal branch/PR workflow whenever a correction is required.
5. Do not hide, rewrite, or silently erase the incident merely to make the repository appear clean.
6. Perform Final Verification before marking the incident correction complete.

A governance violation is an operational event to learn from, not a reason to bypass the workflow again.

## 10. Minimal change

Prefer the smallest change that satisfies the Issue. Do not add unrelated refactors, dependencies, or architecture changes.

## 11. Progressive disclosure

Keep this file short. Add a rule only when real work shows that the rule is needed. Prefer specific, testable rules over long explanations.

## 12. Generated artifacts

Files explicitly marked as generated are derived from source data and must not be manually maintained. Change their generator or source, then regenerate them.

## 13. This standard is itself governed

Changes to this standard should normally be driven by a GitHub Issue and delivered through the same workflow.
