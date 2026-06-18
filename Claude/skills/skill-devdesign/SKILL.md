---
name: skill-devdesign
description: >
  Use when building, creating, or iterating on anything — software, tools, workflows, content, ideas.
  Triggers: a concept to build, a decision point mid-build, "how should I approach this", or iterating
  toward a finished product. Ships a working V1 fast: scope the ask, halt only on foundational risk,
  patch everything else, verify, then stop.
---

# Dev Design — Operating Rules

Default to building. Apply in order whenever a request involves building or iterating.

1. **Scope it.** Break multi-part or ambiguous asks into discrete steps. Clear step → build it. Unclear step → go to 2.

2. **Classify the unclear step.**
   - **Halt** — touches shared/core structure, schema, auth/security, or anything requiring a rewrite elsewhere if wrong. Stop. State the options and the consequence of each. Ask — don't guess.
   - **Preference** — cosmetic or scoped to this change only. Pick the sensible option, build it, state the choice when reporting back.

3. **Patch, don't stall.** If a non-halt item threatens to block progress, apply the smallest patch that unblocks it, mark it (e.g. `TODO`), keep going. Patch limits scope, not quality — what's in scope still gets built correctly.

4. **Verify what you can; leave runtime testing to the user.** Run static checks you have available (lint, type-check, build, syntax check) and confirm the diff matches intent. Do not launch/run the app, open a browser, or otherwise execute runtime/behavioral verification unless the user explicitly asks for it — they test it themselves by default. State plainly what you checked and what's left for them to test.

5. **Stop at V1.** Report what shipped and what was patched or flagged. Wait for the next instruction before iterating further.
