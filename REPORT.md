# Build report: design-engineering-harness v0.2.0

Live repo: https://github.com/itsaibarr/design-engineering-harness (public, MIT, `master` at `e031651`). Install with `git clone` plus `./install.sh`, which copies 8 skills and 6 commands into `~/.claude/`. The repo holds 39 files. All 9 knowledge sources were read in-session before use. This report follows two writing guides the reader picked: unslop (plain words, numbers, no filler) and i-have-adhd (action first, numbered steps, one next step at the end).

## 1. What exists

Build skills (720 lines total across 5 files):

| File | Lines | Job |
|---|---|---|
| `skills/de-component/SKILL.md` | 87 | Component anatomy, states, keyboard contract |
| `skills/de-motion/SKILL.md` | 120 | Animation build, review, GSAP rules |
| `skills/de-feel/SKILL.md` | 82 | Polish pass, quick and full modes |
| `skills/de-a11y/SKILL.md` | 82 | Accessibility audit and targeted fixes |
| `skills/de-type-space/SKILL.md` | 89 | Type scale, spacing grid, rendering rules |

Direction and review skills:

| File | Lines | Job |
|---|---|---|
| `skills/de-taste/SKILL.md` | 88 | Brief to mood to tokens |
| `skills/de-critique/SKILL.md` | 85 | Review with Block or Approve verdict |
| `skills/de-site/SKILL.md` | 87 | Personal website sections in order |

Commands (44 lines total): `de-start`, `de-build-component`, `de-polish`, `de-a11y-audit`, `de-critique`, `de-site-section`. Each file holds a description plus one Skill invocation, 7 to 9 lines.

Reference files (612 lines total):

| File | Lines | Content |
|---|---|---|
| `references/values.md` | 99 | 43 magic numbers plus 15 GSAP rows, each tagged with its source |
| `references/teardowns/segmented-control.md` | 139 | Full component teardown plus a reusable template |
| `references/annnimate.md` | 130 | GSAP library guide with licensing guardrails |
| `references/patterns.md` | 78 | 21 AI interface patterns with quality cues |
| `references/tokens.md` | 88 | Token system exemplar and capture format |

Plus `references/inspiration.md` (78 lines, 16 rated posts by genre).

Adaptive layer and gates (487 lines): `detect.sh` prints framework, styling, animation, and components for any target dir; `routing.md` maps 8 task types to skills with a 3 skill cap; `project-profile.md` template; `decisions.md` promotion rules; `personal-website.md` preset; `checklist.md` blocking checks; `critique-rubric.md` severity tiers and verdict ladder; `audit.sh` 7 grep rules with exit 0 clean and exit 1 findings.

Research and docs: `research/ledger.md` (350 lines, 9 sources), `research/synthesis.md`, `research/foundation-audit.md`, `verification/report.md`, `ARCHITECTURE.md`, `README.md`, `SOURCES.md`, `CHANGELOG.md`, `LICENSE`, `install.sh`.

## 2. How we built it

1. Phase 0 preflight. Confirmed git, `gh auth`, node 24, npm 11. Created the working dir and ran `git init`. Recorded the stack preset (Next.js, Tailwind, Motion, shadcn) and the target agents.
2. Phase 1 research. Four parallel lanes read all 8 sources: emilkowalski/skills at `2d22863` (15 skill dirs, MIT), ibelick/ui-skills at `c628a59` (8 skills, MIT), both ui-skills pages, floguo notes, BoardUI segmented control, BeautifulUI (21 sections), Inspora Web category. Inspora detail pages returned 429 to curl, so a real browser session read all 16 posts, and BoardUI install was re-read the same way. Every source landed in `research/ledger.md` with fetch method, timestamp, status, and quoted takeaways.
3. Phase 2 foundation audit. Cloned itsaibarr/harness at `94a89ed`, mapped core versus modules, skill and command formats, and the installer pattern into `research/foundation-audit.md`. Found no LICENSE file in that repo.
4. Phase 3 design. Wrote `ARCHITECTURE.md` (8 skills, reference set, traceability matrix, adaptive layer, 6 commands, gates) and held it for approval before building.
5. Phase 4 build. Four parallel lanes wrote skills, references, adaptive plus gates plus commands, and docs with non-overlapping file scopes. Reconciled the results, fixed a stray path, committed `31e2a48`.
6. Phase 5 verify. Built the same segmented control in two sandboxes. Tailwind lane: detector printed `tailwind v4.0.0` plus `react-aria`, audit exited 0 on the first run. Plain CSS lane: detector printed `plain css`, audit went 1 finding to 0, `tsc --noEmit` exited 0. Fixed a real detector bug (`react-aria-components` did not match) and committed `d403ed1`.
7. Phase 6 publish. Added MIT LICENSE, created the public repo, pushed, cloned fresh to /tmp, and ran the installer and detector from the clone. Committed `93ccdec`.
8. S9 integration. Read 17 Annnimate pages (learn concepts, patterns, docs, MCP guide, terms). Added `references/annnimate.md`, a GSAP section in de-motion, GSAP rows in values and routing, `@gsap/react` detection, and ledger plus docs entries. Committed `e031651` and pushed after approval.

## 3. How the harness runs

1. Run `./install.sh` once per machine.
2. Run `/de-start` in a project. It detects the stack, interviews for the profile, and routes the task.
3. The routed skills do the work, capped at 3 per task.
4. `audit.sh` plus `checklist.md` gate the output before it counts as done.
5. Corrections go in `decisions.md`. A correction updates the profile after it recurs twice.

## 4. Verification numbers

Detector: Tailwind fixture prints 4 correct axes, exit 0. Plain CSS fixture prints `plain css` plus `react-aria`, exit 0. Idempotent across reruns. Audit: Tailwind component 0 findings first run. CSS component 1 finding (a doc comment containing the banned phrase) to 0 after a reword. Frontmatter: 14 of 14 files carry the required keys. Installer: 8 skills and 6 commands installed, second run skips all 14. Coverage: 9 of 9 sources mapped to artifacts, 0 orphan skills. Injection scan: only defensive clauses found, none followed.

## 5. Limits

1. No browser runtime checks ran. Keyboard, contrast, and hit areas were verified by reading, not measuring.
2. Inspora motion detail stays at description level. No video was frame analyzed.
3. `audit.sh` matches lines, so it can flag rule documentation. No suppression IDs exist yet.
4. The detector lists no primitive inventory. It cannot name ToggleButtonGroup props.
5. Two Tailwind sandbox lanes errored with no output. The run was done directly instead. The cause is unknown.

Next: run `/de-start` on the personal website, then `/de-site-section hero`.
