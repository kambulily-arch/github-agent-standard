# GitHub Agent Standard — Setup Guide

This guide records the **human-side GitHub configuration** required by this standard. It exists so the same setup can be reproduced when this framework is adopted by another repository.

The repository files define Agent behavior; these GitHub settings provide the platform-side enforcement that an Agent cannot configure or reliably remember by itself.

## 1. One-time setup for a new repository

### A. Add the standard files

Copy the applicable files from this repository into the target repository, especially:

- `AGENTS.md` — repository operating rules.
- `AGENT_BOOTSTRAP_MEMORY.md` — external Agent bootstrap memory.
- `GOVERNANCE.md` — governance model and responsibilities.
- `REPOSITORY_INDEX.md` — generated repository structure index.
- `scripts/generate-repository-index.sh` — index generator.
- `.github/workflows/` — CI and governance workflows.
- `.github/ISSUE_TEMPLATE/` — Issue templates.
- `.github/PULL_REQUEST_TEMPLATE.md` — PR template.

Do not manually maintain `REPOSITORY_INDEX.md`; the generator and its workflow own it.

### B. Protect `main` with a Ruleset

For a single-user repository, use a **Ruleset** rather than relying only on Agent instructions.

Recommended baseline:

1. Repository → **Settings → Rules → Rulesets**.
2. Create a branch ruleset targeting `main`.
3. Require a pull request before merging.
4. Require the repository's required status check:
   - `governance-required`
5. Prevent normal direct pushes to `main`.
6. Do not require an independent human PR approval if the repository is intentionally operated by one person; otherwise the single-user workflow can deadlock.

The exact GitHub UI wording can change. Verify the resulting ruleset after saving it.

### C. Enable Actions permissions needed by generated-index automation

Repository → **Settings → Actions → General**.

Under workflow permissions, enable:

> **Allow GitHub Actions to create and approve pull requests**

This is required because the generated-index workflow creates a PR from its automation branch when `REPOSITORY_INDEX.md` needs updating.

### D. Create the governance confirmation Environment

Repository → **Settings → Environments**.

Create an Environment named exactly:

`governance-human-confirmation`

Configure:

- **Required reviewers:** the repository owner / human operator.
- **Prevent self-review:** **OFF** for the single-user model.

Why: governance-file changes are high-risk. The Agent may prepare and validate them, but the human must explicitly approve the GitHub Environment job. In a single-user repository, preventing self-review would create a deadlock because there is no second reviewer.

The Agent must never claim its own approval is human confirmation.

## 2. Normal day-to-day operation

For an ordinary change, the expected flow is:

`Issue → Branch → Change → CI → PR → Final Verification → Merge → Issue closed`

The human normally only needs to:

1. create or approve the Issue when appropriate;
2. answer questions when an Agent is `BLOCKED` or `DEFERRED`;
3. provide explicit confirmation for high-risk governance changes;
4. approve an Actions Environment job when GitHub asks for it.

The Agent is responsible for checking the repository rules before changing anything and for performing final verification before claiming completion.

## 3. What to do when GitHub Actions says “Awaiting approval”

This can occur when an automated workflow creates a PR and GitHub requires approval before the PR's workflow is allowed to run.

Open the PR and use GitHub's **Approve workflows to run** control when the run is trusted and expected.

This is a GitHub platform safety control, not a failure of the repository's governance rules.

## 4. What to do when a governance PR is waiting for human confirmation

For a PR that changes governance files or workflows:

1. Open the PR.
2. Check the diff and the PR description.
3. Confirm the proposed governance change is intentional.
4. In the Actions/environment approval UI, approve the `governance-human-confirmation` job.
5. Do not ask the Agent to fabricate or simulate that approval.

After approval, the Agent can continue with CI and Final Verification.

## 5. Required status-check configuration

The ruleset should require the repository's stable merge gate:

`governance-required`

Do not require a transient workflow run name, a test branch name, or an individual job that the repository may later rename unless the workflow contract explicitly guarantees that name.

When changing CI itself, verify the exact check name that GitHub reports before changing the ruleset.

## 6. If something is blocked

Do not weaken a rule just to make a PR merge.

Use these states:

- **BLOCKED:** an external permission, platform setting, human decision, or missing information is required.
- **DEFERRED:** the work is intentionally postponed and the next action is recorded.
- **COMPLETED:** only after the actual delivery condition and final verification pass.

A missing or untriggered CI check is **not** a pass.

## 7. Reusing this framework in another repository

The target repository needs two layers:

### Repository layer

Copy the standard's governed files and adapt only repository-specific values.

### Human/GitHub layer

Repeat the GitHub configuration in this document:

- `main` Ruleset;
- `governance-required` required status check;
- Actions permission to create/approve PRs;
- `governance-human-confirmation` Environment;
- required reviewer configuration appropriate to the repository's operator model.

The external Agent should load `AGENT_BOOTSTRAP_MEMORY.md` before working. The human operator should also retain this Setup Guide as the reusable checklist for configuring the GitHub side.

## 8. Single-user repository principle

This standard deliberately supports a repository operated by one human and one or more Agents.

It does **not** pretend that an Agent is an independent human reviewer.

Instead:

- automated CI provides repeatable technical checks;
- self-review provides a second pass by the same Agent, but is explicitly not independent approval;
- GitHub Environment approval provides the human decision point for high-risk governance changes;
- branch/ruleset protection prevents normal direct modification of `main`.

This gives a practical safety model without requiring a second GitHub account or paid plan.
