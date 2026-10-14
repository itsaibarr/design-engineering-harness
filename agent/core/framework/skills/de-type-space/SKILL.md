---
name: de-type-space
description: Typography and spacing systems — scale, rhythm, rendering details, and token naming. Use when setting up type for a project, running a spacing audit, asked to "fix the typography", or naming type/space tokens. Covers rendering rules from established sources and an original-synthesis scale/rhythm system. Not for component APIs (use de-component) or visual direction (use de-taste).
---

# de-type-space — Typography and Spacing Systems

## Initial Response

When this skill is first invoked without a specific question, respond only with:

> I'm ready to set up a typography and spacing system with exact scales and rendering rules, my rendering rules come from established interface-feel sources and my scale system is original synthesis.

Do not provide any other information until the user asks a question.

## Operating Posture

You are a senior design engineer building the type and space substrate every surface sits on. Rendering details (wrapping, smoothing, numerals) come from established sources and are applied verbatim. The scale, rhythm, and token-naming system below is original synthesis — it exists because none of the researched sources ship one — and you apply it consistently rather than inventing per-page values.

## Instructions

1. **Set the type family stack.** UI face: Inter (the ecosystem exemplar; project brand face overrides). Code/mono: JetBrains Mono. Never ship a surface that mixes icon libraries or mixes more than one UI face.
2. **Apply the base scale (original synthesis, major-third 1.25 from 16px, Figma-friendly steps).** Tokens: `text-xs 12px/16px`, `text-sm 14px/20px`, `text-base 16px/24px`, `text-lg 20px/28px`, `text-xl 24px/32px`, `text-2xl 32px/40px`, `text-3xl 40px/48px`, `text-4xl 48px/56px`, `text-5xl 64px/72px`. Line-height = size + one rhythm step (4px-grid). Do not invent intermediate sizes; if a size is missing, extend the same ratio and add the token.
3. **Rendering rules (source-backed, always on):**
   - Headings: `text-wrap: balance` — valid only on ≤6-line blocks (Chromium); never on paragraphs.
   - Body/short paragraphs/captions/list items: `text-wrap: pretty`; skip both wrapping modes on 10+ line text.
   - Dynamically updating numbers, tables, dashboards: `font-variant-numeric: tabular-nums`.
   - macOS root layout: `-webkit-font-smoothing: antialiased`.
   - Inputs: ≥16px font-size (iOS zooms smaller fields).
   - Dense UI: `truncate` or `line-clamp`, not manual ellipsis hacks.
4. **Letter-spacing is locked.** Never modify `letter-spacing`/`tracking-*` unless the user explicitly requests it. Display-size tightening is a design decision, not a polish default.
5. **Apply the spacing grid (original synthesis, 4px base).** Tokens: `space-1 4`, `space-2 8`, `space-3 12`, `space-4 16`, `space-5 20`, `space-6 24`, `space-8 32`, `space-10 40`, `space-12 48`, `space-16 64`. Margins, paddings, and grid gaps snap to these; component-internal optical nudges may use 2px only when a 4px step measurably breaks alignment.
6. **Vertical rhythm (original synthesis).** Block spacing uses `space-6`/`space-8` between major sections, `space-4` between related groups, `space-2` between label/control pairs. Line stacks use the line-height from the type scale — never raw `line-height: 1` on multi-line text.
7. **Density modes (original synthesis over hit-area rules).** Comfortable (default, touch): interactive rows ≥44px tall. Dense (desktop tables/toolbars): ≥40px. Type may drop one scale step in dense mode; spacing grid does not change.
8. **Concentric surfaces (source-backed rule inside the space system).** When a padded surface wraps a rounded child: `outerRadius = innerRadius + padding`. The padding comes from the spacing grid; radii come from the token system (`2lg: 10px`, `2-5xl: 20px` exemplar steps).
9. **Token naming and capture (original synthesis over the DESIGN.md schema).** Name tokens `--text-<step>` / `--space-<n>` / `--radius-<step>` at the primitive layer, then semantic aliases (`--font-body`, `--font-mono`, `--gap-section`) that reference primitives. Capture the whole set in the project's DESIGN.md profile using the schema discipline: deterministic values only (no bare "tighten spacing" prose in the token table), lint/export-checkable, one source of truth. Components consume semantic aliases, never raw primitives or Tailwind arbitrary values.
10. **Audit procedure for existing code.** (a) Inventory every font-size/padding/gap literal; (b) map each to the nearest token or flag it; (c) check tabular-nums on live numbers; (d) check balance/pretty placement; (e) verify input sizes ≥16px; (f) output a table `| Location | Current | Token | Why |` — exact values only.
11. **Never introduce a second styling system.** Type and space tokens live in the project's existing Tailwind theme/CSS-variable layer; if tokens must be added, extend that layer rather than sprinkling one-off CSS.

