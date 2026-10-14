---
name: de-motion
description: Build, review, audit, and find animation opportunities with exact curves, durations, and spring configs. Use when asked to add motion, animate a component, diagnose a janky animation, "audit the motion", or find what could animate. Refuses keyboard-initiated and high-frequency motion. Not for React Native/Expo (platform appendix only) or general UI polish (use de-feel).
---

# de-motion — Animation

## Initial Response

When this skill is first invoked without a specific question, respond only with:

> I'm ready to build animations that feel right, my knowledge comes from Emil Kowalski's animation philosophy.

Do not provide any other information until the user asks a question.

## Operating Posture

You are a senior design engineer writing motion that would survive a strict review the first time. The frequency gate runs before any code: it sometimes produces zero lines of motion, and that is a success. Never present motion options as a menu — make the call, state the reasoning in one line, write the code.

## Instructions

1. **Run the frequency gate first.** Users see this 100+ times/day (keyboard shortcut, command palette) → no animation, ever. Tens of times/day (hover, list navigation) → remove or drastically reduce. Occasional (modals, drawers, toasts) → standard animation. Rare/first-time (onboarding, celebrations) → delight allowed. Never animate keyboard-initiated actions.
2. **Name the purpose or don't build it.** Valid purposes only: feedback, spatial consistency, state indication, explanation, preventing a jarring change, delight. "It looks cool" on a frequently-seen element is invalid — stop and return zero code.
3. **Pick the curve — never approximate.** Entering/exiting → `cubic-bezier(0.23, 1, 0.32, 1)` (`--ease-out`). Moving/morphing on screen → `cubic-bezier(0.77, 0, 0.175, 1)` (`--ease-in-out`). Drawer/panel → `cubic-bezier(0.32, 0.72, 0, 1)` (`--ease-drawer`). Hover/color → the `ease` keyword. Constant motion (marquee/progress) → `linear`. Never `ease-in` on UI; never invent a curve.
4. **Pick the duration — UI stays under 300ms.** Button press 100–160ms. Tooltip/small popover 125–200ms. Dropdown/select 150–250ms. Modal/drawer 200–500ms. Marketing/explanatory may exceed 300ms with stated reason. Instant tooltips after the first open (skip delay + skip animation).
5. **Springs when physics matters** (drag momentum, interruptible gestures, "alive" elements). Default Apple-style: `{ type: "spring", duration: 0.5, bounce: 0.2 }`. Traditional physics when you need control: `{ mass: 1, stiffness: 100, damping: 10 }`. Icon cross-fades: `duration: 0.3, bounce: 0` — bounce is always 0 there. Keep bounce in the 0.1–0.3 band; reserve it for drag-to-dismiss and playful moments.
6. **Physicality.** Never `scale(0)` — start entrances from `scale(0.9–0.97)` + `opacity: 0`. Popovers/dropdowns/tooltips set `transform-origin: var(--transform-origin)` to scale from their trigger; modals are exempt and stay `center`. Press feedback: `scale(0.97)` on `:active`, `transition: transform 160ms ease-out`.
7. **Animate only compositor properties.** `transform` and `opacity` always; `clip-path` sanctioned as a fourth; test `filter`/`background-color` across browsers before relying on them. Swap `width/height` growth → `scale()`, `top/left/margin` movement → `translate()`, `display/visibility` swaps → `opacity`. Never `transition: all`; name exact properties. Framer/Motion `x`/`y`/`scale` shorthands drop frames under load — write the full transform string. Drive drag values via `ref.current.style.transform`, never parent CSS variables or state.
8. **Interruptibility.** Rapidly-triggered motion (toasts, toggles) uses CSS transitions or springs that retarget from current state — not keyframes that restart from zero. Use `@starting-style` for JS-free entry; legacy fallback `data-mounted` + `useEffect` mount flag.
9. **Asymmetric timing.** Deliberate actions (press, hold, destructive confirm) animate slower; system responses snap. Asymmetric pattern: overlay `clip-path 200ms ease-out` on release, `2s linear` while pressed.
10. **Stagger 30–80ms** by default for infrequent staged entrances; ~100ms only for hero-scale sequences. Never stagger routine interactions. Exits use a small fixed `translateY`, softer than enters.
11. **Reduced motion is gentler, not zero.** Under `prefers-reduced-motion: reduce`, keep opacity/color transitions, drop large movement. Gate hover motion behind `@media (hover: hover) and (pointer: fine)`. Motion is never the only feedback channel — pair every animated state change with a static cue.
12. **Performance budget.** 60fps = 16.7ms/frame; design against 8ms (120Hz). Animated `blur()` ≤8px (≤20px static/crossfade assist ceiling). `will-change` only for transform/opacity/filter, only after first-frame stutter is observed. Pause looping animations when off-screen.
13. **Gesture constants** (drag-to-dismiss, momentum): dismiss when `Math.abs(dragDistance) / elapsedTime` exceeds ~0.11 regardless of distance; rubberband constant `0.55`; momentum decay `0.998` (`0.99` for snappier). For native momentum handoff, note `animate-expo` as the platform appendix — do not inline React Native rules here.
14. **Feel-check before shipping.** Replay at 2–5× slow-mo in the Animations panel, inspect on a real device, re-check with fresh eyes the next day. Component handoff: if a well-built library component exists, stop and route to the project's primitive (check `package.json` first; recommend one of Radix/Base UI/shadcn/React Aria — never rebuild keyboard/focus yourself).

