# Teardown — Segmented Control

Source: **S6** `boardui.com/components/segmented-control` (READ_FULLY: component page, radio page,
installation page incl. rendered `theme.css` dump via browser pass). Stack: **React 19 + Tailwind CSS v4**,
behavior from **React Aria**. Method exemplar for `de-component` — reuse the headings at the bottom
for every future teardown.

## 1. Anatomy

A **tertiary track** with N segments and one **sliding thumb** marking the selection. S6 defines it as
a single-select switch sitting on a tertiary track — the track is the container surface, the thumb is
the only element that visually "owns" the current value. Concentric discipline applies (S4
`surfaces.md:10`): outer radius = inner radius + padding, so the thumb sits inset from the track edge
at every size. Three layers to style independently: track (container), segment (label + hit area),
thumb (motion surface, behind the label).

## 2. API — controlled / uncontrolled + invariant

| Mode | Props | Notes |
|---|---|---|
| Controlled | `selectedKeys` + `onSelectionChange` | Source of truth lives in the parent; the component is a renderer. |
| Uncontrolled | `defaultSelectedKeys` | Initial value only; internal state after first change. |
| Keys | key **set** (not index, not label) | Keys are stable identifiers; renaming a label must not move the selection. |

**Invariant — never empty.** A segmented control always has exactly one active segment. S6's rule:
guard against empty sets so one segment stays active. Implement it in `onSelectionChange`: if the
incoming set would be empty (toggle-off of the only active segment, deselection via modifier, or a
parent pushing `[]`), ignore the change or fall back to the first enabled key — and warn in dev.
Also guard: keys not present in `options`, and `disabled` on the selected key (either allow
deselection-to-nothing is forbidden, or block disabling the active segment — pick one and state it).

## 3. Keyboard contract

Built on **React Aria `ToggleButtonGroup`** (S6): arrow keys move focus, **Space selects**.
Do not reimplement — route to the primitive (synthesis §1.5). Contract to verify:

- The group is a single Tab stop; internal movement is arrows (roving tabindex handled by the primitive).
- No `tabindex > 0` anywhere (S3 `fixing-accessibility:62`).
- Focus is visible on the focused segment, and selection state is exposed (not color-only).
- Disabled segments are skipped by arrows and unreachable by Tab.
- Keys work with the group focused regardless of pointer proximity; nothing hover-only
  (hover-gating: `@media (hover: hover) and (pointer: fine)`).

## 4. Sliding thumb

The thumb translates between segment slots — one element, one property.

- **Property:** `transform` (translateX/translate) only, exact properties named — never `transition: all`
  (S1 `performance` Never-Ship table; S4 `performance.md:7`).
- **Duration:** dropdown-family budget, **150–250ms**, under the 300ms UI ceiling (S1 `emil-design-eng:127-135`).
- **Curve:** canonical ease-out `cubic-bezier(0.23, 1, 0.32, 1)`; never invent a Material-style curve
  (S1 `animate:32`).
- **Triggers:** transitions, not keyframes — segment counts and widths change at runtime.
- **Reduced motion:** keep the state change, shorten or snap the travel (gentler, not zero — S1/S4/S2 agree).
- **Layout:** thumb width derived from the active segment (ResizeObserver or grid placement), so it
  survives font-load and locale label reflow; origin stays at the thumb, not the track.

## 5. Tokens — light / dark

Component reads **semantic tokens only**, never raw palette and never `dark:` (S6 token rule).

| Slot | Light | Dark |
|---|---|---|
| Track (`--color-segmented-control-background`) | `var(--color-neutral-100)` | `neutral-925` |
| Thumb | `white` | `neutral-800` |

Pattern holds in both themes: the thumb is one step *lighter* than its track, so the active
segment reads as raised without a border or shadow. Accent (segment label / selected ink) reads from
the single `--color-accent-50…950` ramp — re-tinting the ramp re-tints this control (see `tokens.md`).

## 6. Install

```
npx boardui@latest add segmented-control
```

(S6 `install` evidence item 5.) The add copies the component and its token dependencies; verify the
semantic tokens landed in your theme before use.

## 7. Dark-mode doctrine

BoardUI's doctrine, scoped to BoardUI-derived components (synthesis §2.2):

- **Manual and class-based** — the theme never reads OS preference inside these components;
  a root class swaps the semantic token values, with a pre-hydration script so there is no flash.
- Components **must not** use `dark:` prefixes — the class variant on the root is the only switch.
- Elsewhere in the project, default to system-follow (`next-themes`) per the stack preset.
  Deviating is fine; deviating silently is not — record it in the decision log.

## 8. Edge cases

- **Empty selection attempt** — blocked by the §2 invariant (the one that actually ships broken).
- **Single segment** — hide the control (or render a static label); a one-cell switch is noise.
- **Two segments on narrow viewports** — segments may shrink below the 44px touch / 40px dense hit
  area (S4); below that, stack or switch to `Select`, don't squeeze.
- **Overflowing segment labels** — truncate with title/tooltip; the thumb must track the clipped box.
- **Nested focusable radio is invalid** — in menu-row contexts S6 renders the bare glyph instead of a
  nested focusable control; reuse that escape hatch rather than double-wrapping focus targets.
- **Controlled → uncontrolled switch** — refuse at development time (React warns; make it a review finding).
- **Disabled + selected** — resolve explicitly (see §2); never leave both true with no stated rule.
- **RTL** — thumb travel inverts with logical properties; verify (S6 ships RTL pages; gates check RTL).

## 9. Related routing — Radio / Select

| Need | Use | Why |
|---|---|---|
| 2–5 mutually exclusive options, always visible, comparable at a glance | **Segmented control** | Comparison is the point; hiding options behind a trigger defeats it. |
| Same choice but with descriptions, vertical rhythm, or card/radio-row layout (S6 radio: preview, sizes, radio-card, in-menu-rows) | **Radio group** | Room for help text and larger hit areas; same single-select semantics. |
| Long/volatile list, mobile-first form, or space-constrained setting | **Select** | Progressive disclosure beats a squeezed track. |
| Multi-select | Neither — checkbox group | Segmented/radio are single-select by contract. |

Routing is harness judgment (original synthesis) over S6's three primitives; the constraint
that *is* sourced: never rebuild keyboard/focus yourself — all three route to the same primitive layer.

## 10. Quality checklist (close every teardown with this)

States (default/hover/focus/selected/disabled/RTL) · keyboard contract verified · hit areas 44/40px ·
thumb motion named-exact and reduced-motion-aware · light **and** dark verified · no component-level
`dark:` · invariant proven with an attempted empty selection.

---

## Teardown template (reuse for future components)

```markdown
# Teardown — <Component>
Source: <S# + page, read status> · Stack: <framework + primitive base>

1. Anatomy            — layers, which one moves, concentric radii
2. API               — controlled/uncontrolled table + invariants (state the never-X rule)
3. Keyboard contract — primitive backing, Tab stop model, arrows/Space/Esc, focus visibility
4. Motion            — property, duration band, curve, trigger style, reduced-motion, layout stability
5. Tokens            — light/dark slot table, semantic names, accent source
6. Install           — exact command / import
7. Dark-mode doctrine — class vs system, hydration, component-level `dark:` ban
8. Edge cases        — invariant attacks, 1–2 options, narrow/RTL, disabled+selected, mode switches
9. Related routing   — when to use <Radio|Select|other> instead; never-hand-roll note
10. Quality checklist— states + a11y + reduced-motion + light/dark, or the teardown is incomplete
```
