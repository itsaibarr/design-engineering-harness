---
name: de-a11y
description: Accessibility audit with minimal, targeted fixes across nine priority-ranked rule categories. Use when adding interactive controls, forms, or dialogs; when keyboard or focus behavior is involved; or when asked for a WCAG-oriented review. Reports violations as snippet/why/fix triples. Not for full design critique with a ship verdict (use de-critique) or component architecture design (use de-component).
---

# de-a11y — Accessibility Audit and Targeted Fixes

## Initial Response

When this skill is first invoked without a specific question, respond only with:

> I'm ready to audit accessibility by priority category with minimal targeted fixes, my rule set comes from the fixing-accessibility discipline.

Do not provide any other information until the user asks a question.

## Operating Posture

Audit, then fix minimally. Do not rewrite large parts of the UI — prefer the smallest change that clears the violation. Work the nine categories in priority order; a critical hit outranks any number of low-priority findings. When invoked with a file argument, review that file against all rules and report every violation before touching code.

## Instructions

1. **Audit in priority order.** Categories, ranked: (1) accessible names — critical; (2) keyboard access — critical; (3) focus and dialogs — critical; (4) semantics — high; (5) forms and errors — high; (6) announcements — medium-high; (7) contrast and states — medium; (8) media and motion — low-medium; (9) tool boundaries — critical. Report and fix top-down; never polish category 8 while category 1 is open.
2. **Report every finding as a triple:** exact snippet (quote the line), why it matters (one short sentence), concrete code-level fix. No findings without a fix suggestion.
3. **Accessible names (critical):** every interactive control has an accessible name; icon-only buttons get `aria-label` or `aria-labelledby`; every `input`/`select`/`textarea` is labeled; links carry meaningful text (never "click here"); decorative icons get `aria-hidden="true"`.
4. **Keyboard access (critical):** no `div`/`span` acting as a button without full keyboard support; all interactive elements reachable by Tab; focus visible; never `tabindex` greater than 0; Escape closes dialogs and overlays when applicable.
5. **Focus and dialogs (critical):** modals trap focus while open; focus restores to the trigger on close; initial focus lands inside the dialog; opening a dialog does not scroll the page unexpectedly.
6. **Semantics (high):** prefer native elements (`button`, `a`, `input`) over role-based hacks; if a role is used, ship its required aria attributes; lists use `ul`/`ol` + `li`; never skip heading levels; tables use `th` for headers.
7. **Forms and errors (high):** errors linked via `aria-describedby`; invalid fields set `aria-invalid="true"`; required fields announced; helper text associated with its input.
8. **Announcements (medium-high):** expandable controls set `aria-expanded` and `aria-controls`; dynamic status changes use appropriate live regions.
9. **Contrast and states (medium):** text and icon contrast meets WCAG AA; never remove a focus outline without a visible replacement; states never communicated by color alone — add a non-color cue (icon, label, underline).
10. **Media and motion (low-medium):** non-essential motion respects `prefers-reduced-motion` — gentler, not zero (keep opacity/color, drop large movement); hover-only interactions are gated behind `@media (hover: hover) and (pointer: fine)` so touch users aren't stranded.
11. **Touch targets:** interactive elements keep a 44×44px hit area for touch/mobile, at least 40×40px in dense desktop UI; extend small visible controls with a pseudo-element; never overlap hit areas.
12. **Forms rendering:** input font-size ≥16px on iOS — below that, Safari zooms and breaks the layout.
13. **Tool boundaries (critical):** automated checkers and this skill cannot see rendered contrast, focus order across frames, or screen-reader truth. Flag what needs a real pass (axe run, VoiceOver/NVDA sweep, measured contrast) instead of declaring clean. Never claim WCAG compliance from a code read alone.
14. **Stay minimal.** When fixing, change only the violating attribute/element. Do not restyle, refactor, or "improve while you're here". Out-of-scope findings (behavior bugs, broken routes) are noted in one line, not fixed.
15. **Output shape for audit-only runs.** One block per finding, in category order:

```
### [critical] accessible names — IconMenu.tsx:22
Violation: <button className="icon-only" onClick={open} />
Why: no accessible name; screen readers announce "button".
Fix: <button aria-label="Open menu" onClick={open} />
```

Then a one-line summary: counts per severity, first fix in priority order, and any tool-boundary items needing a measured pass.

## Anti-patterns

| Mistake | Fix |
| --- | --- |
| Icon button with only a tooltip | `aria-label` (tooltip stays visual-only) |
| `div onClick` as a control | Native `button` with full keyboard support |
| `tabindex={1}` to force order | Fix DOM order; never `tabindex` > 0 |
| Focus outline removed "for cleanliness" | Keep outline or supply an equal-visibility replacement |
| Error text visually adjacent but unlinked | `aria-describedby` + `aria-invalid` on the field |
| Color-only error/selected state | Add icon, label, or underline cue |
| Rewriting the form during an audit | Minimal attribute-level fixes only |
| Declaring "WCAG compliant" from grep | State tool boundaries; request measured/screen-reader pass |
| Removing all motion under reduced-motion | Gentler opacity/color transitions, drop movement only |
| 20px tap targets on mobile | 44×44px (touch) / 40×40px (dense desktop) |

## Verification checklist

- [ ] All nine categories audited in priority order; criticals fixed first
- [ ] Every finding has snippet + why + code fix (triple complete)
- [ ] Icon-only controls labeled; inputs labeled; decorative icons `aria-hidden`
- [ ] No `tabindex` > 0; Escape closes overlays; Tab reaches everything
- [ ] Dialog: trap + initial focus + restore-to-trigger all present
- [ ] Errors: `aria-describedby` + `aria-invalid`; required announced
- [ ] No skipped heading levels; lists and table headers semantic
- [ ] Focus outline intact or visibly replaced; no color-only states
- [ ] Reduced-motion honored (gentler, not zero); hover gated
- [ ] Hit areas ≥44px/≥40px, non-overlapping; inputs ≥16px on iOS
- [ ] Tool-boundary items listed as "needs measured pass", not claimed fixed

## Sources

- **S3 — fixing-accessibility (via ibelick/ui-skills; MIT, © 2026 Julien Thibeaut)** — https://www.ui-skills.com/skills/ibelick/fixing-accessibility — nine priority-ranked categories and the core rule body (names, keyboard, focus/dialogs, semantics, forms, announcements, contrast, media/motion, tool boundaries).
- **S2 — ibelick/ui-skills (MIT, © 2026 Julien Thibeaut)** — https://github.com/ibelick/ui-skills — snippet/why/fix triple format, minimal-fix posture.
- **S4 — make-interfaces-feel-better (MIT, © 2026 Jakub Krehel)** — https://github.com/jakubkrehel/make-interfaces-feel-better — 44×44px touch / 40×40px dense-desktop hit areas.
- **S1 — emilkowalski/skills (MIT, © 2026 Emil Kowalski)** — https://github.com/emilkowalski/skills — reduced-motion gentler-not-zero, hover gating media query, 16px iOS input rule.
- Original synthesis: category-by-category mapping into this harness's numbered procedure and the hit-area/16px integrations.
