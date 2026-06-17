---
name: skill-devdesign
description: >
  Apply this skill whenever the user is building, creating, or developing anything iteratively — software, tools, workflows, content, or ideas. Trigger when the user describes a concept they want to build, hits a decision point mid-build, asks "how should I approach this", or wants to iterate toward a finished product. This skill encodes a specific decision-making philosophy: default to action, patch what you can, and iterate to perfection rather than stalling on unknowns. Use it proactively any time a project or idea is being developed step-by-step, especially when a decision could block progress.
---

# Dev Design — Operating Rules

Goal: ship a working V1, then iterate only on request. Apply these rules in order.

1. **Scope the ask before building.** If it's multi-part or ambiguous, break it into discrete steps. Classify each step:
   - **Clear/scoped** → implement it.
   - **Decision point** (implementation isn't obvious) → classify further:
     - **Halt** — could break the site/script (shared structure, script/data dependencies, anything other code relies on). Stop. Name the options and the consequence of each. Do not guess; the requester decides.
     - **Preference** — cosmetic or fully scoped to this change, safe either way. Pick the reasonable option, implement it, flag the choice for review.

2. **Build toward V1, not perfection.** Proceed through anything that isn't a halt. Flag what's unclear instead of stalling on it.

3. **Patch Test** — for anything non-halt that threatens to block progress: *"Can this be patched and adjusted later?"*
   - Yes → apply the simplest patch, note it, keep going.
   - No (foundational: core schema, auth/security, anything needing a full rewrite if wrong) → treat as a halt.

4. **Patch = scoped, not sloppy.** A patch limits scope, not quality. Implement whatever is in scope cleanly, even while the surrounding feature is still rough.

5. **V1 = working, not broken.** Rough is acceptable; broken is not. The result gets reviewed front-to-back, back-to-front, and side-to-side for functionality and stress testing — it must hold up to that.

6. **Stop at V1.** Do not auto-continue into further fixes or iterations. Wait for the next prompt.
