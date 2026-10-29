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
| kelp-comms | yes | any skill that writes a reply | none; a browser is optional, only for the UX check |
| subagent-delegation | yes | kelp-comms for the reply shape | an agent that can spawn subagents |

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

### kelp-comms

Prereqs: none.

```sh
npx skills add Anshieee/skills --skill kelp-comms -a opencode
```

Reply shape that applies to every message. It opens with the answer in one to three sentences, then limits the body to decisions, risks, and checks. Code appears only on request, terms get one clause of jargon, and finished work reports what it does, a demo, and the risks. It also carries the trash-over-`rm` rule and the browser check for anything a person sees.

### subagent-delegation

Prereqs: an agent that can spawn subagents.

```sh
npx skills add Anshieee/skills --skill subagent-delegation -a opencode
```

How to fan out without follow-up churn. Independent items go to parallel subagents, never serial calls. Single file reads stay in the main thread. Every brief states an objective, an output format, boundaries, and the facts it needs, and every subagent is named `Role: work (Model)`. A hard problem stuck on a small model gets a second opinion from a stronger one, with the failed attempt attached.

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
  kelp-comms/
    SKILL.md
    evals/evals.json
  subagent-delegation/
    SKILL.md
    evals/evals.json
```

## Credits

These skills borrow shape, not code. The sources below shaped the wording, the structure, or both.

| Source | What it informed |
| --- | --- |
| [use-conversational-language](https://github.com/eai-org/agent-toolkit/tree/main/skills/use-conversational-language), eai-org | Voice levels and the rules for text a person reads as if you typed it. Basis for `tone-tweaks` and the voice section of `kelp-comms`. |
| [wrap-up](https://github.com/rohitg00/pro-workflow/tree/main/skills/wrap-up), rohitg00 | The end-of-task block: what changed, how it was checked, what is unverified. Basis for the finished-work section of `kelp-comms`. |
| [Anthropic: Claude Code best practices](https://www.anthropic.com/engineering/claude-code-best-practices) and the [Agent Skills specification](https://agentskills.io/specification), with [anthropics/skills](https://github.com/anthropics/skills) | Frontmatter fields, the `skills/<name>/SKILL.md` layout, and description wording that drives auto-invocation. |
| [Vercel skills](https://github.com/vercel-labs/skills) and [skills.sh](https://skills.sh) | Install conventions: `npx skills add`, project and global scope, the `-a` agent flag, and the `-l` listing. |
| [debs-obrien/agent-skills](https://github.com/debs-obrien/agent-skills) | Skill folder structure and worked examples for trigger descriptions. |
| [ClawHub](https://clawhub.ai) | Registry browsing and the naming habits used across published skills. |
| [Matt Pocock skills](https://github.com/mattpocock/skills) | Writing for agents: short trigger descriptions, instructions over prose, and the no-em-dash house style. |

## License

MIT. See `LICENSE`.
