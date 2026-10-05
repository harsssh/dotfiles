# Improve Mode — Interactive Single-Target Improvement

## Purpose

Take ONE identifier and walk it through the naming process, one transition at a time, *proposing* each move. Pause at phase boundaries so the user can decide whether to invest in structural changes.

**Advisory:** you propose renames and suggest the commit message for each; you do not edit files or run git. The user applies them.

## Workflow

1. **Confirm the target.** Restate which identifier you're improving. If the user named multiple, ask which one to start with.
2. **Diagnose current step.** Use the diagnosis table in `reference.md`. State the step + one-line evidence.
3. **Read the user's depth signal** to decide how far to propose walking. Use the "Depth Signals — How Far to Walk" table in `reference.md`.
4. **Walk Phase 1 continuously.** Propose transitions through Honest and Complete WITHOUT pausing for each micro-step. Phase 1 is pure renaming (no structural change, behavior-preserving). Show each transition with the commit message the user would use.
5. **Pause before Phase 2.** State that the next step requires structural refactoring and ask:
   > The next step needs structural refactoring (splitting methods/classes). Shall I extract `X`, `Y`, `Z` and continue?
6. **Pause before Phase 3.** State that you need to read call sites / consider domain language and ask:
   > Next I would read the call sites to extract intent. This needs context from the whole codebase. Shall I continue?
7. **Stop on user signal.** If user says "stop here" / "OK" / "that's enough" → stop and confirm final state.

## Pause Protocol

**Inside Phase 1: don't pause.** Per-step pauses (Missing → applesauce → Honest → Honest and Complete) feel like noise. Walk through them in one response, showing each commit point.

**At Phase boundaries: always pause.** The user must explicitly authorize structural changes (Phase 2) and design-level changes (Phase 3). Do not infer permission from a generic "improve it" prompt.

**Override:** If the user pre-authorized depth in their initial prompt ("refactor", "do all of it", "go up to Phase 2"), you may cross the boundary they authorized without pausing. Pause only at the next un-authorized boundary.

## Output Shape

Each transition shows:
- The before / after of the name
- A one-line `commit:` message
- The new current step

Example:

```
1. Diagnosis: `process(String s)` → currently Missing (generic verb + 1-letter param)
2. Missing → Nonsense:  process → applesauce
   commit: rename process to applesauce
3. Nonsense → Honest:   applesauce → probably_parseAndStoreFlight_AndStuff
   commit: rename applesauce to honest name
4. Honest → Honest and Complete:
   probably_parseAndStoreFlight_AndStuff → parseXmlAndStoreFlightToDatabase
   commit: complete the name with all responsibilities

Reached: Honest and Complete (end of Phase 1)

---
Next is Phase 2 (Does the Right Thing).
The name shows this method has two responsibilities: parseXml and storeFlightToDatabase.
Shall I split it into two methods with a structural refactoring?
```

## Anti-Patterns — Do NOT Do These

| Temptation | Why it's wrong |
|------------|----------------|
| Cross Phase 2 boundary without asking | Structural change touches behavior. Always ask. |
| Pause at every micro-step inside Phase 1 | Phase 1 is safe. Excessive pausing kills flow. |
| Audit other identifiers "while I'm here" | Improve-mode is single-target. For broad scans, use audit-mode. |
| Skip applesauce for misleading names like `-Manager` | The applesauce step forces letting go of false comfort. Don't skip it. |
| Use applesauce for a one-letter variable like `d` | Applesauce is for misleading names and extracted chunks. A nameless `d` can go directly to Honest. |
| Run all 7 steps when user said "I'm in a hurry" | Honor the depth signal. Stop at Honest. |
| Suggest a Value Object when only Phase 1 was authorized | Note the opportunity, don't do the work. |
| Compress the `applesauce` step into commentary (esp. on handoff from audit) | Show the literal `→ applesauce` rename with its own commit message, even when the diagnosis was already done in audit. The per-step commit visibility is the point. |

## When to Defer to Audit Mode

If the user starts asking about multiple identifiers ("`r`, `cnt`, and `s` too") or about general code quality ("I want to review this whole class"), suggest switching to audit-mode for the broader survey. Improve-mode loses focus when the target multiplies.
