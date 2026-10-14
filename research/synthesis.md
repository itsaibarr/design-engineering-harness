# Synthesis — where sources agree, conflict, and gap

Derived only from `research/ledger.md` evidence (fetched 2026-10-14). No assumed knowledge.

## 1. Where they agree (encode as defaults)

1. **Motion is gated by frequency, not taste.** Emil frequency table (100+/day never / tens-day near-imperceptible / occasional standard / rare delight) is restated in `animate`, `find-animation-opportunities`, `review-animations/STANDARDS.md`; jakub "Motion Restraint / no custom animation on high-frequency" + `≤150ms` rule agrees; ibelick `baseline-ui` goes further (NEVER add animation unless requested, 200ms feedback cap). Encode: frequency gate FIRST.
2. **GPU-only properties.** Emil (`transform`+`opacity`, clip-path sanctioned fourth) = ibelick fixing-motion-performance (composite vs paint vs layout) = jakub (never `transition: all`, will-change only transform/opacity/filter). Encode: exact-property transitions.
3. **Canonical micro-values converge.** Press scale Emil `0.97` vs jakub `0.96` (both bound 0.95–0.98 — same band); stagger Emil 30–80ms vs jakub ~100ms infrequent-only (compatible: keep 30–80 default, ~100 for staged hero); tabular-nums, text-balance/pretty, antialiased root, 44px touch / 40px dense-desktop hit areas, `prefers-reduced-motion` = gentler-not-zero, hover gating — all three skill families agree.
4. **Review = table + verdict + rejected.** Emil Before/After/Why table, jakub Severity/Location/Before/After/Why + Block/Needs-changes/Approve + Considered-but-Rejected, ibelick snippet/why/fix triple, improve-ui three-proof gate. Encode one review shape.
5. **Primitives over hand-rolls.** BoardUI (React Aria ToggleButtonGroup, key-set API) = ibelick (Base UI/React Aria/Radix, "never rebuild keyboard/focus") = Emil `pick-ui-library` (one recommendation, mismatch catchers). Encode: route to primitives.
6. **Agent-era workflow.** Floguo (rams/UI-Skills/Vercel guidelines, annotation, before/after PR screenshots) = BoardUI (Agent Skills, MCP, RTL pages) = BeautifulUI (approval cards, provenance, confidence) = ibelick `ui-skills-root` routing + `component-canvas` preview discipline. Encode: route → build → verify-sight-loop → PR evidence.

## 2. Conflicts + resolutions

| # | Conflict | Resolution + reasoning |
|---|----------|------------------------|
| 1 | ibelick `baseline-ui` "NEVER add animation unless requested" vs Emil/jakub "animate where justified" | Adopt Emil gate as default (allows justified motion), `baseline-ui` ban as the **personal-website preset default** (restrained) with explicit opt-in per surface. Reasoning: ban is a preset choice, not a universal truth; gate preserves both. |
| 2 | BoardUI manual class-based dark mode ("never reads OS preference") vs ecosystem system-follow default | Adopt BoardUI rule **inside BoardUI-derived components** (semantic tokens, no component `dark:`, pre-hydration script); elsewhere default to system-follow via `next-themes` per stack preset. Reasoning: deviation is documented and token-coupled — don't generalize it. |
| 3 | Floguo foundations-first vs Inspora showpiece-first | Both: Inspora supplies detail/motion cues for the inspiration index; floguo/BoardUI supply systems. Harness rule: every Inspora-derived pattern must ship with states + a11y + reduced-motion before it counts as done. |
| 4 | Press scale 0.97 (Emil) vs 0.96 (jakub); stagger 30–80 vs ~100ms | Encode range `0.95–0.98`, default `0.96` (jakub precision) with Emil `0.97` as acceptable alt; stagger 30–80ms default, ~100ms only for infrequent staged entrances. Reasoning: bands overlap; stricter default wins. |
| 5 | Blur caps: Emil `<20px` (crossfade 2px) vs ibelick `≤8px` animated | Encode: animated blur `≤8px`, static/crossfade assist `≤20px`. Reasoning: ibelick constrains the animated path (compositor cost), Emil the general ceiling. |
| 6 | Spring config: Apple `{duration:0.5,bounce:0.2}` vs `{mass:1,stiffness:100,damping:10}`; jakub icon spring `duration:0.3,bounce:0` | Encode: Apple-style default; traditional physics when control needed; jakub `bounce:0` for icon cross-fades specifically. Not contradictory — scoped. |
| 7 | Toast timing naming: animation 400ms vs Sonner auto-close 4000ms | Encode as separate fields (`animationMs` vs `dwellMs`) in component spec template. Prevents the easy confusion flagged at this SHA. |

## 3. Gaps none of them cover

1. **Typography/spacing system construction** — sources give rendering details (balance/pretty, tabular, smoothing) but no type-scale, spacing-rhythm, or token-naming system (beyond DESIGN.md schema). Harness must add original-synthesis type/space skill.
2. **Creative direction / taste formation** — Emil "taste is trained" + Inspora gallery + BeautifulUI bar, but no brief-to-direction method. Harness adds `visual-taste` interview + mood-to-tokens (labeled original synthesis).
3. **Full-page personal-website workflow** — sections (hero/work/about/contact/footer), IA, copy, SEO/social cards (ibelick fixing-metadata covers tags, not story). Harness adds `personal-website` workflow (original synthesis built on Sources 5/7/8).
4. **Cross-page consistency + visual regression** — foundation `verify-ui` is single-URL screenshots; no route matrix or token-drift checks. Harness adds quality-gate matrix (original synthesis).
5. **Measured a11y metrics in gates** — contrast numbers, focus-order test, hit-area measurement absent from verify scripts. Harness adds checklist + script hooks (original synthesis over Source 3 rules).
6. **Inspora motion detail** — blocked detail pages leave hover/motion specifics at listing level. Marked as limitation; harness encodes only what listing + 2 indexed descriptions support.
