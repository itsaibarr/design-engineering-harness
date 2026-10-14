# Annnimate — commercial GSAP library guide

**Provenance: S9 — https://annnimate.com/ (© Good Fella Studio GmbH), read 2026-10-14 via webfetch ×16.**
Reference-use: concepts, APIs, and workflow only — **no component source is reproduced in this harness.**
Quotes ≤15 words. Conflict resolutions vs our defaults: `research/synthesis.md` §4 (S9 addendum) and
`research/ledger.md` Source 9.

## 1. What it is

A commercial component library built on GSAP: 118 components for React, Vue, and plain HTML, delivered by
copy-paste (no npm package — the component code lives in your repo, alongside its CSS). Paid subscription,
with a free 16-component Starter Pack and one free component released weekly. GSAP itself stays free
including every plugin; Annnimate sells the curated components, docs, and MCP access.

## 2. When to route to it

Reach for this stack only when the work is staged or linked: sequenced timelines, scroll-linked scenes,
split-text reveals, marquees/seamless loops, parallax, page transitions. Simple state changes (hover,
toggles, dropdowns) stay on CSS transitions or springs — see `adaptive/routing.md` §1. Every
`de-motion` gate (frequency, purpose, ≤300ms UI) still applies; GSAP changes the tool, not the budget.

## 3. Install loop

1. `npm i gsap` (add `@gsap/react` in React projects); GSAP ships TS types; Next App Router and Nuxt ready,
   Astro/SvelteKit via the vanilla format.
2. Find the component (site or MCP, §5), copy it **and** its CSS side-by-side into the project.
3. React files get `"use client"`; ScrollTrigger/SplitText register inside that client component.
4. Tune via the grammar below; verify reduced-motion + the load-failure fallback (§8).

## 4. Tuning grammar

| Surface | Switch | Per-component tuning |
|---|---|---|
| HTML | `data-anm-{component}` on/off | `data-anm-duration`, `data-anm-ease`, `data-anm-stagger` |
| React / Vue | same switch as a prop | same names as camelCase props (`duration`, `ease`, `stagger`) |

One grammar everywhere: the attribute name after `data-anm-` is the prop name, camelCased. House UI ease is
`expo.out` ("starts an animation fast and decelerates exponentially"); the timeline demo default is 0.5s.
Our rule: adopt the ease, not the duration — UI micro-interactions still clamp at ≤300ms (ledger S9).

**Ease family (page: easing):**

| Ease | Feel | Reach for it when |
|---|---|---|
| `expo.out` | fast start, exponential deceleration | default — house ease; another ease needs a stated reason |
| `power4.out` | most aggressive out | hard, decisive stops |
| `back.out` | overshoots then settles | playful entrances with a little life |
| `sine` | gentlest motion | quiet, low-stakes transitions |
| `slow` | lingers mid, ends fast | lingering reveals |
| `steps()` | quantizes | mechanical/counter-style motion |
| `CustomEase` (SVG path or control points) | brand-specific curve | when the trio plus expo family isn't the brand |

`easeReverse` (GSAP 3.15+) plays an ease backwards — use it for exit legs instead of inventing a paired curve.

## 5. MCP workflow

```bash
claude mcp add --transport http annnimate https://annnimate.com/api/mcp
```

Browser OAuth — no API key for interactive use (CI uses the Settings→MCP API key header). Tools, in order:

1. `search_components` — cheap search over slugs/titles.
2. `get_component` — full code + install steps + gotchas + dependencies.
3. `get_concept` / `get_pattern` — concept pages and the 10 pattern recipes.

Error codes: `401` = re-authenticate, `403` = inactive subscription. Webflow and Kits are not served via MCP.

## 6. Concept index

