# SOURCES — Attribution & License Posture

Everything in this harness derives from the sources below. Fetched and read 2026-10-14 (UTC); evidence extract, per-file coverage, and injection scans live in [`research/ledger.md`](research/ledger.md). No source text was copied in bulk — skills restructure and adapt values/structure, with quotes capped at 15 words.

## 1. Attribution table

| # | URL | Type | SHA (where applicable) | License | Fetch method | Status |
|---|-----|------|------------------------|---------|--------------|--------|
| S1 | <https://github.com/emilkowalski/skills> | skills repo (design/animation craft) | `2d228630ba1446365f614a108cb8252f1feda202` | MIT, © 2026 Emil Kowalski | `git clone` + direct read of every file under `skills/` | **READ_FULLY** |
| S2 | <https://github.com/ibelick/ui-skills> | skills repo + Astro site source for ui-skills.com | `c628a5917754ec2396d9cbb47988f280ba1d5cb0` | MIT, © 2026 Julien Thibeaut | `git clone` + deep read of all 8 `skills/` files; site shell sampled | **READ_FULLY** for `skills/` (site shell READ_PARTIALLY — foreign registry entries out of scope) |
| S3 | <https://www.ui-skills.com/skills/ibelick/fixing-accessibility> | skill detail page (rendered S2 file) | n/a (web page) | MIT (same work as S2) | HTTP webfetch (markdown) | **READ_FULLY** |
| S4 | <https://www.ui-skills.com/skills/jakubkrehel/make-interfaces-feel-better> + <https://github.com/jakubkrehel/make-interfaces-feel-better> | skill page + backing repo | repo: `35545ea1512ad59fa463e6b1f95ca9c052981fe6` | MIT, © 2026 Jakub Krehel | HTTP webfetch (page) + `git clone` + read of all 6 markdown files | **READ_FULLY** (page + repo) |
| S5 | <https://www.floguo.com/notes/design-engineering> | personal knowledge-base note (living doc) | n/a (web page) | Reference-use only — page carries no reuse license; **no text copied** | HTTP webfetch (markdown) | **READ_FULLY** (index + full note) |
| S6 | <https://www.boardui.com/components/segmented-control> | component-library doc (React Aria + Tailwind v4, CLI install) | n/a (web page) | Reference-use only — no reuse license asserted on the pages read; **no text copied** | HTTP webfetch ×3 + **BrowserOS neo real-browser pass ~18:00Z** on `/installation` (closed the render gap, incl. `theme.css` dump) | **READ_FULLY** — segmented-control, radio, installation |
| S7 | <https://www.beautifului.dev/> | component showcase for AI-native interfaces (copy-paste; page states MIT, © 2026, by Turbo) | n/a (web page) | Reference-use for this harness — treated as study material; **no text copied** | HTTP webfetch (markdown) | **READ_FULLY** (all 21 numbered sections + footer) |
| S8 | <https://www.inspora.design/?category=Web> | curated inspiration gallery (Next.js) | n/a (web page) | Reference-use only — gallery content belongs to its creators; **no text copied** | HTTP webfetch + curl JSON extraction + websearch fallback, then **BrowserOS neo real-browser pass ~18:00Z** reading all 16 `/posts/*` pages (passed the Vercel checkpoint that blocked curl/webfetch) | **READ_FULLY** — category listing + 16/16 detail pages |
| — | <https://github.com/itsaibarr/harness> | foundation harness (conventions input) | `94a89edf8a21f25ba6e57e067367b652b89cdbfd` | **MISSING** — no LICENSE in tree or history (see §3) | clone + audit (`gh repo view` licenseInfo null) | Audited fully — [`research/foundation-audit.md`](research/foundation-audit.md) |

Fetch anchor: `date -u` 2026-10-14T12:41:14Z (clones), webfetch batch 12:44Z; browser escalation passes ~18:00Z (S8) and ~18:06Z (S6).

### License notes

- **MIT (S1, S2, S4-repo)**: structure and values adapted under MIT terms; copyright retained by Emil Kowalski, Julien Thibeaut, and Jakub Krehel respectively. No large verbatim copies.
- **Reference-use (S5, S6, S7, S8)**: these pages carry no license granting reuse. They were studied for facts, structure, and patterns; **no text from them is reproduced in this harness**. S7's page states MIT © 2026 for its copy-paste components — still consumed here as reference rather than redistributed.
- **S3** is the rendered form of S2's `fixing-accessibility` skill (confirmed identical modulo frontmatter), so no separate license applies.

