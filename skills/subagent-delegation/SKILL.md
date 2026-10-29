---
name: subagent-delegation
description: Split work across parallel subagents with precise briefs, model choice, and naming. Use when a task breaks into independent items, a broad search, or a review across many files.
license: MIT
compatibility: Any agent that can spawn subagents. No network or extra tools needed.
metadata:
  version: "1.0"
  evals: evals/evals.json
---

# Subagent delegation

Fan out independent work, keep the briefs tight, and pick the model on purpose. The failure this skill prevents is a pile of parallel calls that each need a follow-up because the brief was vague.

## When to fan out

- Two or more independent items that share no state: separate repos, modules, files, or questions. Spawn one subagent per item, in parallel.
- Independent means one result does not change another's brief. If B needs A's answer, run A, then B. That is a real dependency, and serial is correct.
- Never serialise independent work to keep the transcript tidy. A run of sequential calls for parallel work is the cost this skill exists to remove.
- Never spawn a subagent for a single file read, one grep, or a question one tool call answers. The brief costs more than the work.

## Brief

Every brief carries four parts:

1. **Objective:** one sentence stating the outcome, not the activity.
2. **Output format:** the exact shape wanted back. A path, a bullet list with named fields, a JSON shape.
3. **Boundaries:** paths it may touch, and what it must not do. No installs, no commits, no global config, no scope creep into neighbouring files.
4. **Facts:** paths, versions, commands, and prior findings, so it does not re-explore what you already know.

Add the acceptance check when one exists: the test command that must pass, the route that must render, the count that must match.

Never send "look into X" or "improve Y" without a finish line. A subagent that has to guess the finish line returns something you have to redo.

## Naming

Name every subagent as `Role: work (Model)`.

- **Role:** the agent type or job. `reviewer`, `tester`, `docs`, `researcher`.
- **Work:** three to five specific words. `audit auth middleware`, not `help with backend`.
- **Model:** the model short id actually used, or `default` when the spawn inherits the parent's model.

Examples: `tester: run API suite (default)`, `researcher: compare two SDKs (claude-sonnet-4-6)`.

## Model choice

- Bounded edits, searches, and mechanical checks: the fast default model.
- Ambiguous design, security review, or cross-file reasoning: the strong model.
- A hard problem already stuck on a small model: do not resend the same brief to the same model. Get a second opinion from a stronger model and pass the full context: original objective, what was tried, the exact error or wrong output, the files involved, and the constraints.

A second opinion without the failed attempt is a restart, not a second opinion.

## Collecting results

- Spawn all independent subagents in one block, then wait. Do not interleave them with work that depends on them.
- Read each result against its output format. A result that misses the format gets one follow-up naming the gap. Do not rewrite the whole brief.
- Merge in the main thread. When two subagents disagree, report the conflict instead of silently picking one.

## Reporting

Follow the finished-work block in `kelp-comms` when it is installed. Otherwise state what changed, how it was checked, and what is still unverified.

## Scope

Applies whenever this session fans work out to subagents. The user's rules win over this file.