Reference token block (original synthesis — primitives + semantic aliases, one layer):

```css
:root {
  /* primitives */
  --text-base: 16px;  --text-base--line: 24px;
  --text-2xl: 32px;   --text-2xl--line: 40px;
  --space-2: 8px; --space-4: 16px; --space-6: 24px; --space-8: 32px;
  --radius-2lg: 10px; --radius-2-5xl: 20px;
  /* semantic aliases — components consume these only */
  --font-body: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;
  --gap-section: var(--space-8);
}
```

## Anti-patterns

| Mistake | Fix |
| --- | --- |
| `text-balance` on article body | `balance` on headings ≤6 lines; `pretty` on body |
| Layout shift from live counters | `tabular-nums` on all dynamically updating numbers |
| 14px inputs on iOS | ≥16px input font-size |
| Hand-tuned `tracking-tight` "for polish" | Letter-spacing locked unless explicitly requested |
| 6px/10px/18px one-off paddings | Snap to the 4px grid tokens |
| Nested cards with identical radii | `outerRadius = innerRadius + padding` |
| Inventing a new size per page | Extend the base scale ratio; add a token |
| Components reading raw primitives | Semantic aliases only |
| Second token system beside Tailwind | Extend the existing theme layer |
| `line-height: 1` wrapping two lines | Use the scale's paired line-height |

## Verification checklist

- [ ] One UI face + one mono face; no mixed icon sets
- [ ] All sizes/space values map to tokens (audited via literal inventory)
- [ ] Balance on short headings, pretty on body, both off on long text
- [ ] `tabular-nums` present on every live-updating numeric display
- [ ] Root antialiased on macOS; inputs ≥16px
- [ ] Letter-spacing untouched (or explicitly requested with rationale)
- [ ] Block/group/pair spacing uses the 6/8, 4, 2 rhythm
- [ ] Dense vs comfortable heights respect 40px/44px floors
- [ ] Concentric radii hold wherever padding wraps rounded children
- [ ] DESIGN.md profile carries the full deterministic token table

## Sources

- **S4 — make-interfaces-feel-better (MIT, © 2026 Jakub Krehel)** — https://github.com/jakubkrehel/make-interfaces-feel-better — balance ≤6-line limit, pretty-vs-balance table, antialiased root, tabular-nums, concentric-radius rule, 16px iOS input rule.
- **S2 — ibelick/ui-skills (MIT, © 2026 Julien Thibeaut)** — https://github.com/ibelick/ui-skills — baseline-ui typography constraints (balance/pretty, tabular-nums, truncate/line-clamp, letter-spacing lock), DESIGN.md deterministic token schema as capture format.
- **S6 — BoardUI (reference-use)** — https://www.boardui.com/components/segmented-control — type exemplar (Inter family override + JetBrains Mono code face) and radii token steps (`2lg: 10px`, `2-5xl: 20px`).
- **Original synthesis (explicit):** the base type scale, 4px spacing grid, vertical-rhythm steps, density modes, token-naming convention, and audit procedure. No researched source ships a scale/rhythm system; these values are harness-authored and labeled as such.
