# Blocking Quality Checklist

**Provenance: original synthesis** over the rule categories recorded in `research/ledger.md` (S3 a11y
categories, S1 standards, S4 review modes) per ARCHITECTURE.md §6. Values live in
`../references/values.md` once built; quotes kept ≤15 words.

**Status: blocking.** Every item passes before ship, or the exception is waived with an entry in the
target project's `adaptive/decisions.md` (item, reason, review date). Run `bash audit.sh <target>` first —
it mechanically catches the subset marked *(script)*. Measured checks (contrast, hit area) need evidence
from the foundation `/verify-ui` screenshots or DevTools, not eyeballing.

## 1. Keyboard
- Every interactive element is reachable by Tab, in DOM order matching visual order.
- Enter activates links/buttons, Space activates buttons/toggles; arrow keys move within composite widgets.
- Esc closes every overlay (dialog, menu, popover, toast with actions).
- *(script)* No `tabindex` above 0 anywhere; no positive tabindex in JSX (`tabIndex={n}`, n ≥ 1).
- A skip link exists on multi-region pages and lands on `<main>`.

## 2. Names
- Icon-only buttons carry `aria-label` or `aria-labelledby` (or visually hidden text). *(script: line heuristic)*
- Every input has a real `<label>` (or `aria-label`/`aria-labelledby`); placeholders are not labels.
- Decorative icons/images are `aria-hidden="true"` or `alt=""`; meaningful media has descriptive alt.
- Buttons state their action ("Save changes"), not their icon ("✓").

## 3. Focus
- Focus indicator is visible on every focusable element; outlines are never removed without a replacement.
- Dialogs/menus trap focus while open, set initial focus inside, and restore focus to the trigger on close.
- Focus survives state changes (delete, route change, closing a popover) — never dropped to `<body>`.
- No focus-visible style that fails contrast against its background (≥3:1).

## 4. Semantics
- Native elements first: `<button>`/`<a>`/`<input>` before `div` + ARIA; ARIA only for gaps.
- One `<h1>` per page; heading levels never skip (h2 → h4).
- Landmarks present: `header`/`nav`/`main`/`footer`; one `main`; lists use `ul`/`ol`.
- Interactive roles match behavior (`role="button"` must also do Enter/Space).

## 5. Forms
- Required fields marked natively (`required`/`aria-required`), not just by an asterisk.
- Errors are linked to their field via `aria-describedby`, and the field sets `aria-invalid="true"`.
- Error text says what is wrong and how to fix it; announced on submit failure.
- Disabled/submitting state is communicated (`disabled` + visible label change), never silent.

## 6. Contrast
- Body text ≥4.5:1; large text (≥24px or ≥18.66px bold) ≥3:1 — measured, value recorded.
- UI components/icons conveying meaning ≥3:1 against adjacent colors.
- State is never color-only: pair with icon, text, underline, or shape.
- Placeholders, disabled text, and muted metadata checked too (common failures).

## 7. Motion
- Frequency gate passed: nothing animates on 100+/day actions; purpose named for each animation.
- UI transitions ≤300ms (feedback ≤200ms where the profile is restrained); exact properties only.
- *(script)* No `transition: all`, no `scale(0)`, no `ease-in` outside sanctioned cases.
- `prefers-reduced-motion` gets a gentler variant (not removal to zero).
- Hover-triggered motion is gated behind `@media (hover:hover) and (pointer:fine)`.

## 8. Touch
- Hit areas ≥44px on touch, ≥40px in dense desktop UI — measured on the smallest control, not the wrapper.
- Adjacent targets don't overlap or crowd (gap ≥ smallest target edge where feasible).
- Nothing essential is hover-only; taps work on touch devices.

## 9. Responsive
- Usable at 320px width with no horizontal scrolling; checked at a real viewport, not only devtools preset.
- 200% browser zoom keeps all content and controls usable.
- Dark mode readable (contrast re-checked; no white flashes, no near-black borders on dark surfaces).
- RTL doesn't break layout: no hard-coded left/right where logical properties belong.
- *(script)* No `h-screen` where dynamic browser chrome matters — prefer `dvh`.

## 10. Perf basics
- Transitions name exact properties (transform/opacity/clip-path); no `transition: all`. *(script)*
- Animated blur ≤8px; `will-change` only on elements about to animate, removed afterwards.
- No layout-triggering animation (width/height/top/margin on hot paths); reserved space prevents CLS.
- Images/media sized before load; no infinite rAF/animation loops running off-screen.

---
**Waiver format** (in `decisions.md`): `| id | date | gates/checklist.md §N item | reason | review date | active |`
