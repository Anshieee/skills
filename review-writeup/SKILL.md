---
name: review-writeup
description: Write a code review writeup a teammate can read without the diff open. Use for any code review writeup, review reply, or phase review file in reviews/.
license: MIT
metadata:
  version: "1.0"
---

# Review writeup

Invoked for any code review writeup. When the user asks for a review, a review writeup, review notes, or a phase review, load this skill and follow it end to end.

In practice, you can think of this skill as a hybrid: part checklist (find the real problems, rank them, skip padding) and part writeup (turn findings into something a teammate can follow on its own). Direct about what is broken, fair about what is not.

## Tone

Write the review so it reads typed, not generated:

- Short, plain sentences. One idea per short paragraph.
- No emojis, no HTML span or font tags, no em or en dashes.
- No stock AI words: crucial, robust, leverage, seamless, enhance, comprehensive, streamline, ensure, additionally, or key as an adjective.
- Name files and symbols in backticks where they render.
- If the tone-tweaks skill is installed, you can apply it on top for voice polish. What to say still comes from this skill.

## Output shape

One file per phase under `reviews/`, named for the phase, for example `reviews/KEL-6.md`.

Use this template for each file:

```markdown
# Review: <phase>

## What it does

Short plain summary of the change in two or three sentences.

## Read order

Numbered list of files or diffs in the order a reader should go through them.

## Commands

Commands used to verify, so the reader can repeat them.

## What to check

 Findings ordered by weight, each with the file and the reason in plain words.

## Blockers vs non-blockers

Two short lists. Blockers stop the merge. Non-blockers can land as follow ups.

## Merge order

The order phases should merge in, plus anything that must wait on something else.
```

## How to work

1. Read the diff and the surrounding code until you can state what the change does in plain words.
2. Run the checks that fit the repo (tests, lint, typecheck) and note the exact commands under Commands.
3. Rank findings by weight. A wrong behavior or a broken path outranks style. Say what breaks without the change, grounded in the code.
4. Split blockers from non-blockers. A blocker is something that breaks behavior, loses data, or opens a wrong path for users. The rest is a non-blocker with a suggested home.
5. Close with merge order: what lands first, what waits, and why in one line each.

## Next

After writing the file, point the user at it and name the closest blocker or the merge order in one line, then list what is next.
