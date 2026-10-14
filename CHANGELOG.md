# Changelog

All notable changes to the design-engineering harness. Dates are UTC.

## v0.1.0 — 2026-10-14

First build: foundation-harness conventions extended with a design-engineering layer, backed by an 8-source research pass.

### Added

**Skills — 8 (`agent/core/framework/skills/de-*/`)**

- `de-feel` — interaction polish pass with exact values and a review table (quick/full modes).
- `de-motion` — build, review, audit, and diagnose animation; refuses keyboard/high-frequency motion.
- `de-a11y` — accessibility audit plus minimal targeted fixes across 9 ranked categories.
- `de-component` — component craft: anatomy, states, variants, keyboard/a11y contract, tokens.
- `de-type-space` — typography and spacing system (scale, rhythm, rendering, token naming).
- `de-taste` — brief → mood → tokens → detail cues creative direction with quality-bar checks.
- `de-critique` — design review with verdict: findings table, rejected candidates, Block/Needs-changes/Approve.
- `de-site` — personal-website workflow: IA → sections → copy/SEO → polish.

**Reference library — 5 files + module README (`agent/modules/design-engineering/`)**

- `references/patterns.md` — S7's 21 AI-UI components catalogued with states and quality cues.
- `references/teardowns/segmented-control.md` — full teardown exemplar (anatomy, API, keyboard, tokens, install).
- `references/inspiration.md` — S8 index: 16 posts by genre with why-it-works + tags.
- `references/tokens.md` — OKLCH token-system exemplar + DESIGN.md capture schema.
- `references/values.md` — single source of truth for every magic number, with per-value provenance.
- `README.md` — module activation conditions.

**Adaptive layer — 5 files (`agent/modules/design-engineering/adaptive/`)**

- `detect.sh` + `routing.md` — stack detection (styling system, motion tool, primitive library) and skill routing (max 3 skills per task).
- `project-profile.md` — generated on first `/de-start` via interview: principles, tone, motion budget, density, brand direction, a11y level.
- `decisions.md` — decision-log norm: a correction updates the profile only after it recurs twice or the user says "always".
- `presets/personal-website.md` — personal-website goals preset, filled by interview and reused across sessions.

**Quality gates — 3 (`agent/modules/design-engineering/gates/`)**

- `checklist.md` — blocking checklist: keyboard, names, focus, semantics, forms, contrast, motion, touch, responsive, perf basics.
- `critique-rubric.md` — severity tiers, finding caps (5 quick / 15 full), verdict ladder, required rejected candidates.
- `audit.sh` — grep-based advisory checks (`transition: all`, `scale(0)`, `ease-in`, `tabindex>0`, missing `aria-label`, `h-screen`, `user-scalable=no`); non-zero exit = fail, pluggable into route-task `gate:`.

**Commands — 6 (`agent/core/framework/commands/`)**

- `/de-start` (profile interview + stack detect + routing), `/de-build-component`, `/de-polish`, `/de-a11y-audit`, `/de-critique`, `/de-site-section`.

**Research & docs (repo root + `research/`)**

- `research/ledger.md` — all 8 sources with URL, SHA, license, fetch method, status (all **READ_FULLY**), evidence extracts, and injection scans; S6/S8 completed via a BrowserOS neo real-browser pass (~18:00Z) after curl/webfetch were blocked.
- `research/synthesis.md` — 6 cross-source agreements, 7 conflicts with resolutions, 6 documented gaps.
- `research/foundation-audit.md` — foundation harness architecture, conventions to build on, coverage gaps, and the license finding.
- `ARCHITECTURE.md` — skill set, reference library, source→skill traceability matrix, adaptive layer, commands, gates.

### Known limitations

- **Inspora (S8) motion detail is listing + description level.** Detail pages were readable only via the browser pass; hover/motion specifics stay at title/description/tag granularity, so `inspiration.md` encodes only what the listing and 16 post descriptions support.
- **Measured contrast and hit-area checks remain checklist-driven.** `audit.sh` catches grep-visible sins only; numeric contrast ratios and 44px/40px hit-area measurements are not computed by a script and rely on the checklist plus foundation `/verify-ui` screenshots as evidence.
- **Foundation license gap means no foundation files are redistributed.** `github.com/itsaibarr/harness` @ `94a89ed` has no LICENSE in tree or history, so only its conventions were adopted; a license must be chosen for that repo before publish, and this repo must ship its own explicit license (Phase 6).
