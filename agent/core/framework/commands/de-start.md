---
description: Entry point — profile interview, stack detect, and skill routing for design work.
---

Invoke the Skill tool with skill="de-taste" (exact name) for direction work, or skill="de-site" (exact name) when the interview answer is site/landing-page work — decide from the answer, one primary skill.

Before invoking: run `bash agent/modules/design-engineering/adaptive/detect.sh <target-project>` (read-only), fill/update `project-profile.md` and `decisions.md` in the target project via a one-question-at-a-time interview (foundation `interview-me` pattern), then apply `adaptive/routing.md` (max 3 skills/task).

Goal or scope: `$ARGUMENTS`. If empty, start from what the user just described.
