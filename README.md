# GitHub Agent Standard

A lightweight, issue-driven governance framework for AI agents operating Git repositories.

## What this solves

AI agents can be good at writing code while still making poor repository decisions: skipping Issues, editing `main` directly, treating an unrun check as a pass, closing work too early, or continuing when they are blocked.

This framework separates responsibilities:

- **Repository rules** define what an agent must do inside the repository.
- **External bootstrap memory** reminds an agent that it must load those rules before it works here.
- **GitHub Actions and Rulesets** provide technical enforcement where possible.
- **Final Verification** treats the resulting GitHub state as evidence instead of trusting an agent's claim of completion.

The goal is not perfect security. The goal is to make normal, careless, incapable, or mildly non-compliant agents fail safely instead of silently damaging the repository.

## Core workflow

```text
Issue → Bootstrap Memory → AGENTS.md → Branch → Change → CI → PR → Ruleset → Final Verification → Merge → Issue closed
```

If required rules cannot be loaded, required evidence cannot be obtained, permissions are insufficient, or the user explicitly defers the work, the agent must stop rather than improvise.

## Adoption levels

### Level 1 — Minimum baseline

For small personal projects:

```text
README.md
AGENTS.md
AGENT_BOOTSTRAP_MEMORY.md
.github/workflows/governance-gate.yml
```

Configure a `main` Ruleset requiring pull requests and the actual `governance-required` status check.

### Level 2 — Standard (recommended)

Add:

```text
GOVERNANCE.md
REPOSITORY_INDEX.md
scripts/
.github/ISSUE_TEMPLATE/
.github/pull_request_template.md
```

Generate the repository index from its source/generator; do not maintain it manually.

### Level 3 — Hardened

For production or higher-risk repositories, add appropriate controls such as `CODEOWNERS`, `SECURITY.md`, protected environments, release controls, rollback procedures, and stricter review requirements.

Choose controls according to risk rather than adding complexity for its own sake.

## Adopt the framework in a new repository

1. Create the GitHub repository and initialize `main`.
2. Copy the appropriate standard files from this repository.
3. Put repository-specific operating rules in `AGENTS.md`; do not turn README into a second rulebook.
4. Put the external bootstrap instruction in `AGENT_BOOTSTRAP_MEMORY.md` and copy that instruction into the memory/project-instructions area of each agent you use.
5. Enable GitHub Actions.
6. Create a `main` Ruleset requiring pull requests and the real status check named `governance-required`.
7. Run the workflow on a PR before configuring the required check, so the exact check name exists.
8. Complete a small test Issue through Issue → Branch → PR → CI → Final Verification → Merge.
9. Confirm that an intentionally failing required check prevents merging.
10. Confirm that a successful merged PR closes its Issue.

### Required status checks

Do not guess a check name. GitHub Rulesets require the check name produced by Actions. Run the workflow first and use the exact resulting check name; this standard currently uses `governance-required`.

## Working with an agent

Give the agent an Issue, not an instruction to freely edit `main`.

Example:

> Work on Issue #123. Follow the repository governance rules and report BLOCKED or DEFERRED rather than claiming completion when required evidence is unavailable.

Before changing anything, the agent must load `AGENT_BOOTSTRAP_MEMORY.md` and the applicable repository rules. If it cannot load them, it must not modify the repository.

The normal lifecycle is:

```text
Issue → Branch → Change → Validate → PR → Review → Merge → Final Verification
```

## Single-user repositories

The framework supports a single owner. Ordinary code changes do not need an artificial second reviewer. Self-review may be used where the Ruleset permits it, but an agent must never pretend that its own review is an independent human approval.

Governance/control-plane changes should receive stronger protection than ordinary code because they can change the rules that constrain the agent itself. The exact high-risk mechanism depends on the repository's GitHub features and ownership model.

## Final Verification

`COMPLETED` is an agent statement, not proof.

Completion should be established from durable repository state, including as applicable:

- final PR HEAD SHA;
- actual diff;
- required Actions checks;
- Ruleset mergeability;
- merge result;
- final state of the linked Issue;
- generated-file consistency; and
- required deployment or release evidence.

If evidence is missing or stale, the correct state is not `COMPLETED`; it is normally `BLOCKED` or another explicitly documented non-complete state.

## Troubleshooting

**`governance-required` does not appear in Rulesets**

Run the workflow on a PR first. Then use the exact check name GitHub reports. A required check that has never actually run is not evidence of success.

**A PR is blocked unexpectedly**

Check the PR's latest HEAD, all required checks, Ruleset conditions, and review requirements. Do not rely on an older successful run after the PR changes.

**An agent cannot continue**

If it lacks permissions, cannot load required rules, cannot obtain required evidence, or needs a human decision, it should record what is complete, what is blocked, why, and the next action. Do not force a false completion.

**The repository index is stale**

Do not manually edit the generated index. Change its source/generator and regenerate it through the repository's defined workflow.

## New-repository checklist

- [ ] Create GitHub repository
- [ ] Add `AGENTS.md`
- [ ] Add `AGENT_BOOTSTRAP_MEMORY.md`
- [ ] Add `GOVERNANCE.md` for Level 2+
- [ ] Add governance workflow
- [ ] Add Issue templates
- [ ] Add PR template
- [ ] Add repository-index generator for Level 2+
- [ ] Generate `REPOSITORY_INDEX.md`
- [ ] Run Actions successfully at least once
- [ ] Configure `main` Ruleset
- [ ] Require the real `governance-required` check
- [ ] Test a normal PR
- [ ] Test a failing PR
- [ ] Verify final Issue lifecycle
- [ ] Verify the agent can load external bootstrap memory

## Repository roles

| File | Purpose |
| --- | --- |
| `README.md` | Human adoption and setup guide |
| `AGENT_BOOTSTRAP_MEMORY.md` | External reminder that must be loaded before repository work |
| `AGENTS.md` | Repository-specific operating rules |
| `GOVERNANCE.md` | Governance model and rationale |
| `REPOSITORY_INDEX.md` | Machine-generated repository structure index |
| `.github/workflows/` | Automated validation and enforcement |
| `.github/ISSUE_TEMPLATE/` | Standardized work intake |
| `.github/pull_request_template.md` | Standardized change/review evidence |
| `scripts/` | Generators and repository automation |

## Design principle

**Use the simplest control that reliably prevents the failure.** Rules should guide agents. GitHub should enforce what GitHub can enforce. Automation should produce evidence. Humans should only be required where the risk justifies human judgment. When the system cannot safely decide, the agent should stop rather than guess.