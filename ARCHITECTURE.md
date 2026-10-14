# ARCHITECTURE — Design Engineering Harness

Extends the foundation harness (`https://github.com/itsaibarr/harness` @ `94a89ed`, see `research/foundation-audit.md`).
Follows its conventions exactly: skills in `agent/core/framework/skills/<name>/SKILL.md` (`name`+`description` frontmatter),
commands in `agent/core/framework/commands/<name>.md` (`description` frontmatter → invoke skill + `$ARGUMENTS`),
reference library + gates in a new `agent/modules/design-engineering/` module, router row + inventory entry, `bootstrap.sh --design` flag.
Target agents: Claude Code + OpenCode/Cursor via `~/.claude/skills` (+ AGENTS.md pointer for Codex).
Stack preset: Next.js (App Router) + Tailwind v4 + Motion + Radix/shadcn, auto-detect otherwise.

Evidence base: `research/ledger.md` (all 8 sources READ_FULLY) + `research/synthesis.md`.
License posture: all skill sources MIT (Emil Kowalski, Julien Thibeaut/ibelick, Jakub Krehel) — adapt structure/values,
no large verbatim copies; per-skill Sources section + `SOURCES.md`. Floguo/BoardUI/BeautifulUI/Inspora content is
studied as reference (teardown/facts, not copied text). Foundation harness has NO license — new repo ships with an
explicit license (Phase 6 decision) and does not redistribute foundation files wholesale.

## 1. Skill set (8 skills)

Naming: `de-*` prefix avoids collisions with foundation skills and reads as slash commands.

| Skill | Purpose | Trigger conditions (frontmatter "Use when") | Sources |
|---|---|---|---|
| `de-feel` | Interaction polish pass: typography/surface/animation/icon/performance micro-fixes with exact values + review table | "feels off", polish pass, reviewing UI code; quick (cap 5, HIGH/MED only) vs full (cap 15) modes | S4 primary (19 principles, values, review format); S1 support (frequency gate, curves, durations) |
| `de-motion` | Build / review / audit / find animation; performance diagnosis | add motion, janky animation, "audit the motion", "what could animate"; refuses keyboard/high-frequency motion | S1 primary (animate, review-animations+STANDARDS, improve-animations, find-opportunities, animation-performance); S4 support (icon constants, restraint) |
| `de-a11y` | Accessibility audit + minimal targeted fixes | interactive controls, forms/dialogs, keyboard/focus, WCAG review | S3 primary (9 categories, triples); S2 support (fixing-accessibility file); S4 (44px/40px hit areas); S1 (reduced-motion, hover gating) |
| `de-component` | Component craft: anatomy, states, variants, keyboard/a11y contract, tokens | new component, "build a segmented control", component review | S6 primary (segmented-control teardown as exemplar method); S2 (baseline-ui constraints, component-canvas discipline); S1 (Sonner principles, pick-ui-library routing) |
| `de-type-space` | Typography + spacing system: scale, rhythm, rendering details, token naming | type setup, spacing audit, "fix the typography" | S4 typography.md (balance/pretty, smoothing, tabular); S2 baseline-ui (bans, tabular); S6 type tokens (Inter, scale-per-Figma); spacing system = **original synthesis** (gap S6.1) |
| `de-taste` | Creative direction: brief → mood → tokens → detail cues; quality-bar checks | new page/site, "make it beautiful", direction review | S5 (material thinking, foundations-over-showpieces); S7 (21-pattern quality bar); S8 (16-post inspiration index); S1 (taste-is-trained, cohesion); brief-to-direction method = **original synthesis** |
| `de-critique` | Design review with verdict: findings table + rejected candidates + Block/Needs-changes/Approve | review UI/diff, "critique this", pre-ship check | S4 review format (severity table, caps, verdict ladder); S1 review-animations (10 standards, remedial hierarchy); S2 improve-ui (three-proof gate, read-only, stop-at-3) |
| `de-site` | Personal-website workflow: IA → sections (hero/work/about/contact/footer) → copy/SEO → polish | personal site, site section, landing page | S5 (role/foundations, pattern libraries); S7 (AI-UI + marketing patterns); S8 (portfolio/footer/card genres); S2 (create-design-md schema, fixing-metadata); workflow itself = **original synthesis** |

