# Values — single source of truth for magic numbers

Every constant the `de-*` skills may quote, with provenance. **Prefer this file over quoting a
source from memory.** Sources: **S1** emilkowalski/skills, **S2** ibelick/ui-skills,
**S4** jakubkrehel/make-interfaces-feel-better, **S6** BoardUI. Conflict resolutions are from
`research/synthesis.md` §2 and are cited in the Notes column as `R#`.

## The table

| Category | Value | Applies to | Src | Notes / resolution |
|---|---|---|---|---|
| Curve | `cubic-bezier(0.23, 1, 0.32, 1)` | default ease-out, UI motion | S1 | Canonical ease-out; use unless a named reason not to. |
| Curve | `cubic-bezier(0.77, 0, 0.175, 1)` | ease-in-out, symmetric moves | S1 | Canonical trio member. |
| Curve | `cubic-bezier(0.32, 0.72, 0, 1)` | fast-out / gentle-settle entrances | S1 | Canonical trio member. |
| Curve | `cubic-bezier(0.4, 0, 0.2, 1)` | **forbidden — never invent** | S1 | Not in our vocabulary; audit flags invented curves. |
| Duration | ≤ 300ms | ceiling for any UI animation | S1 | Hard cap above which UI motion reads as lag. |
| Duration | ≤ 200ms | interaction feedback (hover/press/focus) | S2 | R1 context; tighter than the 300ms ceiling. |
| Duration | ≤ 150ms | motion-restraint rule | S4 | Tightest of the three caps — applies when restraint is the brief (synthesis §1.1). |
| Duration | 100–160ms web / 100–150ms Expo | press feedback | S1 | Platform delta is intentional, not drift. |
| Duration | 125–200ms | tooltip appear/dismiss | S1 | |
| Duration | 150–250ms | dropdown, popover, sliding thumb | S1 | Used by `teardowns/segmented-control.md` §4. |
| Duration | 200–500ms | modal enter/exit | S1 | |
| Duration | 400ms animation / 4000ms auto-close | toast | S1 | **R7:** store as `animationMs` vs `dwellMs` — never conflate. |
| Scale | 0.95–0.98 band, **default 0.96** | press / tactile scale | S4 + S1 | **R4:** default 0.96 (S4 precision); 0.97 (S1) acceptable alt. |
| Scale | 0.95 floor — smaller forbidden | press scale minimum | S4 | Never below 0.95. |
| Scale | 0.95–0.97 | enter/exit scale band | S1 | The acceptable entrance range. |
| Scale | `scale(0)` **forbidden** | any enter/exit | S1 | Use the 0.95–0.97 band; `audit.sh` flags `scale(0)`. |
| Scale | 0.25 → 1 | icon cross-fade scale | S4 | Pair with blur 4px → 0px. |
| Blur | 4px → 0px | icon appear/disappear | S4 | Icon constants. |
| Blur | **≤ 8px animated** | any animated blur | S2 | **R5:** constrains the animated (compositor) path. |
| Blur | < 20px ceiling; 2px crossfade assist | static blur / crossfade | S1 | **R5:** general ceiling, not the animated allowance. |
| Stagger | **30–80ms** default | sequence step between items | S1 | **R4:** default band. |
| Stagger | ~100ms, infrequent only | staged hero/section entrances | S4 | **R4:** allowed only for rare staged entrances. |
| Spring | `{ type: "spring", duration: 0.5, bounce: 0.2 }` | default spring | S1 | **R6:** Apple-style is the default. |
| Spring | `{ mass: 1, stiffness: 100, damping: 10 }` | physics config when control needed | S1 | **R6:** scoped alternative. |
| Spring | `{ duration: 0.3, bounce: 0 }` | icon cross-fades | S4 | **R6:** scoped; `bounce: 0` for icon fades. |
| Spring | `bounce: 0` | non-spring / transition motion | S4 | Bounce is opt-in, never ambient. |
| Gesture | velocity > **0.11** → commit | drag dismissal / flick | S1 | Velocity sign decides regardless of distance. |
| Gesture | **0.55** | rubberband resistance | S1 | Overscroll offset divisor. |
| Gesture | **0.998** | per-frame velocity decay | S1 | Momentum coast constant. |
| Hit area | **44 × 44px** | touch targets | S4 | Minimum for touch. |
| Hit area | **40px** | dense desktop rows | S4 + S2 | Desktop-dense alternative to 44px (synthesis §1.3). |
| Perf | **8ms** | frame budget on 120Hz | S1 | Halved from 16.7ms — reason to keep work tiny. |
| Frequency | **100+/day → never animate** | frequency gate | S1 | Tens/day: near-imperceptible; occasional: standard; rare: delight. |
| Review | **5** findings max, HIGH+MED only | quick critique cap | S4 | |
| Review | **15** findings max | full critique cap | S4 | |
| Review | 1–3 quick / 2–5 full | required rejected candidates | S4 | Per harness rubric (ARCHITECTURE §6). |
| Routing | ≤ **3** skills per task (prefer 1) | skill composition cap | S2 | |
| Type | ≤ **6 lines** | where `text-balance` works | S4 | Longer blocks: use `text-pretty`. |
| Type | 1.5px / 2px | icon stroke beside 400 / 500–600 text | S4 | Match stroke to text weight. |
| Type | < **16px** inputs | iOS zoom threshold | S1 | Keeps iOS from zooming focused inputs. |
| Radius | `10px` (`--radius-2lg`), `20px` (`--radius-2-5xl`) | radius steps | S6 | Plus composed rule: outer = inner + padding (S4). |
| Shadow | 6% ambient / 10% key | shadow opacity recipe | S6 | Softer than Tailwind v4's 10% / 10%. |
| Ramp | **11** stops (50 → 950) | accent ramp override point | S6 | One override re-tints the system. |
| Theme | light `neutral-100` / `white`; dark `neutral-925` / `neutral-800` | segmented-control track / thumb | S6 | Active value always one step lighter than its track. |

