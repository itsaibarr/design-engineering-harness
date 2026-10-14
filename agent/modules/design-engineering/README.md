# design-engineering module

Reference library + quality gates backing the eight `de-*` skills: pattern catalog,
component teardowns, inspiration index, token exemplar, magic-number table, and the
blocking checklist/rubric.

Loads when a `de-*` skill or `/de-*` command resolves a path into `references/` or
`gates/` — e.g. `de-component` → `references/teardowns/segmented-control.md`,
`de-critique` → `gates/critique-rubric.md`. Nothing here self-loads; router and skills decide.

Evidence: every entry cites a source ID (S1–S8) resolvable in `research/ledger.md`
(all 8 READ_FULLY, 2026-10-14); cross-source conflicts resolved per `research/synthesis.md` §2.
Quotes ≤15 words; everything else is paraphrase.
