# Project Profile — <project name>

**Provenance: original synthesis** (interview pattern adapted from foundation `interview-me`; values from
ARCHITECTURE.md §4 and the synthesis defaults). Template only — no source text copied.

**Where it lives:** this file is copied into the **target project** (project root or `docs/`), never kept in
the harness. **How it is filled:** `/de-start` asks one question at a time (one Q + one guess, stop when
confident) and writes your answers into the sections below. Re-run `/de-start` to revise; edit by hand any
time — it is yours, not the skill's. Every downstream skill reads this file first and treats it as the
override over harness defaults.

---

## Principles

*Filled by interview: "What must this interface never do?" / "What is the one thing this product is for?"*

- Primary goal of this project:
- Non-goals (never build these):
- House rules the user repeats (see `decisions.md` for the log):

## Tone

*Filled by interview: "If this UI were a person writing copy, who would it be?" — pick concrete adjectives
and one anti-adjective.*

- Voice/adjectives:
- Anti-tone (explicitly not):
- Copy rules (sentence case? emoji? jargon allowed?):

## Motion budget

**Default: restrained** (synthesis conflict resolution #1 — justified motion allowed by the frequency gate,
the "no animation unless requested" stance is this preset's default, opt in per surface).

- Budget level: `restrained` (default) | `standard` | `expressive`
- Surfaces allowed extra motion (explicit opt-in list):
- Never animate (high-frequency actions, this project's list):

## Density

- Touch hit area minimum: **44px** (default)
- Dense desktop UI minimum: **40px**
- Exceptions (toolbars, tables, chips) and why:

## Brand direction

*Filled by interview: "What should a visitor feel in the first 3 seconds?" — for sites, start from
`presets/personal-website.md` and adjust.*

- Positioning / one-liner:
- Visual keywords (color, type character, illustration vs. photography):
- References the user admires (with what to borrow from each):
- Accent/token direction (if decided):

## Accessibility level

*Filled by interview: "Who must this work for, and to what bar?"*

- Level: `WCAG 2.2 AA` (default) | `AA + named extras` | `best effort (say so explicitly)`
- Named extras (screen-reader flows, reduced-motion strictness, RTL, zoom):
- Manual verification evidence required (screenshots, keyboard pass) — yes/no:

## Stack summary (from `detect.sh`)

*Filled automatically by `/de-start` — rerun `detect.sh` after dependency changes.*

- framework:
- styling:
- animation:
- components:

---
*Status: original synthesis template. Section defaults must match `adaptive/routing.md` and
`gates/checklist.md`; where they differ, this file wins once filled.*