## Conflict resolutions applied (synthesis §2)

| # | Conflict | Resolution encoded above |
|---|---|---|
| R1 | S2 "never animate unless requested" vs S1/S4 "animate where justified" | S1 frequency gate is the default; the S2 ban is the **personal-website preset** default with per-surface opt-in. |
| R2 | S6 manual class-based dark mode vs system-follow ecosystem default | S6 rule stays inside BoardUI-derived components (semantic tokens, no component `dark:`, pre-hydration script); elsewhere `next-themes` system-follow. |
| R3 | S5 foundations-first vs S8 showpiece-first | Both stand: S8 feeds `inspiration.md` cues, S5/S6 supply systems — borrowed patterns need states + a11y + reduced-motion to count. |
| R4 | Press 0.97 vs 0.96; stagger 30–80 vs ~100ms | Band 0.95–0.98 with default **0.96** (0.97 alt); stagger **30–80ms** default, ~100ms only for infrequent staged entrances. |
| R5 | Blur <20px (S1) vs ≤8px (S2) | Animated blur **≤8px**; static/crossfade ceiling **<20px**. |
| R6 | Apple-style vs physics springs vs icon `bounce:0` | Apple-style default; physics when control is needed; `bounce:0` scoped to icon cross-fades. |
| R7 | Toast 400ms vs 4000ms confusion | Two fields: `animationMs` and `dwellMs`. |

## Non-numeric constants (equally binding)

- **Hover gating:** pointer-only affordances live behind `@media (hover: hover) and (pointer: fine)` (S1).
- **Reduced motion:** gentler and shorter, never zeroed — the state change survives (S1/S2/S4 agree).
- **Exact properties:** no `transition: all`; name `transform`/`opacity` (clip-path sanctioned) (S1/S2/S4).
- **Review shape:** Before / After / Why table + verdict + rejected candidates (synthesis §1.4).
- **GPU-only:** compositor properties; `will-change` surgical (S1/S2/S4).