Out of scope (deliberate): Swift/native (S1 write-swift — not web); Expo/Reanimated (S1 animate-expo — noted in `de-motion` as platform appendix pointer only);
toast-library internals (S1 ask-sonner → collapsed into `de-component` toast pattern + pick-ui-library rule); full DESIGN.md emitter
(S2 create-design-md → referenced as upstream tool, harness stores a profile not a DESIGN.md).

## 2. Reference library (`agent/modules/design-engineering/references/`)

- `patterns.md` — catalog of S7's 21 AI-UI components + S6 Blocks overlap; per pattern: what it is, states covered, quality cues (liveness, provenance, uncertainty labels). Source: S7 primary, S6 support.
- `teardowns/segmented-control.md` — full teardown exemplar: anatomy (tertiary track + sliding thumb), API (key-set `selectedKeys`/`onSelectionChange`/`defaultSelectedKeys`, never-empty invariant), keyboard (arrows move/Space selects via React Aria ToggleButtonGroup), tokens (light `neutral-100`/white; dark `neutral-925`/`neutral-800`), install (`npx boardui@latest add`), dark-mode doctrine, edge cases. Source: S6. Template reused for future teardowns.
- `inspiration.md` — S8 index: 16 posts grouped by genre (footers ×3, cards ×4, portfolios/identity ×7, menus/FAQ ×2) + per-post why-it-works (1 line) + tags (Industries/Colors/Styles) + rule: any borrowed pattern must ship states+a11y+reduced-motion. Source: S8.
- `tokens.md` — token-system exemplar from S6 theme.css (OKLCH primitives, 11-stop accent ramp, semantic light/dark pairs, radii `2lg:10px`/`2-5xl:20px`, 6%/10% shadows, Inter/JetBrains Mono) + S2 DESIGN.md schema as the capture format. Source: S6 primary, S2 support.
- `values.md` — single source of truth for all magic numbers (curves, durations, scales, stagger, blur caps, hit areas, velocity `0.11`, rubberband `0.55`, decay `0.998`) with per-value provenance. Sources: S1+S4 (+S2/S6 where stricter).

## 3. Traceability matrix

| Source | Feeds |
|---|---|
| S1 emilkowalski/skills (MIT) | `de-motion` (primary), `de-feel`, `de-critique`, `de-component`, `de-a11y` (gating), `values.md` |
| S2 ibelick/ui-skills (MIT) | `de-component` (baseline/canvas), `de-critique` (proof gate), `de-a11y`, `de-site` (metadata/schema), `tokens.md`, routing pattern |
| S3 fixing-accessibility page | `de-a11y` (primary rule body) |
| S4 make-interfaces-feel-better (MIT) | `de-feel` (primary), `de-type-space`, `de-critique`, `de-motion`, `de-a11y` (hit areas) |
| S5 floguo notes | `de-taste` (philosophy), `de-site` (workflow framing), quality-gate evidence rule (before/after screenshots) |
| S6 BoardUI segmented-control | `de-component` (teardown method), `teardowns/segmented-control.md`, `tokens.md`, `de-type-space` |
| S7 BeautifulUI | `de-taste` (quality bar), `de-site`, `patterns.md` |
| S8 Inspora | `de-taste`, `de-site`, `inspiration.md` |
| Foundation harness (unlicensed — conventions only, no redistribution) | skill/command formats, router registration, module layout, `bootstrap.sh --design`, evidence-trail norm |

Every skill maps back to ≥1 source above; `de-type-space` (spacing half), `de-taste` (method), `de-site` (workflow), adaptive layer, and gate mechanics carry explicit **original synthesis** labels in their files. No source unmapped; no skill sourceless.

