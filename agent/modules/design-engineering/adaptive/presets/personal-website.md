# Preset — Personal Website

**Provenance: original synthesis** (workflow from ARCHITECTURE.md §4.5; section structure from S5/S7/S8 as
recorded in `research/synthesis.md`). Goals below are defaults the `/de-start` interview fills or overrides;
no source text copied.

**Load with:** `de-site` (workflow) + `de-taste` (direction) — see `../adaptive/routing.md`. Fill this file
during the interview, then reuse it across sessions; `project-profile.md` (tone, brand, motion budget)
answers anything this preset leaves open.

## Goals

- **Positioning:** one sentence a visitor can repeat after closing the tab — who you are, what you ship, for
  whom. Everything else serves this line.
- **Proof over claims:** every claim of skill shows an artifact (project, screenshot, case note) with
  **provenance** — pattern borrowed from a source gets its source named; a result you claim gets its
  evidence attached.
- **Contact is a product surface:** it must be reachable from every section and work with keyboard alone.

## Sections (default IA, in order)

| # | Section | Job to be done | Must-haves |
|---|---------|----------------|------------|
| 1 | **Hero** | Positioning + first impression in ~5s | One headline (≤2 lines), one primary CTA, one supporting line; no carousel |
| 2 | **Work** | Evidence — the reason the site exists | 3–6 items, each with role/outcome/link; loading + empty states designed |
| 3 | **About** | Trust — who is behind the work | Short bio, one human detail, skills as plain text (not badges by default) |
| 4 | **Contact** | Convert interest into a message | Labeled inputs, inline errors, explicit success state |
| 5 | **Footer** | Showpiece — the memorable exit | See footer doctrine below |

Order is default, not law: `/de-site-section <name>` builds one section at a time; reorder only with a
stated reason logged in `decisions.md`.

## Motion

- **Default: restrained** (synthesis resolution #1 — this preset keeps the "only if requested" stance; other
  projects may raise the budget in `project-profile.md`).
- Allowed by default: entrance on hero once per load, hover/press feedback within the 300ms cap,
  scroll-reveal for Work cards with stagger 30–80ms.
- Requires explicit opt-in per surface: parallax, scroll-scrub, cursor-followers, autoplay media.
- Every motion ships a `prefers-reduced-motion` gentler variant; frequency gate still applies.

## Footer-as-showpiece

The footer is this preset's one sanctioned expressive surface (Inspora genre evidence: footers are a
first-class category). Doctrine:

- One memorable, *cheap-to-run* idea (illustration, oversized type, ambient loop) — not a second hero.
- Still fully functional: nav links, contact, legal; keyboard reachable; contrast passes in dark mode.
- Same opt-outs as everywhere: reduced-motion variant, no layout-thrashing animation, blur ≤8px if used.

## Per-pattern provenance

When a section borrows a pattern from `references/patterns.md` or `references/inspiration.md`, record in the
section file:

```
Pattern: <name> | Source: <S7 section / S8 post slug> | Adapted: <what changed and why>
```

Rule (synthesis resolution #3): a borrowed pattern counts as done only with **states + a11y +
reduced-motion** shipped alongside it.

## Done means

`gates/checklist.md` passes (or waived via `decisions.md`), `gates/audit.sh` exits 0, `de-critique` returns
Approve, and before/after screenshots exist for every changed section.
