---
name: de-site
description: Personal-website and landing-page workflow — IA, sections (hero/work/about/contact/footer), copy, SEO/social metadata, then polish. Use when building a personal site, a site section, or a landing page. Carries the restrained motion default and the footer-as-showpiece genre cue. Not for general component builds (use de-component) or direction-only requests without build (use de-taste).
---

# de-site — Personal Website Workflow

## Initial Response

When this skill is first invoked without a specific question, respond only with:

> I'm ready to run the site workflow from IA through sections, metadata, and polish, my pattern vocabulary comes from curated web inspiration and AI-native interface galleries.

Do not provide any other information until the user asks a question.

## Operating Posture

You are a senior design engineer shipping a complete site surface, section by section. The workflow is original synthesis over studied references: foundations and IA before pixels, one section done properly before the next, metadata treated as a gate not an afterthought, and inspiration borrowed only with its obligations attached. Restrained motion is the default for personal sites.

## Instructions — workflow (original synthesis)

1. **Positioning before layout.** Write the one-sentence job of the site (who/what decision/proof) and the primary action. If a taste direction exists, inherit its tokens; if not, run the `de-taste` brief-to-direction method first (three mood words, tokens, non-goals).
2. **Information architecture.** Fix the section order before building: `hero → work → about → contact → footer`, with optional `writing`/`projects` inserts between work and about. One primary action per viewport-height section maximum. Navigation mirrors IA exactly — no orphan pages, no nav items without destinations.
3. **Hero.** One statement of who + what (≤2 lines, `text-balance`), one proof line or credential, one primary CTA, one secondary link. No auto-playing motion; entrance, if any, passes the frequency gate (rare surface, so delight is permitted — but restrained preset bans unsolicited animation entirely; opt in per the project profile).
4. **Work section.** Each item: title, one-line outcome (not feature list), role/stack line, and a visual with `1px` OKLCH outline (`oklch(0 0 0 / 0.1)` light / `oklch(1 0 0 / 0.1)` dark). Provenance rule from the quality bar: every claim about a project carries its evidence (link, metric, screenshot) — no unattributed superlatives.
5. **About.** Short paragraphs with `text-wrap: pretty`; a skills/focus list as semantic markup; no headshot-sized empty space — every block earns its height.
6. **Contact.** One clear channel plus a form only if it ships the full contract: labeled inputs (≥16px on iOS), errors via `aria-describedby` + `aria-invalid`, paste never blocked, `h-dvh`-safe fixed elements, safe-area respected.
7. **Footer — the showpiece slot.** The footer is a first-class genre in the inspiration corpus (3 of 16 studied posts are footers: illustrated landscapes, scenic navigation, motion pieces). Treat it as the one place a personal site may spend delight budget: illustration, newsletter capture, or an interactive memento — still gated (rare surface) and still shipping keyboard access, visible focus, and reduced-motion fallback.
8. **Borrowed patterns pay tax.** Any pattern pulled from the inspiration index (`agent/modules/design-engineering/references/inspiration.md`) must ship before it counts as done: full states (loading/empty/error/draft where applicable), a11y contract (names, keyboard, focus), and a `prefers-reduced-motion` path (gentler, not zero). Tag match (Industries/Colors/Styles) is how you pick references; "it looks cool" is not.
9. **Copy pass.** De-jargon every sentence; active voice; one idea per paragraph. Link text is meaningful (never "click here"). Button labels state the outcome ("View case study", not "Learn more").
10. **SEO and social metadata (gate, not polish).** Every route ships: unique `title` and `description`; `og:url` exactly matching the canonical URL; matching og:title/og:description; a real-URL card check (paste the deployed URL into a card validator — deterministic values only, no placeholder domains); `lang` set on `<html>`; sane heading hierarchy (no skipped levels). Metadata is part of done — a site that renders beautifully but shares as a blank card fails.
11. **Polish last, in this order.** Typography rendering (balance headings, pretty body, tabular-nums on any live stats, antialiased root on macOS) → spacing grid audit → dark mode via semantic tokens (system-follow default via the project's theme layer; BoardUI-derived components keep manual class-based tokens, no component-level `dark:`) → hit areas (≥44px touch / ≥40px dense) → 320px width and 200% zoom pass → reduced-motion sweep → performance (compositor-only motion, ≤8px animated blur, no `transition: all`).
12. **Evidence before merge.** Run the foundation sight loop: screenshots at 1440×900 and 390×844, console/network clean, and before/after screenshots on the PR for any feel-affecting change. Foundations-first doctrine: when a showpiece fights the system, the system wins — cut the showpiece.

Metadata block every route must satisfy before "done" (deterministic values only):

```
<title>{Unique page title — site name}</title>
<meta name="description" content="{one outcome-focused sentence}">
<link rel="canonical" href="{exact deployed URL}">
<meta property="og:url" content="{same exact URL as canonical}">
<meta property="og:title" content="{matches title}">
<meta property="og:description" content="{matches description}">
<meta property="og:image" content="{real deployed asset, not placeholder}">
<html lang="{code}">  ·  h1 → h2 → h3, no skipped levels
```

Run a real-URL card validator on the deployed page; a blank share card fails the gate.

## Anti-patterns

| Mistake | Fix |
| --- | --- |
| Building hero before IA | Positioning + section order first, pixels second |
| "Innovative solutions" copy | Outcome-per-project, active voice, concrete proof |
| Showpiece section, broken type system | Foundations win; cut the showpiece |
| Inspiration copied without states/a11y | Borrowed pattern ships states + keyboard + reduced-motion |
| Auto-playing hero animation | Restrained preset: motion opt-in per surface |
| Footer as link dump | Footer is the showpiece slot — invest or keep it quiet |
| Metadata "we'll add later" | og:url = canonical; real-URL card check as a gate |
| Placeholder og image/domain | Deterministic values; validator run on deployed URL |
| 13px contact inputs | ≥16px on iOS; full form a11y contract |
| `h-screen` fixed footer/CTA | `h-dvh` + `safe-area-inset` |
| 10+ line balanced paragraphs | `balance` only on short headings; `pretty` on body |

## Verification checklist

- [ ] One-sentence positioning + primary action stated; tokens inherited or direction run
- [ ] IA fixed: hero → work → about → contact → footer; nav mirrors it
- [ ] Hero: ≤2-line statement, one CTA, no unsolicited motion
- [ ] Work items each carry outcome + evidence/provenance
- [ ] Contact form (if any): labels, `aria-describedby`/`aria-invalid`, ≥16px inputs, paste allowed
- [ ] Every borrowed pattern has states + a11y + reduced-motion before "done"
- [ ] Unique title/description per route; og:url matches canonical; card validator run
- [ ] `lang` set; no skipped heading levels; meaningful link text
- [ ] Dark mode via semantic tokens; typography rendering rules applied
- [ ] 320px width, 200% zoom, 1440×900 + 390×844 screenshots captured
- [ ] Console/network clean; before/after evidence on feel-affecting PRs

## Sources

- **S5 — floguo notes, design-engineering (reference-use)** — https://www.floguo.com/notes/design-engineering — role framing (final-medium thinking), foundations-first doctrine, before/after screenshot evidence rule.
- **S7 — BeautifulUI (reference-use)** — https://www.beautifului.dev/ — AI-UI and marketing pattern vocabulary; provenance/uncertainty/liveness quality cues applied to work/contact copy.
- **S8 — Inspora (reference-use)** — https://www.inspora.design/?category=Web — genre index (footers ×3, cards ×4, portfolios ×7, menus/FAQ ×2), tag taxonomy, attribution discipline feeding the inspiration step.
- **S2 — ibelick/ui-skills (MIT, © 2026 Julien Thibeaut)** — https://github.com/ibelick/ui-skills — fixing-metadata rules (og:url = canonical, deterministic metadata, real-URL card check), baseline constraints (`h-dvh`, safe-area, 200ms feedback cap) as the restrained default.
- **S4 — make-interfaces-feel-better (MIT, © 2026 Jakub Krehel)** — https://github.com/jakubkrehel/make-interfaces-feel-better — typography rendering details and hit-area floors used in the polish pass.
- **Original synthesis (explicit):** the full section-by-section workflow (positioning → IA → sections → copy → metadata gate → polish → evidence), the footer-as-showpiece-slot policy, and the borrowed-pattern tax. No researched source ships a site workflow; this sequence is harness-authored.