## 4. Adaptive layer (`agent/modules/design-engineering/adaptive/`)

1. **Stack detection** (`detect.sh` + `routing.md`): reads `package.json`/config to pick compatible guidance — Tailwind vs CSS modules vs CSS-in-JS (S4: never introduce a second styling system); Motion vs CSS transitions/WAAPI (S1 cheapest-tool ladder); Radix/Base-UI/shadcn vs hand-rolled (S1 pick-ui-library: check installed first, recommend one).
2. **`project-profile.md`**: generated on first `/de-start` run via short interview (foundation `interview-me` pattern): principles, tone, motion budget (default restrained per S2 baseline-ui), density (44px touch vs 40px desktop), brand direction, a11y level. Editable; lives in the target project, not the harness.
3. **Skill routing**: task-type table — new component → `de-component` (+`de-motion` if animated, +`de-a11y` if interactive); polish pass → `de-feel`; audit → `de-critique`/`de-a11y`; full page → `de-site`+`de-taste`; motion work → `de-motion`. Max 3 skills per task (S2 ui-skills-root cap).
4. **Decision log** (`decisions.md` in target project): preference/correction entries with rules — a correction updates the profile only after it recurs twice or the user says "always"; single instances stay scoped. (Foundation decision-log norm, adapted.)
5. **Personal-website preset** (`presets/personal-website.md`): goals for the site (positioning, sections, restrained motion default, footer-as-showpiece per S8 genre, proof/provenance per S7) — filled by interview, reused across sessions.

## 5. Workflow commands (`agent/core/framework/commands/`)

Foundation style: `description:` frontmatter + body invoking the Skill tool with exact skill name + `$ARGUMENTS`.

- `/de-start` → profile interview + stack detect + routing (entry point; invokes adaptive flow, default skill `de-taste` for direction or `de-site` for site work per answer)
- `/de-build-component` → `de-component` (with `de-motion`/`de-a11y` composed per routing table)
- `/de-polish` → `de-feel` (quick/full via `$ARGUMENTS`)
- `/de-a11y-audit` → `de-a11y` (file or scope via `$ARGUMENTS`)
- `/de-critique` → `de-critique` (diff/scope via `$ARGUMENTS`)
- `/de-site-section` → `de-site` (section name via `$ARGUMENTS`)

## 6. Quality gates (`agent/modules/design-engineering/gates/`)

- `checklist.md` (blocking unless waived in decision log): keyboard (Tab reach, visible focus, no `tabindex>0`, Esc closes); names (icon-only labeled, inputs labeled, decorative hidden); focus (trap + restore + initial in dialogs); semantics (native first, no skipped headings); forms (errors via `aria-describedby` + `aria-invalid`); contrast (text/icons, non-color cues); motion (frequency gate, ≤300ms UI, exact properties, reduced-motion gentler, hover-gated); touch (44px / 40px dense, no overlaps); responsive (320px, 200% zoom, real width, dark, RTL); perf basics (transform/opacity only, blur ≤8px animated, no `transition:all`, `will-change` surgical).
- `critique-rubric.md`: severity tiers (HIGH = inaccessible/misleading/unreadable/repeatedly-disruptive; MEDIUM = noticeable usability/consistency; LOW = isolated polish), caps (quick 5 / full 15), verdict ladder (Block / Needs changes / Approve), required rejected-candidates (1–3 quick, 2–5 full), verification list (commands run + 10%-speed motion check where applicable).
- Automated hooks where feasible: grep-based `audit.sh` (flags `transition: all`, `scale(0)`, `ease-in`, `tabindex>0`, missing `aria-label` on icon buttons, `h-screen`, `user-scalable=no`) as advisory (exit non-zero = fail, pluggable into route-task `gate:`); measured checks (contrast, hit-area) remain checklist-driven with foundation `/verify-ui` screenshots as evidence (before/after per S5 Before-and-After rule).
