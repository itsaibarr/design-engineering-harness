# Adaptive Routing — stack detection rules + skill routing table

**Provenance: original synthesis.** Adapted from ARCHITECTURE.md §4, the conflict resolutions in
`research/synthesis.md`, and foundation conventions (`ui-skills-root` routing cap, Emil pick-ui-library).
No source text copied.

Stack facts decide *how* to implement. Task type decides *which* skills load. Both must be checked
before writing code.

## 1. Stack detection rules

Run first: `bash agent/modules/design-engineering/adaptive/detect.sh <target-project>` (read-only).
Apply the row matching each detected axis. When several values print on one axis, apply every matching row.

| Axis | Detected | Rule |
|---|---|---|
| Styling | tailwind | Use the existing utility scale and theme tokens; extend the scale instead of hard-coding values. |
| Styling | css modules / vanilla-extract / plain css | Stay in the current stylesheet conventions. Never introduce Tailwind (or any second system) alongside it. |
| Styling | emotion / styled-components | Keep decisions in the current CSS-in-JS setup; colocate variants with the component. |
| Styling | *none detected* | Propose exactly one system (default: Tailwind) and only after the user confirms. |
| Animation | motion / framer-motion | Prefer Motion primitives (`motion.*`, layout animations, springs) over hand-rolled JS. |
| Animation | gsap / react-spring / animejs | Stay on the installed library; do not add a second animation runtime. |
| Animation | css transitions/waapi (no library) | Cheapest-tool ladder: CSS transitions first; WAAPI for orchestration; add a library only for gestures or layout choreography the package is already present for. |
| Components | radix-ui / base-ui / shadcn / react-aria present | Reuse the installed primitives. Never rebuild keyboard, focus, or portal behavior by hand. |
| Components | none detected | Recommend exactly one library (Radix or Base-UI for accessible behavior, shadcn if the project wants copy-in). Hand-roll only trivial triggers. |
| Framework | next (App Router) | Server-first: default to Server Components; put client boundaries only where interaction requires them. |
| Framework | other (vite/react, astro, svelte, vue, plain) | Follow the detected framework's file, routing, and styling conventions. |

Cross-cutting rule (always): **one styling system, one animation runtime, one primitive source.** Detection
exists to prevent drift, not to grow the dependency set.

## 2. Skill routing table

| Task type | Skills to load (max 3) |
|---|---|
| New component | `de-component` (+ `de-motion` if it animates, + `de-a11y` if it is interactive) |
| Polish / "feels off" pass | `de-feel` |
| Review / pre-ship check | `de-critique` (+ `de-a11y` when scope includes forms, dialogs, or keyboard work) |
| Full page or landing page | `de-site` + `de-taste` |
| Motion work / janky animation / "what could animate" | `de-motion` |
| Type or spacing system work | `de-type-space` |
| Creative direction / "make it beautiful" | `de-taste` |
| Entry point (`/de-start`) | adaptive flow first, then `de-taste` (direction) or `de-site` (site work) per interview answer |

**Cap: 3 skills per task.** Prefer 1; a task that seems to need a 4th skill is two tasks — split it.

## 3. Routing procedure

1. Run `detect.sh` on the target project; record the four axes.
2. Classify the task with the table above; pick the primary skill first, then up to 2 compositions.
3. Read `project-profile.md` in the target project (if it exists) — tone, motion budget, density, and
   a11y level override harness defaults.
4. Conflicting personal preference found? It lives in `decisions.md` — the log wins over the default.
5. Log any routing deviation the user corrects via the `decisions.md` entry format.
