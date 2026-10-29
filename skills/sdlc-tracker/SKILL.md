---
name: sdlc-tracker
description: Explain a project's software delivery lifecycle as a doc, a diagram, and an optional page in plain words. Use when asked to map phases, milestones, or delivery flow into docs plus a visual.
license: MIT
compatibility: Any agent that can read repo files and run shell commands. Linear, Graphviz, and a static host are optional and detected at runtime; nothing needs network access for the default run.
metadata:
  version: "1.1"
  evals: evals/evals.json
---

# SDLC tracker

Turns how work flows from idea to live into a doc, a diagram, and optionally a page. Each phase links out to its detail.

Four ports decide how a run behaves: source, diagram, publish, voice. Each port has a contract, a default, a fallback, and a provenance line. Fill what you have, fall back on the rest, and record which path you took.

Paths like `scripts/render.sh` and `references/worked-example.md` are relative to this skill's directory.

## Ports

| Port | Contract (must hold) | Default | Fallback | Provenance |
| --- | --- | --- | --- | --- |
| source | Phases in delivery order, each with status (done, in progress, planned) and a repo anchor | Linear project, issues, and milestones, when a Linear tool is connected | Read `docs/`, then `README.md`, then `git log --oneline -50`. Ask at most one clarifying question | One line naming the source and its date |
| diagram | One node per phase, edges in delivery order, every node links to its doc section, no clipping at any width | Mermaid in `<out>/sdlc-map.mmd`, which GitHub and most doc viewers render | Graphviz when `dot` is on PATH. Otherwise keep the `.gv` file and add a not-rendered note | One line naming the format and whether it rendered |
| publish | Optional. Confirm first. `https` only hrefs, escaped labels, `noindex` meta | No upload. Keep files local under the output dir | Skip publish and say so | One line with the URL, or "not published" |
| voice | Plain words, at least three lines per phase (what it does, why it matters, where it lives) | The three-line floor in step 7 | If tone-tweaks is installed, its voice rules shape the wording and the floor relaxes | One line naming which voice was used |

`auto` behaviour: source is Linear when a tool is connected, else docs and git log. Diagram stays Mermaid unless you ask for Graphviz, because Mermaid needs no local tool.

## Parameters

No path, project name, or phase count is baked in. Pass these flags or accept the defaults:

| Flag | Default | Meaning |
| --- | --- | --- |
| `--doc` | `docs/SDLC_MAP.md` | doc path |
| `--out` | `docs/` | diagram and asset dir |
| `--site-dir` | `site/` | page dir when publishing |
| `--source` | `auto` | `auto`, `linear`, or `docs-git` |
| `--diagram` | `mermaid` | `mermaid` or `graphviz` |
| `--publish` | `none` | `none` or `static` |
| `--title` | repo name plus " SDLC" | doc and page title |
| `--phases` | detected | comma list that overrides detection order |

The number of phases and details blocks follows `--phases` or detection. Never hardcode a phase count.

## Steps

### 1. Resolve the ports

Pick source, diagram, publish, and voice from the flags and from what is installed. Write down the four provenance lines before writing anything else.

Source detail:

- With Linear: read the project, its issues, and its milestones until you can list phases in delivery order.
- Without Linear: read `docs/`, `README.md`, and `git log --oneline -50`. Infer the phases from docs and history. Ask at most one question, for example whether the doc or the git history is the truer order.
- Never block on Linear. The run must finish with docs and git alone.

### 2. Gather phases

List phases in delivery order with status and a repo anchor for each. Note where each phase lives: directory, doc, or issue.

### 3. Write the doc

Write `--doc` with this header, then one section per phase:

```markdown
# <title>

Updated: <YYYY-MM-DD>
Source: <the provenance line>
Diagram: <the provenance line>
Voice: <the provenance line>
Publish: <the provenance line>

## Phase: <name>

- What: <one line>
- Why: <one line>
- Where: <path or issue>
- Status: <done | in progress | planned>
```

Anchor each phase heading so diagram nodes can link to it.

### 4. Build the diagram

- Mermaid default. Write `<out>/sdlc-map.mmd` with `flowchart TD`, one node per phase, a subgraph per stream. Keep node labels escaped so `&`, `<`, `>`, and quotes render. Link each node to its doc anchor.
- Graphviz on request. If `command -v dot` succeeds, write `<out>/sdlc-map.gv` and run `scripts/render.sh <out>/sdlc-map.gv` to get svg and png. Add node URLs and tooltips that point at the doc sections and the per-stream colours.
- If `dot` is missing, still write `<out>/sdlc-map.gv`. Add a line to the doc: "Diagram not rendered. Install graphviz and run `scripts/render.sh <out>/sdlc-map.gv`, or use the Mermaid default." Never claim a rendered file that does not exist.

### 5. Build the page (optional)

Only when `--publish static` or the user asks for a page:

- Write `--site-dir/index.html`. Inline the diagram so it stays interactive, then one details block per phase with What, Why, Plain words, Status, and Where.
- Add `noindex` meta: `<meta name="robots" content="noindex">`.
- Escape every label. A raw `&`, `<`, `>`, or quote in a phase name breaks the page.
- Keep every href `https://`. No `http://`, no protocol-relative links, no `javascript:` URLs.
- Confirm once before any upload, naming the host and the target directory.
- Record the URL, or "not published", in the doc header.

### 6. Verify

- Run `scripts/check-links.sh <doc> [page]` and fix every missing local link.
- For Graphviz, confirm `scripts/render.sh` reported the output files.
- Check widths: readable at desktop and narrow widths, diagram scales without clipping, no sideways scroll.
- Open the built page locally before calling it done.

### 7. Report

Point at the artifacts and paste the four provenance lines. Then list what is next.

Suggested voice floor, when tone-tweaks is not installed: short plain sentences, one idea each, no icons, no em or en dashes, and a definition inline the first time a term could be unfamiliar.

## Worked example

`references/worked-example.md` runs one generic project from prompt to three artifacts with no Linear and no Graphviz.

## Next

Name the artifacts (doc, diagram, page if any), the four provenance lines, and the immediate next steps in order, usually review, publish, and a README link.
