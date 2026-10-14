# Patterns catalog — BeautifulUI's 21 AI-UI components

Source: **S7** `beautifului.dev` (READ_FULLY, all 21 numbered sections) primary; **S6** BoardUI support.
Use with `de-taste` (quality bar) and `de-site`; build with `de-component`.

**How to read each entry:** `what → states → cue`. The *states* line is the coverage this
harness requires when you build the pattern — S7 demonstrates multi-state coverage
(loading / thinking / streaming / empty / draft) as the bar, and its demos run on a
single fictional dataset so the showcase stays coherent. Where a state is explicitly
shown in the S7 demo it is named; the rest is the required set, not a claim about S7.

**Quality cues (the four S7 signals every AI-facing surface should carry):**

- **Liveness** — a progress number is always visible: elapsed time, percent, or fraction.
- **Provenance** — every AI claim names its source: source chips, favicons, file badges.
- **Uncertainty** — the interface admits what it does not know: "Needs review", "No signal",
  confidence meters, context budgets.
- **Multi-state** — empty, loading, streaming, error and draft are designed, not afterthoughts.

## The 21 patterns

1. **Loading State** — pixel-grid loader with shimmer plus an elapsed-time readout.
   States: starting / in-progress / done / failed. Cue: liveness (elapsed seconds), never a bare spinner.
2. **Thinking** — expandable trace stack exposing steps, reasoning, search and coding work.
   States: collapsed / expanded / running / step-failed / complete. Cue: provenance — each trace names what the agent actually did.
3. **Streaming Text** — token-by-token answer with inline source chips (favicon + domain), e.g. "10 sources".
   States: streaming / complete / interrupted / no-sources. Cue: provenance on every claim.
4. **Approval Card** — the human-in-the-loop question an agent asks before it acts.
   States: pending / approved / denied / expired. Cue: uncertainty made explicit — what the agent is unsure of, stated.
5. **Tool Chips** — compact counters for side effects ("4 tool calls, 2 messages").
   States: idle / running / succeeded / failed. Cue: liveness counts.
6. **Task Rows** — live per-task status of an agent run.
   States: queued / running / blocked / done / retrying. Cue: always-visible progress per row.
7. **Chat** — conversational thread that stamps each step with its own duration ("for 4s").
   States: awaiting / streaming / complete / failed. Cue: liveness timing per step.
8. **Prompt Bar** — composer with `@` sources, `/` commands and a model picker.
   States: empty / typing / attachments-bound / submitting / disabled. Cue: provenance of what the prompt will touch.
9. **Recommendation Card** — a suggested action carrying its confidence ("High confidence").
   States: high / low / no-confidence, accepted / dismissed. Cue: uncertainty label.
10. **Context Cards** — context-budget meters with character counts ("290 characters").
    States: under-budget / near-limit / over-budget. Cue: liveness number + uncertainty at the edge.
11. **Diff Table** — AI-proposed edits sweeping across tabular data.
    States: proposed / accepted / rejected / partially-applied. Cue: provenance — which cell the model touched.
12. **Records Table** — records with connection tiers and relative freshness ("4 days ago").
    States: synced / stale / error / disconnected. Cue: uncertainty via freshness.
13. **Filter Table** — work queues with live filter counts ("All 5 · To do 2 · In Progress 2 · Completed 1").
    States: unfiltered / filtered / no-match. Cue: liveness counts keep the empty state honest.
14. **Sidebar Nav** — navigation with gliding hover states and a quota meter ("3/10").
    States: default / hover / active / quota-exhausted. Cue: liveness quota.
15. **Search** — live filtering that ships a designed empty state.
    States: idle / typing / loading / no-results. Cue: empty state is first-class, not an afterthought.
16. **Flowchart** — dotted-canvas node graph with If/Else branches.
    States: idle / running / branch-taken / branch-failed. Cue: provenance of why a branch fired.
17. **Insight Cards** — metric deltas with direction ("Mint Chip -4.41%").
    States: positive / negative / flat / no-data. Cue: uncertainty label when there is no signal.
18. **Code Block** — source with line numbers and a Code/Diff toggle.
    States: code / diff / copied / error. Cue: provenance of the proposed change.
19. **Fine-tune Card** — parameter inspector (Radius / Opacity) for adjusting output.
    States: default / dirty / applied / reverted. Cue: the changed value is visible before commit.
20. **Selection Actions** — contextual actions on selected text (Explain / Improve; Shorten / Tone / Grammar).
    States: nothing-selected / selected / running / done. Cue: provenance of what the rewrite touched.
21. **Agent Screen** — live view onto the agent's own screen ("watch an agent's screen").
    States: live / paused / ended / reconnecting. Cue: liveness; the feed never silently dies.

## BoardUI Blocks overlap (S6 support)

BoardUI (S6) is the primitive source — React Aria behavior, semantic tokens, CLI install —
and per ARCHITECTURE §2 its Blocks (pre-composed sections) overlap this catalog. Harness rule
(**synthesis §1.5, primitives over hand-rolls**): where a pattern above is mostly composition
of primitives, build the primitive half from BoardUI/React Aria first and take only the
AI-specific *states and cues* from this catalog; never hand-roll keyboard/focus behavior to
reproduce a showcase. Note: the ledger records no itemized Blocks inventory for S6 — overlap
is asserted at the method level (primitive → composition → AI states), not enumerated per block.

**Catalog rule:** before authoring a new AI-interface component, check these 21. If the
pattern exists, ship its full state set plus liveness/provenance/uncertainty cues — a
happy-path shell is a finding, not a build. Any showpiece-level inspiration borrowed from
S8 must clear the same bar: states + a11y + reduced-motion (`inspiration.md`).
