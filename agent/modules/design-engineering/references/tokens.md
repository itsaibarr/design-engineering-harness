# Tokens — system exemplar + capture format

Source: **S6** BoardUI `theme.css` (rendered dump read in browser, 2026-10-14) primary;
**S2** ibelick `create-design-md` as the capture format. Consumed by `de-type-space`, `de-component`,
`de-taste`. Numbers here are exemplar values — the *system shape* is what travels to other projects.

## 1. Layer order

```
primitives (raw scales)  →  semantic pairs (light/dark)  →  component tokens  →  utilities
```

Components read semantic tokens only. Two hard rules from S6: **no `dark:` prefixes inside
components** (the root class swaps semantic values), and **every interactive surface reads the one
accent ramp**. A re-brand is a ramp override, not a file-wide search-and-replace.

## 2. Primitives

- **Color space:** OKLCH. Almost the entire palette matches Tailwind v4's OKLCH defaults —
  adopt the defaults and change only what is deliberately brand-owned (S6 palette note).
- **Type:** one family override — **Inter** for everything, **JetBrains Mono** for code. Rendering
  details (balance/pretty ≤6 lines, tabular numerals, root antialiasing) live in `values.md`.
- **Radius:** `--radius-2lg: 10px` (an extra step inserted between Tailwind's `lg` and `xl`) and
  `--radius-2-5xl: 20px`. Keep a composed-radius rule with them: outer radius = inner radius +
  padding (S4 `surfaces.md:10`), so nested surfaces stay concentric.
- **Shadow:** Figma's **6% / 10%** opacity recipe — deliberately softer than Tailwind v4's 10% / 10%.
  Two-stop recipe: ambient 6%, key 10%; elevation tiers vary radius/offset, not a third opacity.

## 3. Accent ramp — 11 stops, one override point

```
--color-accent-50 … --color-accent-100 · 200 · 300 · 400 · 500 · 600 · 700 · 800 · 900 · 950
```

Eleven variables (50→950). Overriding them re-tints the whole system (S6 browser pass). Rules:
one ramp per brand; text/border/icon states pick stops by contrast need (e.g. `accent-600` on
`accent-50` fills) rather than hardcoded hex; never introduce a second brand hue ramp — add a
semantic alias (`--color-success`, `--color-danger`) mapped to its own primitives instead.

## 4. Semantic light / dark pairs

Semantic tokens exist as a **pair** — one name, two values, swapped by the root theme class:

| Semantic slot | Light value | Dark value | Example component |
|---|---|---|---|
| `--color-segmented-control-background` | `var(--color-neutral-100)` | `neutral-925` | segmented-control track |
| segmented-control thumb | `white` | `neutral-800` | active segment |
| surface / surface-raised | per pair | per pair | cards, popovers |
| border / border-strong | per pair | per pair | dividers, inputs |
| text / text-muted | per pair | per pair | body, metadata |

(S6 light token + dark track/thumb evidence; see `teardowns/segmented-control.md` §5.)
Direction of the pairing matters: in both themes the *active/raised* value sits one step lighter
than its container, so state reads without borders or shadows.

**Dark-mode doctrine (S6, scoped — synthesis §2.2):** manual, class-based, no OS-preference reads,
pre-hydration script to avoid flash. Outside BoardUI-derived components the project default is
system-follow. Record any deviation in the decision log.

## 5. Capture format — DESIGN.md (S2)

S2's `create-design-md` is the upstream emitter; the harness stores a **project profile**, not a
DESIGN.md (ARCHITECTURE §1), but when a project wants the artifact, capture it in this shape and
validate it:

```markdown
# DESIGN.md — <project>
## Color      primitives (OKLCH) · semantic pairs light|dark · accent ramp (11 stops)
## Type       family(s) · scale steps · weights · numerals (tabular where data)
## Radius     steps + composed-radius rule (outer = inner + padding)
## Shadow     opacity recipe + elevation tiers
## Motion     curves · duration bands · scale/stagger/blur caps → cite values.md
## Spacing    rhythm base · component insets
## Elevation/z-index   named scale, no magic numbers
```

Validation (S2 technique): the file must **lint and export** — every token referenced by code
resolves, every defined token is used or explicitly marked; and each change to it carries S2's
three-proof entry (Observation / Basis / Consequence, `create-design-md:87-91`) so token edits are
argued, not drifted.

## 6. Rules of use

1. Components consume semantic tokens; raw palette and component-level `dark:` are review findings.
2. Re-brand = override the 11 accent stops (+ type family); never fork component files for color.
3. Any token added must arrive as a light/dark pair with a named component consumer.
4. Values quoted here (radius, shadow, ramp) are S6 exemplar — replace the palette, keep the layers.
5. Magic numbers behind these tokens are catalogued with provenance in `values.md`.