`/learn` pages are free to cite. The 10 patterns (each ships a decision matrix): **Hover Card** (elevated
cursor-following preview), **Magnetic Button** (spring-like cursor tracking then release), **Marquee**
(seamless constant-speed loop), **Mega Menu** (staged multi-column nav reveal), **Page Transition**
(overlay between routes), **Parallax Scroll** (layered scroll offsets), **Scramble Text** (cycles random
symbols then locks), **Scroll Image Reveal** (clip-path wipe/mask/dissolve — never a plain fade),
**Sticky Cursor** (cursor-following follower element), **Text Mask Reveal** (mask wipe exposing type).

**Timeline controls** (page: timeline): `play` / `pause` / `reverse` / `restart` / `seek` / `progress` /
`time` / `timeScale` — `timeScale(2)` doubles speed, `timeScale(0.5)` halves it. Defaults run
`{ duration: 0.5 }`; the position parameter goes second-to-last among a tween's arguments; ScrollTrigger
`toggleActions` slots in order: onEnter, onLeave, onEnterBack, onLeaveBack. Seamless loops: `repeat: -1`
with the end state equal to the start state.

**Plugin index:** `matchMedia` (breakpoint-specific code + disposal), `quickTo` (high-frequency optimizer),
`Flip` (old → new state tween), `Observer` (wheel/touch/pointer unified), `InertiaPlugin` (natural stop),
`MotionPathPlugin` (SVG path travel), `Draggable`. All ship free with GSAP.

## 7. Framework contracts

**React — `useGSAP` from `@gsap/react`:** wraps `gsap.context`; reverts on unmount; fixes the StrictMode
double-run. Scope selectors with the hook's ref or one card animates all cards. Wrap handler-created tweens
in `contextSafe`. Revert with `ctx.revert()` — never `ctx.kill()`. Register ScrollTrigger/SplitText inside a
`"use client"` file; call `ScrollTrigger.refresh()` after async loads.

**Vue:** `script setup`; start tweens in `onMounted`; `onUnmounted` calls `gsap.context().revert()` manually.

**Reduced motion:** `gsap.matchMedia()` reads the OS setting; timelines collapse to nearly instant while the
end state still renders. Never delete the matchMedia block when editing.

## 8. Reduced motion + performance budget

| Budget | Rule |
|---|---|
| Frame target | 60fps (16.7ms/frame; our design budget is 8ms on 120Hz) |
| Allow (animate) | `x`, `y`, `scale`, `rotation`, `opacity`, `clip-path` |
| Deny (never animate) | `width`, `height`, `top`, `left`, `margin`, `padding` |
| Transform | `force3D: true` on animated elements |
| Frequent values | `gsap.quickTo()` for mousemove/scroll-driven values; `autoAlpha` for opacity + visibility |
| Small screens | skip WebGL / heavy canvas at render level |
| Cleanup | kill timelines, revert SplitText, kill ScrollTriggers |
| SplitText | `SplitText.create()` only — the constructor is deprecated since GSAP 3.13 |
| Fallback | content hidden until GSAP boots must reveal if the bundle fails to load (S9 addendum #6) |

## 9. Licensing guardrails (binding)

| May | Must not |
|---|---|
| Link/recommend the library freely (no attribution required) | Reproduce paid component source as standalone snippets, downloads, templates, or courses outside an End Product |
| Paste free-Starter-Pack or paid-subscription code into an End Product and modify it (copied-during-subscription code stays usable forever) | Submit components to ML training / fine-tuning |
| Quote short citations (≤15 words); `/learn` content is free and citable | Scrape or mass-copy via agents beyond normal human use |

The line, in their words: "bulk paid-source reproduction is the line". Practical rule for this harness:
**recommend + link + MCP `get_component`; never paste paid source into the repo as a reusable snippet.**
Free-pack or subscribed code goes only into an End Product, modified, at delivery time.

## 10. Sources

- **S9 — https://annnimate.com/** (commercial, © Good Fella Studio GmbH) — reference-use: facts and APIs
  restated in our own words, no component source copied. Evidence: `research/ledger.md` Source 9 (READ_FULLY,
  2026-10-14, 16 pages via webfetch); conflicts resolved in `research/synthesis.md` §4.
