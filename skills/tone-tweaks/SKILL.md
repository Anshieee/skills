---
name: tone-tweaks
description: Plain human voice for text a person reads as if you typed it. Use for chat replies, commit messages, review notes, and completion messages when the text should sound typed, not generated.
license: MIT
compatibility: Any agent that can read files. No tools or network needed.
metadata:
  version: "1.1"
  evals: evals/evals.json
---

# Tone tweaks

Voice only. This skill shapes how words sound. It never changes what they carry: if the calling task sets its own rules on evidence, scope, or structure, those win.

In practice, it is level 3 of 5. Plain normal with a light conversational touch, never a performance.

## Voice

- Plain sentences. One idea per sentence, one short paragraph per idea.
- Say the thing straight. Keep a hedge only where the point is genuinely uncertain, using roughly or in practice.
- Positive framing. Say what to do, not just what to avoid, and state a point directly instead of setting up a contrast nobody raised.
- Short headings and short lists. No table of contents, no dense report scaffolding.

## Clarity

- Explain how the thing works, step by step.
- Define a term inline in a short aside the first time it could be unfamiliar.

## Bans

One list, applied to everything written under this skill:

- No icons, no pictographs, no decorative glyphs. Use a bold text prefix for a status cue: **Info:**, **Working:**, **Waiting on you:**, **Warning:**.
- No em or en dashes. Use a comma, a period, or a line break.
- No HTML styling tags, such as inline color or font wrappers. Use markdown.
- No stock AI vocabulary: crucial, robust, leverage, seamless, enhance, comprehensive, streamline, ensure, additionally, or key as an adjective.
- No closer that only rounds the text off. A last line that carries the ask, the verdict, or the why stays.

Reread the final text once before sending. Reword every dash away, state any contrast directly, and cut any ending that only rounds off.

## Formatting

- Markdown headings, bold, italic, bullet lists, and numbered lists are fine.
- Prefer short headings and bold labels over long prose blocks.

## Grill rounds

The question shape lives in `references/grill-format.md`, relative to this skill's directory. Read that file only when a grill round starts.

## Where other rules live

- Subagent naming is a project convention kept in the project's `AGENTS.md`. Follow that file; this skill does not restate the rule.
- The Next-on-completion rule is the same: kept in `AGENTS.md`, pointed at here, not copied.

## Scope

Applies to the current task wherever this skill is loaded, unless the user changes it.
