---
name: sdlc-tracker
description: Explain a project's SDLC as a page with a diagram plus plain words. Use when asked to map phases, milestones, or delivery flow into docs plus a visual.
license: MIT
metadata:
  version: "1.0"
---

# SDLC tracker

Generates an SDLC explanation page: a diagram plus further explanation in plain words. In practice, you can think of it as a map of how the work flows from idea to live, with each branch linking out to the detail.

Tone follows the same typed voice as tone-tweaks: short headings, short lists, no emojis, no HTML span or font tags, no em or en dashes, no stock AI words.

## Steps

### 1. Read the tracker

- Read the Linear project, its issues, and its milestones until you can list the phases in delivery order.
- Note status per phase (done, in progress, planned) and where each phase lives in the repo.

### 2. Write the mindmap doc

- Write `docs/SDLC_MINDMAP.md`, versioned per phase set (for example KEL version).
- Keep it short: one section per phase, each with what it does, its status, and links to the related issues or docs.

### 3. Build the Graphviz diagram

- Build `docs/sdlc-mindmap.gv`, then render `docs/sdlc-mindmap.svg` and `docs/sdlc-mindmap.png`.
- Keep the graph white and simple: one node per phase, edges in delivery order.
- Colour nodes per branch so each stream reads apart at a glance.
- Add links and tooltips on nodes pointing at the matching section in `SDLC_MINDMAP.md` or the Linear issue.

### 4. Build the page

- Build `netlify/index.html`: dark monochrome page with the SVG inlined so it stays interactive.
- Below the diagram, render one details block per phase (11 blocks in the KEL shape). Each block carries:
  - What
  - Why
  - Plain words version
  - Status
  - Where (links to code, docs, or Linear)
- Keep copy in the typed voice: short lines, plain words, inline definitions for unfamiliar terms.

### 5. Verify

- Check every link resolves (diagram nodes, details blocks, mindmap doc).
- Check widths: page readable at desktop and narrow widths, SVG scales without clipping, no sideways scroll.
- Open the built page locally before calling it done.

### 6. Deploy note

- Note how to deploy (for example Netlify drag and drop or CLI from the `netlify/` folder) and what URL it lands on.
- Record the deployed URL back in `docs/SDLC_MINDMAP.md` so the doc and the page point at each other.

## Next

After finishing, point at the three artifacts (mindmap doc, diagram files, page) and list what is next, usually review, deploy, and link from the README.