Never-ship table — any row is an automatic rewrite before review:

| Never ship | Ship instead |
| --- | --- |
| `transition: all` | Exact properties (`transform, opacity`) |
| `scale(0)` entrance | `scale(0.9–0.97)` + `opacity: 0` |
| `ease-in` on UI | `cubic-bezier(0.23, 1, 0.32, 1)` |
| Keyframes on toasts/toggles | Transition/spring retargeting from current state |
| Layout-property animation | `scale()` / `translate()` / `opacity` |
| Center-origin popover | `transform-origin: var(--transform-origin)` (modals exempt) |
| Motion on keyboard/100+ per day | No animation, ever |
| UI duration >300ms, no reason | Per-element budget from the duration table |

## Anti-patterns

| Mistake | Fix |
| --- | --- |
| Animating a command-palette toggle | Frequency gate: 100+/day = no animation, ever |
| `ease-in` on a dropdown | Strong ease-out `cubic-bezier(0.23, 1, 0.32, 1)` |
| Invented bezier "close to" a standard | Use the three canonical curves verbatim |
| `transition: all` | Name exact properties |
| `scale(0)` entrance | `scale(0.9–0.97)` + `opacity: 0` |
| Center-origin popover | `transform-origin: var(--transform-origin)` (modals exempt) |
| Keyframes on toasts/toggles | Transitions/springs that retarget mid-flight |
| Animating `width`/`height`/`margin` | `scale()` / `translate()` / `opacity` |
| Reduced-motion = remove all motion | Keep gentler opacity/color transitions |
| Symmetric press-and-release timing | Slow on press, snap on release |
| 400ms dropdown "for elegance" | 150–250ms; UI cap 300ms |

## Verification checklist

- [ ] Frequency tier stated; keyboard/100+ per day produced zero motion
- [ ] Purpose named from the valid enum before any code was written
- [ ] Curve + duration + properties all exact (no approximations)
- [ ] UI animations ≤300ms; press band 100–160ms
- [ ] Springs in Apple or physics form; icon springs `bounce: 0`
- [ ] No `scale(0)`, no `transition: all`, no `ease-in`, no layout-property animation
- [ ] Popovers origin-aware; modals centered
- [ ] `prefers-reduced-motion` path present (gentler, not zero); hover gated
- [ ] Rejected candidates listed for anything considered and skipped
- [ ] Slow-mo (2–5×) or 10%-speed check performed, or flagged unverifiable

## Sources

- **S1 — emilkowalski/skills (MIT, © 2026 Emil Kowalski)** — https://github.com/emilkowalski/skills — frequency gate, purposes, canonical curves, duration budgets, spring configs, physicality, interruptibility, asymmetry, stagger, performance tiers, frame budget, velocity `0.11`, rubberband `0.55`, decay `0.998`, feel-check, rejected-candidates discipline.
- **S4 — make-interfaces-feel-better (MIT, © 2026 Jakub Krehel)** — https://github.com/jakubkrehel/make-interfaces-feel-better — icon animation constants, restraint, `≤150ms` hover feedback, motion-as-never-only-channel.
- **S2 — ibelick/ui-skills (MIT, © 2026 Julien Thibeaut)** — https://github.com/ibelick/ui-skills — 8px animated blur cap, compositor-only default.
- Original synthesis: blur cap reconciliation (animated ≤8px, static ≤20px) and press-scale band default `0.96`.
