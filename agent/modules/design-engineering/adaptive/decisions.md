# Decision Log — design preferences and corrections

**Provenance: original synthesis** (foundation decision-log norm adapted to per-project design preferences).
Lives in the **target project** alongside `project-profile.md`; created by `/de-start`.

## Rules

1. **Single occurrence stays scoped.** A one-off correction applies to that task/file only. Log the entry;
   do not touch `project-profile.md`.
2. **Promote to profile on the 2nd recurrence OR on an explicit "always".** The same correction seen a
   second time, or the user saying "always"/"never again" verbatim, is the only path that edits the profile.
3. **Profile edits cite entries.** When promoting, add the entry ids being promoted in the Profile-change
   note so the trail is one hop.
4. **Log wins over defaults.** An entry here overrides harness defaults (`routing.md`, `gates/*`,
   preset files) for this project.
5. **Waivers live here too.** Any `gates/checklist.md` item passed over needs an entry: item, reason,
   expiry/review date.
6. **Append-only.** Supersede with a new row (`supersedes <id>`) instead of rewriting old rows.

## Entry format

```markdown
| id | Date | Scope | Correction / preference | Recurrence | Profile updated | Status |
|----|------|-------|--------------------------|------------|-----------------|--------|
| D-001 | 2026-10-14 | src/components/Button.tsx | Use 0.96 press scale, not 0.97 | 1st | no (scoped) | active |
| D-002 | 2026-10-14 | project | Prefer 40px hit areas in this dense dashboard | 2nd | yes (Density) | active |
```

- **id** — `D-NNN`, sequential.
- **Scope** — file/route/task (single instance) or `project` (profile-level).
- **Recurrence** — `1st`, `2nd`, or `always` (user said the word).
- **Profile updated** — `no (scoped)` or `yes (<section name>)`.
- **Status** — `active` | `superseded <id>`.

## Log

| id | Date | Scope | Correction / preference | Recurrence | Profile updated | Status |
|----|------|-------|--------------------------|------------|-----------------|--------|
| | | | | | | |
