---
name: de-taste
description: Creative direction — turns a brief into a mood, tokens, and detail cues, and checks work against a concrete quality bar. Use when starting a new page or site, when asked to "make it beautiful", or for a direction/mood review before build. Foundations first, showpieces second. Not for critique with a ship verdict (use de-critique) or the full site build workflow (compose de-site).
---

# de-taste — Creative Direction

## Initial Response

When this skill is first invoked without a specific question, respond only with:

> I'm ready to shape creative direction from brief to tokens, my quality bar comes from AI-native interface galleries and design-engineering foundations philosophy.

Do not provide any other information until the user asks a question.

## Operating Posture

Taste is trained, not innate — you demonstrate it by reasoning from evidence (studied galleries, a stated mood, the project's own foundations) instead of asserting preferences. Foundations beat showpieces: a cohesive system applied everywhere outranks one spectacular section. You produce a direction document, not code, unless asked to build.

## Instructions — brief-to-direction method (original synthesis)

1. **Extract the brief's job.** One sentence: who this surface is for, what decision it should drive, what it must never feel like. If the brief can't answer, ask exactly one clarifying question, then proceed with a stated assumption.
2. **Pick three mood words with opposites.** e.g. "precise, warm, restrained" (not "modern, clean, premium" — those are defaults). Each word gets a one-line anti-goal (what it is not).
3. **Derive tokens from the mood, not from a picker.**
   - Color: ≤1 accent from one ramp (`--color-accent-50…950`, 11 stops). One neutral family. No gradients unless the brief demands them; never purple/multicolor gradients; no glow as primary affordance. One accent per view.
   - Type: map mood to weight/size posture using the de-type-space scale (e.g. restrained → base sizes, regular/medium weights only; editorial → step display sizes up one notch). Letter-spacing stays locked.
   - Space/density: comfortable (44px rows) for marketing/reading; dense (40px) for tooling. Section rhythm from the space grid (`space-6`/`space-8` between major blocks).
   - Radius/depth: pick one concentric family (`outerRadius = innerRadius + padding`); elevation via soft shadows (6%/10% recipe), never faked borders.
   - Motion budget: state it explicitly — restrained (personal-site default: no unsolicited animation, ≤200ms feedback when requested) or standard (Emil frequency gate applies: occasional surfaces may animate, high-frequency surfaces never).
4. **Choose detail cues from the quality bar** (see step 5), 3–5 cues maximum tied to the mood words. Every cue must be implementable as a token or a state rule — "more delightful" is not a cue.
5. **Run the AI-native quality bar on the direction** (studied from BeautifulUI's 21-pattern corpus):
   - Liveness: any progress/loading/success surface shows elapsed time, percent, or fraction — always visible, never a bare spinner when a number exists.
   - Uncertainty: AI or estimate-driven claims carry explicit labels ("Needs review", "No signal", confidence meters).
   - Provenance: every claim or generated artifact shows its source (file badge, source chip, timestamp).
   - Multi-state coverage: the direction names states for loading, thinking/streaming, empty, error, and draft — a direction that only specifies the happy path is incomplete.
   - Coherence: one consistent fictional-real dataset/vocabulary across the demo surfaces, so the system reads as one product.
6. **Ground it in the inspiration index.** When the brief matches a genre (footer, cards, portfolio/identity, menu/FAQ, motion demo), pull 1–2 tagged references from the harness inspiration index (`agent/modules/design-engineering/references/inspiration.md`) and state why each works (one line) plus which tokens you're borrowing. Borrowed patterns must eventually ship states + a11y + reduced-motion — direction ≠ exemption.
7. **Emit the direction document:** job statement; three mood words + anti-goals; token decisions (color/type/space/radius/motion); 3–5 detail cues; 1–2 inspiration references; explicit non-goals list (at least three things this will NOT do). The non-goals list is mandatory — direction without refusals is a wishlist.
8. **Quality-gate evidence.** When direction work follows a build, require before/after screenshots on the PR — feel claims need visual proof, not adjectives.

Direction-document skeleton (fill every field; blank = not done):

```
Job: {who} → {decision} → {must never feel like X}
Moods: {word} (not {anti-goal}) · {word} (not {anti-goal}) · {word} (not {anti-goal})
Tokens: accent {one ramp stop range} · type {posture from de-type-space scale} ·
        space/density {comfortable 44px | dense 40px} · radius family {…} ·
        motion budget {restrained | standard + frequency-gate note}
Detail cues (3–5): {token/state-level cue} …
Inspiration: {genre-tagged ref} — why it works: {one line} …
Non-goals (≥3): {refusal} · {refusal} · {refusal}
```

## Anti-patterns

| Mistake | Fix |
| --- | --- |
| Mood words "modern, clean, premium" | Three specific words + one-line anti-goals each |
| Accent picked before mood is stated | Mood → token derivation order, always |
| Gradient/glow soup | ≤1 accent ramp; no purple/multicolor; glow never primary |
| Direction covering only the happy path | Name loading, empty, error, draft states |
| "Make it pop" as a detail cue | Every cue maps to a token or state rule |
| Showpiece section, broken system | Foundations first; cohesion over spectacle |
| Inspiration copy without obligations | Borrowed pattern ships states + a11y + reduced-motion |
| No non-goals | ≥3 explicit refusals in every direction |
| Adjective-only review | Before/after screenshots as evidence |

## Verification checklist

- [ ] One-sentence job statement present; assumptions stated if brief was thin
- [ ] Three mood words, each with an anti-goal
- [ ] Tokens derived from mood: color, type, space/density, radius/depth, motion budget
- [ ] ≤1 accent, one neutral family, no unsolicited gradients/glow
- [ ] Quality bar checked: liveness, uncertainty labels, provenance, multi-state, coherence
- [ ] 1–2 tagged inspiration references with one-line "why it works"
- [ ] 3–5 implementable detail cues (token- or state-level)
- [ ] Non-goals list has ≥3 entries
- [ ] Motion budget explicitly stated (restrained vs standard + frequency gate)
- [ ] Evidence plan: before/after screenshots when this direction ships

## Sources

- **S5 — floguo notes, design-engineering (reference-use)** — https://www.floguo.com/notes/design-engineering — foundations-over-showpieces, "think in the final medium", before/after screenshot evidence rule.
- **S7 — BeautifulUI (reference-use)** — https://www.beautifului.dev/ — 21-pattern quality bar: always-visible liveness, explicit uncertainty labels, provenance chips, multi-state coverage, single coherent dataset.
- **S8 — Inspora (reference-use)** — https://www.inspora.design/?category=Web — genre taxonomy and tag vocabulary (Industries/Colors/Styles) feeding the inspiration-index step.
- **S1 — emilkowalski/skills (MIT, © 2026 Emil Kowalski)** — https://github.com/emilkowalski/skills — "taste is trained, not innate" framing and cohesion-as-review-standard.
- **S2 — ibelick/ui-skills (MIT, © 2026 Julien Thibeaut)** — https://github.com/ibelick/ui-skills — baseline design bans (gradients, purple/multicolor, glow, accent-per-view) as the restrained default.
- **Original synthesis (explicit):** the brief → mood → tokens → detail-cues method, the anti-goal requirement, and the non-goals mandate. No researched source ships a brief-to-direction procedure; this method is harness-authored.
