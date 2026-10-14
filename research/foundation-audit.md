# Foundation Harness Audit — https://github.com/itsaibarr/harness

Audited 2026-10-14 from clone at `/var/folders/kv/m_d0phdx6mb8450f9qsj7j180000gn/T/opencode/de-sources/itsaibarr-harness` (@explorer deep read, reconciled).

- SHA: `94a89edf8a21f25ba6e57e067367b652b89cdbfd` (master, clean; tip = PR #2 feat/route-task)
- License: **MISSING** — no LICENSE/COPYING/NOTICE in tree or history (`git log --all --diff-filter=A` 0 hits); `gh repo view` licenseInfo null. Two vendored skills declare own `license: MIT` frontmatter (`i-have-adhd`, `ponytail`) but repo as a whole = all-rights-reserved. **Must choose a license before publish (Phase 6).**
- Description: "Evidence-based agent harness for solo dev work: core skills, task router, web, automation, and research modules."

## Architecture

Two-layer doctrine (`agent/README.md`): `core/` always-on and tiny; `modules/` copied into a project only when applicable. Bootstrap idempotent (never overwrites).

```
README.md  bootstrap.sh  .gitignore
agent/
├── README.md
├── core/
│   ├── ORIENTATION-TEMPLATE.md (= templates/CLAUDE.md, identical)
│   ├── task-router.md (routing kernel D1–D4 × 11 categories)
│   ├── gen-doc-index.sh (.context/DOC-INDEX.md generator)
│   ├── commands/ (verify-ui.md, wrap-session.md — NO frontmatter, full procedures)
│   └── framework/ ("masters" — copy back to restore)
│       ├── commands/ (spec.md plan.md build.md route.md — description frontmatter, one-line skill-invocation stubs)
│       ├── references/ (definition-of-done.md, testing-patterns.md)
│       └── skills/ (12: api-and-interface-design, incremental-implementation, interview-me,
│           observability-and-instrumentation, planning-and-task-breakdown, ponytail,
│           ponytail-review, ponytail-audit, route-task, spec-driven-development,
│           test-driven-development, i-have-adhd)
├── modules/
│   ├── web-development/ (verify-ui.mjs, visual-diff.sh, mcp-template.json, README — the sight loop)
│   ├── automation/ (verify-send.mjs, imap-batch-verify.mjs, monitor.sh, permissions-template.json)
│   ├── research/ (evidence-card.md, source-register.md, README — templates only)
│   ├── orchestration/route-task/ (Python stdlib-only CLI + 23 tests + install.sh + example TOML)
│   └── pi-stack/ (README, permissions.ts)
└── templates/ (CLAUDE.md, settings.json, mcp-template.json)
docs/agent-harness/ (15 docs: decision-log, tool-evaluation, skill-inventory, routing-validation, …)
```

- Loading model is machine-level: masters in `agent/core/framework/` → installed copies `~/.claude/{skills,commands}` (read by Claude Code and OpenCode). Restore = copy masters back. `route-task/install.sh` is the installer pattern (symlink binary, cp skill+command, never overwrite user config).
- Routing: `task-router.md` depth ladder D1 (quick) / D2 (standard) / D3 (deep+approval) / D4 (high-risk confirm) + 11-row category matrix + aliases + 9 worked examples. UI work = category #2 (D2: spec-lite → plan → build → sight loop).
- Commands: `<name>.md` filename = slash name. Framework commands invoke Skill tool with exact name + `$ARGUMENTS`.
- Skills: dir per skill, `SKILL.md` with YAML `name`+`description` (trigger-rich, "Use when…/Not for…"); body = imperative numbered procedure. Cross-refs via relative path to shared `references/`.
- Scripts: bash `set -euo pipefail`, idempotent; node `.mjs` gates use non-zero exit (verify-ui exits 1 on console/network errors). Python: stdlib-only `unittest`.
- No in-repo subagent/persona defs; no hooks in-repo except `i-have-adhd` optional OpenCode hook + Claude SessionStart extension.

## Conventions to build on (don't fight)

1. New skill → `agent/core/framework/skills/<name>/SKILL.md` (+ optional `references/`).
2. New command → `agent/core/framework/commands/<name>.md` (description frontmatter → invoke skill) or `agent/core/commands/` (full procedure).
3. Router registration → row in `task-router.md` matrix + row in `docs/agent-harness/skill-inventory.md` Tier A/B/C.
4. New module → `agent/modules/<name>/` + README (activation conditions) + `bootstrap.sh` flag.
5. Config templates → `agent/templates/` (every-project) else module-local.
6. Evidence trail → `docs/agent-harness/decision-log.md` row for adoptions/rejections.
7. Gate scripts → node/bash, non-zero = fail, slots into route-task `gate:` lists.

## Coverage vs gaps (design-engineering lens)

Covered: task router incl. UI row; web sight loop (Playwright 1440×900 + 390×844 PNGs, console/network capture, odiff); research evidence-card/source-register templates; automation Mailpit/IMAP gates; route-task tiered pipeline; spec/plan/build/TDD/interview methodology skills.

Gaps: no owned design skill (design delegated to external Tier-B `impeccable/ui-ux-pro-max/shadcn`, Tier-C gstack design excluded); no token/type/space system artifacts; `accessibility-audit` referenced but absent in-repo; no design→code handoff format; no design-system router category; verify loop is screenshot-only (no contrast/hit-target/spacing metrics); dangling ref `observability-checklist.md`; license gap blocks redistribution.

## Implication for our build

Extend, don't rewrite: add design-engineering skills under `agent/core/framework/skills/de-*`, commands `de-*`, a new `agent/modules/design-engineering/` reference library + quality gates, router row + inventory entries, and a `bootstrap.sh --design` flag. Target agents: Claude Code + OpenCode/Cursor via `~/.claude/skills` (+ AGENTS.md pointer for Codex) per user config.