## 2. Per-skill attribution

Every skill lists a `Sources` section in its own `SKILL.md`; this is the master map (mirrors `ARCHITECTURE.md` §1/§3).

| Skill | Primary | Supporting | Original synthesis (labeled in-file) |
|---|---|---|---|
| `de-feel` | S4 (19 principles, exact values, review table format) | S1 (frequency gate, canonical curves, duration budgets) | quick/full mode thresholds beyond S4's caps |
| `de-motion` | S1 (animate, review-animations + STANDARDS, improve-animations, find-opportunities, animation-performance) | S4 (icon constants, restraint) | — |
| `de-a11y` | S3 (9 ranked rule categories, review triples) | S2 (`fixing-accessibility` file), S4 (44px/40px hit areas), S1 (reduced-motion, hover gating) | gate mechanics over Source 3 rules |
| `de-component` | S6 (segmented-control teardown as the exemplar method) | S2 (`baseline-ui` constraints, `component-canvas` discipline), S1 (Sonner principles, `pick-ui-library` routing) | component spec template field split (`animationMs` vs `dwellMs`) |
| `de-type-space` | S4 `typography.md` (balance/pretty, smoothing, tabular) | S2 `baseline-ui` (bans, tabular), S6 type tokens (Inter, Figma-scaled) | **spacing system** — no source covers spacing rhythm/token naming (gap S6.1 in synthesis) |
| `de-taste` | S5 (material thinking, foundations over showpieces) | S7 (21-pattern quality bar), S8 (16-post inspiration index), S1 ("taste is trained", cohesion) | **brief → mood → tokens method** |
| `de-critique` | S4 (severity table, caps, Block/Needs-changes/Approve ladder) | S1 (review-animations: 10 standards, remedial hierarchy), S2 (`improve-ui`: three-proof gate, read-only, stop-at-3) | — |
| `de-site` | S5 (role framing, foundations, pattern libraries) | S7 (AI-UI + marketing patterns), S8 (portfolio/footer/card genres), S2 (`create-design-md` schema, `fixing-metadata`) | **IA → sections → copy/SEO → polish workflow** |

Reference library: `patterns.md` (S7 primary, S6 support), `teardowns/segmented-control.md` (S6), `inspiration.md` (S8), `tokens.md` (S6 primary, S2 support), `values.md` (S1 + S4, stricter of S2/S6 where applicable). Adaptive layer and gates: foundation conventions adapted, marked original synthesis.

**Out of scope by decision** (recorded so the omission reads as deliberate): S1 `write-swift` (native, not web), `animate-expo` (Expo/Reanimated — platform appendix pointer only in `de-motion`), `ask-sonner` (collapsed into a toast pattern + pick-ui-library rule in `de-component`), S2 `create-design-md` (referenced as upstream tool; the harness stores a profile, not a DESIGN.md).

## 3. Foundation harness — conventions only, license warning

- Source: `https://github.com/itsaibarr/harness` @ `94a89edf8a21f25ba6e57e067367b652b89cdbfd` (master, clean; audited in [`research/foundation-audit.md`](research/foundation-audit.md)).
- **Only conventions were taken**: skill/command file formats, router registration pattern, module layout, `bootstrap.sh` flag mechanics, and the evidence-trail norm. **No foundation files are redistributed** in this repo.
- ⚠️ **License is missing.** No LICENSE/COPYING/NOTICE exists in the tree or history (`git log --all --diff-filter=A` → 0 hits; `gh repo view` licenseInfo null). Two vendored skills declare their own `license: MIT` frontmatter, but the repo as a whole is all-rights-reserved. The foundation audit requires a license be chosen before publish (Phase 6); this repo ships its own explicit license at that point and must not absorb foundation files wholesale until then.

## 4. Injection scan

Every source was scanned for prompt-injection / embedded agent instructions before use.

- **S1**: no malicious instructions. Three **defensive clauses only** (`find-animation-opportunities:29`, `improve-animations:33`, `break-ui:36`) telling a reader that repository content is data, not instructions. `.pl` file verified empty (0 bytes).
- **S2**: none found — only a benign contributor note in `AGENTS.md` and doc links.
- **S4**: none — frontmatter keyword packing is SEO/discovery, not instruction.
- **S5–S8**: none found in any page content.
- **Nothing page-supplied or repo-supplied was followed as an instruction.** Scans are recorded per source in `research/ledger.md` per the hard rule; the harness treats all fetched content as data.
