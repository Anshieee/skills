# Skills

A home for reusable agent skills: instructions and workflows that load into a coding agent's context when a task matches them.

Every skill here installs and runs on its own. None of them needs another skill from this repo to produce its artifact.

## Install

Project scope, one agent (`opencode` here; use any detected agent name):

```sh
npx skills add Anshieee/skills --skill <name> -a opencode
```

Project scope, every detected agent:

```sh
npx skills add Anshieee/skills --skill <name> -a '*'
```

Global scope:

```sh
npx skills add Anshieee/skills --skill <name> -a opencode -g
```

A project install lands in `./.agents/skills/<name>/`, which the chosen agent reads. A global install lands in `~/.agents/skills/<name>/`.

Add `-y` to skip the confirmation prompt. List what is available first with:

```sh
npx skills add Anshieee/skills -l
```

## Install matrix

| Skill | Standalone | Pair with | Prereqs |
| --- | --- | --- | --- |
| tone-tweaks | yes | any skill that writes prose | none |
| review-writeup | yes | tone-tweaks for voice | `git`; `gh` for PR diffs, optional |
| sdlc-tracker | yes | tone-tweaks for voice | `git`; Linear, `dot`, and a static host are optional and detected at runtime |

Pairing is a quality choice, not a dependency. A missing pair changes the fallback, never whether the skill finishes.

```sh
# Pair example: review writeups with the shared voice
npx skills add Anshieee/skills --skill review-writeup -a opencode
npx skills add Anshieee/skills --skill tone-tweaks -a opencode
```

### tone-tweaks

Prereqs: none.

Plain human voice for anything a person reads as if you typed it: chat replies, commit messages, review notes, completion messages. It points at `AGENTS.md` for subagent naming and the Next rule instead of copying them.

### review-writeup

Prereqs: `git`. `gh` only for PR diffs.

Turns a review into a file a teammate can read without the diff open. One file per phase under `reviews/`, named by issue key, PR number, or branch. Voice comes from tone-tweaks when present, with a three-line fallback when it is not.

### sdlc-tracker

Prereqs: `git`. Linear, `dot` (graphviz), and a static host are optional.

Explains a project's delivery lifecycle as a doc plus a diagram, with an optional page. Four ports (source, diagram, publish, voice) each carry a contract, a default, a fallback, and a provenance line, so a run with no Linear, no Graphviz, and no host still produces the doc and a Mermaid diagram.

## Layout

Skills live at `skills/<name>/SKILL.md`. The installer scans that path, so `--skill <name>` resolves the skill directly and does not rely on a fallback.

```text
skills/
  tone-tweaks/
    SKILL.md
    references/grill-format.md
    evals/evals.json
  review-writeup/
    SKILL.md
    evals/evals.json
  sdlc-tracker/
    SKILL.md
    references/worked-example.md
    scripts/render.sh
    scripts/check-links.sh
    evals/evals.json
```

## License

MIT. See `LICENSE`.
