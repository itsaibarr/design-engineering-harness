# Design Engineering Harness

An agent harness that teaches design-engineering craft: 8 `de-*` skills, a reference library, an adaptive project profile, and quality gates — built on the foundation harness conventions and backed by an 8-source research ledger.

## Philosophy

- **Material thinking.** Design engineers think in the final medium — code and pixels are one malleable material, so idea-to-validation time collapses (Floguo, S5). The harness works in that medium: values, tokens, and review tables, not mood boards alone.
- **Frequency-gated motion.** Whether to animate is decided by how often an interaction fires, not by taste: 100+ times/day → no animation, ever; tens/day → near-imperceptible; occasional → standard; rare → delight (Emil Kowalski, S1). Motion is never the only feedback channel (S4).
- **Primitives over hand-rolls.** Reach for an existing accessible primitive first — React Aria / Radix / Base UI, checked against what's already installed (S1 `pick-ui-library`, S2, S6's React Aria `ToggleButtonGroup`). Never rebuild keyboard and focus behavior.
- **Evidence-based.** Every claim traces to a fetched source with a SHA (`research/ledger.md`); every review is a table with severity, a verdict, and rejected candidates (S4, S1, S2); every change ships before/after screenshots (S5). Opinions without an evidence pointer don't ship.

## Install

Copy the skill masters and commands from a foundation-harness checkout into your agent's load path:

```bash
# skills
cp -R agent/core/framework/skills/de-*   ~/.claude/skills/

# commands
cp    agent/core/framework/commands/de-* ~/.claude/commands/

# reference library + gates + adaptive layer, when you want them in a project
cp -R agent/modules/design-engineering  <your-project>/agent/modules/

# foundation installer, when present
./bootstrap.sh --design
```

- **Claude Code** reads `~/.claude/skills/` and `~/.claude/commands/` directly.
- **OpenCode / Cursor** use the same directory; add a pointer to these skills and commands from your `AGENTS.md`.
- **Codex** picks them up through the same `AGENTS.md` pointer.

Copy only what you need — the module is designed to be added to a project on demand (foundation two-layer doctrine: tiny always-on `core/`, opt-in `modules/`).

## Quickstart

1. Run `/de-start` — short profile interview + stack detection. It writes a `project-profile.md` (principles, tone, motion budget, density, brand direction, accessibility level) and a routing table for your stack.
2. Build something: `/de-build-component <description>` → `de-component`, composed with `de-motion` / `de-a11y` per the routing table (max 3 skills per task).
3. Or polish what exists: `/de-polish <scope>` (quick = HIGH/MED, cap 5; full = cap 15).
4. Before you ship: `/de-critique <diff-or-scope>` and `/de-a11y-audit <file>`.

Other commands: `/de-site-section <name>` for a personal-site section.

The profile interview is the point of entry — later runs reuse it, and corrections land in a decision log (a preference updates the profile only after it recurs twice or you say "always").

## Layout

```
design-engineering-harness/
├── README.md                  ← this file
├── ARCHITECTURE.md            ← design decisions, source→skill traceability, gate spec
├── SOURCES.md                 ← full attribution (8 sources + foundation)
├── CHANGELOG.md
├── research/
│   ├── ledger.md              ← all 8 sources: URL, SHA, license, fetch status, evidence
│   ├── synthesis.md           ← agreements, conflicts + resolutions, gaps
│   └── foundation-audit.md    ← foundation harness architecture + license gap
└── agent/                     ← foundation-harness layout conventions
    ├── core/framework/
    │   ├── skills/de-*/SKILL.md     ← 8 skills: feel, motion, a11y, component,
    │   │                              type-space, taste, critique, site
    │   └── commands/de-*.md         ← 6 slash commands
    └── modules/design-engineering/
        ├── README.md                ← activation conditions
        ├── references/              ← patterns, teardowns/segmented-control,
        │                              inspiration, tokens, values
        ├── adaptive/                ← detect.sh, routing, project-profile,
        │                              decisions, presets/personal-website
        └── gates/                   ← checklist, critique-rubric, audit.sh
```

## Further reading

- [`ARCHITECTURE.md`](ARCHITECTURE.md) — skill set, reference library, traceability matrix, adaptive layer, commands, gates.
- [`research/`](research/) — `ledger.md` (evidence + SHAs), `synthesis.md` (agreements/conflicts/gaps), `foundation-audit.md`.
- [`SOURCES.md`](SOURCES.md) — attribution and licensing posture.
