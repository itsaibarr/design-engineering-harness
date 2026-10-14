# Critique Rubric — severity, caps, verdict, evidence

**Provenance: original synthesis** (S4 review format + S1 review standards + S2 read-only proof gate,
reconciled per `research/synthesis.md` §1.4) per ARCHITECTURE.md §6. Quotes ≤15 words.

Used by `de-critique` and `/de-critique`. Read-only on product source: findings propose fixes, they do not
apply them — fixes go through the build step.

## 1. Severity tiers

| Tier | Definition (any one qualifies) |
|---|---|
| **HIGH** | Inaccessible (keyboard/focus/name/contrast failure), misleading (wrong state, broken claim, dead control), unreadable (content fails at 320px or 200% zoom), or the same disruption happens repeatedly during normal use. |
| **MEDIUM** | Noticeable usability or consistency problem: deviation from `project-profile.md`/tokens, awkward but recoverable flow, state coverage gap (missing loading/empty), motion violating the frequency gate. |
| **LOW** | Isolated polish: one-off spacing/typography nit, minor icon or copy inconsistency, single surface drift. |

## 2. Caps

| Mode | Finding cap | Tiers included |
|---|---|---|
| **quick** (`/de-critique quick`) | **5** | HIGH + MEDIUM only — LOWs are dropped, not downgraded. |
| **full** (`/de-critique` default on diffs > small) | **15** | HIGH + MEDIUM + LOW. |

Excess findings beyond the cap: keep the highest severity, mention the count of the remainder in one line
("N more LOW findings available on request"). Never silently discard HIGHs — if HIGHs alone exceed the cap,
report all HIGHs and say the cap was exceeded.

## 3. Verdict ladder

Report exactly one verdict, highest that applies:

1. **Block** — ≥1 HIGH finding unresolved. Work stops; nothing ships.
2. **Needs changes** — no HIGH, but ≥1 MEDIUM must be fixed first, or a required verification could not run.
3. **Approve** — findings are LOW only (or zero), checklist gates pass, verifications recorded.

## 4. Findings table (required shape)

| Severity | Location | Before | After | Why |
|---|---|---|---|---|

Each row: exact file/line or element path; concrete before/after (code or measured value); one-line reason
tied to `gates/checklist.md` or `project-profile.md`.

## 5. Rejected candidates (required)

A review that only lists problems cannot be trusted — every critique must show what it considered and cut.

| Mode | Count |
|---|---|
| quick | **1–3** rejected candidates |
| full | **2–5** rejected candidates |

Format: `Considered → why rejected` (one line each). Remedial hierarchy: deletion first, then simplification,
then change of approach — before suggesting a new component/motion/dependency.

## 6. Verification list (record what actually ran)

- [ ] `bash gates/audit.sh <target>` — exit code recorded (findings triaged or fixed).
- [ ] Project lint/build/test commands run — output summarized (skipped runs stated as skipped).
- [ ] `gates/checklist.md` — each of the 10 sections passed or waived (waiver ids cited).
- [ ] **10%-speed motion check** for every motion-related finding: replay animations at 10% speed in the
      browser Animations panel (or DevTools slow-mo) and inspect each frame; note what it revealed.
- [ ] Keyboard pass: Tab/Esc/Enter/Space on the changed surface — note the path taken.
- [ ] Before/after screenshot evidence attached for changed UI (foundation `/verify-ui`), per the
      before-and-after evidence rule.

Missing evidence = the affected verification checkbox stays unticked = verdict cannot exceed **Needs
changes**.
