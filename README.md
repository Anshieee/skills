# Skills

A home for reusable agent skills: instructions and workflows that get loaded into a
coding agent's context when a task matches them.

## Skills in this repo

### tone-tweaks

Plain human chat voice for anything a person reads as if you typed it: chat replies,
grill questions, review threads, commit messages. Carries the global voice override
(conversational level 3, grill question format, what is next rule).

```sh
npx skills add Anshieee/skills --skill tone-tweaks
```

### review-writeup

Turns a code review into a writeup a teammate can read without the diff open. One file
per phase under `reviews/` with What it does, Read order, Commands, What to check,
Blockers vs non-blockers, and Merge order.

```sh
npx skills add Anshieee/skills --skill review-writeup
```

### sdlc-tracker

Explains a project's SDLC as a page with a diagram plus plain words. Reads the Linear
project, writes `docs/SDLC_MINDMAP.md`, builds a Graphviz diagram
(`docs/sdlc-mindmap.gv/svg/png`), and builds `netlify/index.html` with the inline
interactive SVG plus details blocks.

```sh
npx skills add Anshieee/skills --skill sdlc-tracker
```

## Layout

Each skill lives in its own directory with a `SKILL.md`:

- `tone-tweaks/SKILL.md`
- `review-writeup/SKILL.md`
- `sdlc-tracker/SKILL.md`
