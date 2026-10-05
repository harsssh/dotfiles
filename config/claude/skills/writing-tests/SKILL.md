---
name: writing-tests
description: Guidelines for writing tests that verify behavior through public interfaces. Use whenever writing, adding, or updating tests, including enumerating test cases, deciding where tests go and what to mock, and naming tests.
---

# Writing Tests

This skill is the reference for writing tests worth keeping: what a good test is, where tests go, which cases to cover, and the anti-patterns.

When exploring the codebase, read `GLOSSARY.md` (if it exists) so test names and interface vocabulary match the project's domain language, and respect ADRs in the area you're touching.

## What a good test is

Tests verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't. A good test reads like a specification: "user can checkout with valid cart" tells you exactly what capability exists, and it survives refactors because it doesn't care about internal structure.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Seams: where tests go

A **seam** is the public boundary you test at: the interface where you observe behavior without reaching inside. Tests live at seams, never against internals.

**Test only at pre-agreed seams.** Before writing any test, write down the seams under test and the test cases (see below), and confirm them with the user. No test is written at an unconfirmed seam. You can't test everything, so agreeing the seams up front is how testing effort lands on the critical paths and complex logic instead of every edge case.

Ask: "What's the public interface, and which seams should we test?"

When the shape of that interface is itself in question (how deep the module is, where the seam belongs, what the interface should expose), call the Skill tool with "codebase-design" for the vocabulary. It is the shared source of the module, interface, depth, seam, adapter, leverage and locality terms, and it is a reference to consult, not a session to run.

## Test cases

Derive cases from the specification, not from the implementation. When the spec, issues, existing tests, and callers leave a point unclear, ask the user instead of guessing.

Cover:

- **Input classes**: split inputs wherever the expected result changes
- **Boundaries**: the edge of each class and the values on either side
- **Errors and failures**: invalid input, failing dependencies, return values that signal failure
- **State-dependent behavior**: if the module has state, the same operation in each state

Don't list:

- What the type system already guarantees
- What another test already verifies

Write each case as "input condition → expected result". That sentence becomes the test name, in English, including RSpec `describe` / `context` / `it` strings.

Write exactly the confirmed cases: no extra tests, none missing. If you find a missing case while writing, update the list and show it to the user again.

## Anti-patterns

- **Implementation-coupled**: mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks when you refactor but behavior hasn't changed.
- **Tautological**: the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`, a snapshot derived by hand the same way, a constant asserted equal to itself), so it passes by construction and can never disagree with the code. Expected values must come from an independent source of truth: a known-good literal, a worked example, the spec.

Referencing a domain constant or existing data as test input or expected value is not tautological, as long as the test doesn't recompute the result from it.

## When a test fails

Don't change expected values or skip tests just to make them pass. If you believe the expected value is wrong, explain why and ask the user before changing it.
