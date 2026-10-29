---
name: review-writeup
description: Write a code review writeup a teammate can read without the diff open. Use when asked for review notes, a phase review, or a writeup under reviews/.
license: MIT
compatibility: Any agent with shell access for git and the repo's own check commands. `gh` is optional; without it, review a local diff.
metadata:
  version: "1.1"
  evals: evals/evals.json
---

# Review writeup

Turns a review into a file a teammate can follow without the diff open. Part checklist, part writeup: find the real problems, rank them, skip padding, then write it so it stands alone.

## Install

Project scope, one agent:

```sh
npx skills add Anshieee/skills --skill review-writeup -a opencode
```

Project scope, every detected agent:

```sh
npx skills add Anshieee/skills --skill review-writeup -a '*'
```

Global scope:

```sh
npx skills add Anshieee/skills --skill review-writeup -a opencode -g
```

A project install lands in `./.agents/skills/review-writeup/`, which the chosen agent reads. A global install lands in `~/.agents/skills/review-writeup/`.

## Voice

Use tone-tweaks when it is installed.

If it is not: plain sentences with one idea each, no icons and no em or en dashes, and file or symbol names in backticks.

## Diff source

Pick the source from what the user gave you:

| Situation | Command |
| --- | --- |
| Branch versus main | `git diff main...HEAD` (or `origin/main...HEAD`) |
| Pull request | `gh pr diff <number>` |
| Uncommitted work | `git diff` and `git diff --staged` |
| Files only, no repo | ask for a pasted diff |

Use `...` so the comparison starts at the merge base, which keeps unrelated main commits out.

## Phase naming

Name the file `reviews/<name>.md`. Derive `<name>` from the phase key in this order:

1. The issue key, lowercased, when one exists: `reviews/issue-87.md`.
2. The pull request number: `reviews/pr-142.md`.
3. The branch name, with slashes turned into hyphens: `reviews/feat-billing-export.md`.

Keep one file per phase. Same phase, same name, so a rerun overwrites instead of piling up variants.

## Before writing

Ask once, then proceed:

- Confirm the path, defaulting to `reviews/<name>.md`.
- Confirm one file or one per phase, when the request covers several.

Do not ask again after that. Create `reviews/` if it is missing.

## Output shape

```markdown
# Review: <phase>

## What it does

Two or three sentences a reader can follow with the diff closed.

## Read order

1. `path/to/first`
2. `path/to/second`

## Commands

- `git diff main...HEAD`
- `npm test`

## What to check

Findings by weight. Each names the file and the reason in plain words.

## Blockers vs non-blockers

**Blockers**
- Stops the merge.

**Non-blockers**
- Can land as a follow up.

## Merge order

What lands first, what waits, and why in one line each.
```

## Redaction

Record the command, not its output. Never paste:

- file contents from `.env` or any secret store
- tokens, keys, cookies, or session values
- URLs that carry a query string; strip to the path

If evidence matters, name the check and its pass or fail, not the raw dump.

## How to work

1. Read the diff and the nearby code until you can say what the change does in plain words.
2. Run the checks that fit the repo (tests, lint, typecheck). Put the exact command under Commands. When none applies, use one line: `Checks: none ran. Reason: docs only, no test target.`
3. Rank findings by weight. A wrong behaviour or a broken path outranks style. Say what breaks without the change, grounded in the code.
4. Split blockers from non-blockers. A blocker breaks behaviour, loses data, or opens a wrong path for users. The rest is a non-blocker with a suggested home.
5. Close with merge order: what lands first, what waits, and why in one line each.

## Next

Point at the file, name the closest blocker or the merge order in one line, then list what is next.
