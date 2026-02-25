# RooCode Rule: Always Follow AGENTS.md Guidelines

## Rule ID
agents-guidelines-compliance

## Description
This rule ensures that all AI agents (e.g., Roo, Claude, Gemini) working on the UChat Messenger project strictly adhere to the guidelines outlined in `AGENTS.md`. This file provides essential rules for development environment setup, code structure, architecture, build processes, testing, linting, and best practices to maintain consistency, code quality, and alignment with project standards.

## Enforcement
- **Trigger**: Before any code-related action (e.g., writing, editing, refactoring, or suggesting changes), agents must:
  1. Review the relevant sections of `AGENTS.md` (e.g., FVM usage for commands, Clean Architecture for structure).
  2. Reference the guidelines in `<thinking>` tags to inform decisions.
  3. Explicitly state how the guidelines from `AGENTS.md` are applied in the proposed changes.
- **Scope**: Applies to all modes (code, architect, debug, etc.) and all project interactions.
- **Inclusion**: Always active; supersedes conflicting instructions unless explicitly overridden by the user.

## Rationale
- Ensures version consistency (e.g., using FVM), proper architecture (Clean Architecture layers), and quality (100% test coverage, linting).
- Prevents common pitfalls like mixing layers, using wrong commands, or ignoring dependency overrides.
- Aligns with the project's Flutter-based, Thai-localized messenger focus, incorporating GetX, Isar, and custom utilities.

## Examples
- **When Running Commands**: Always use `fvm flutter pub get` instead of `flutter pub get`, as per FVM section.
- **When Adding Features**: Start in `domain/` layer, then `data/`, then `presentation/`, avoiding UI logic in business rules (Clean Architecture section).
- **When Testing**: Mirror source paths in `test/`, use Mocktail with Given-When-Then (Testing section).
- **Violation Example**: Suggesting direct `flutter run` without FVM, which could lead to version mismatches.

## Integration
- `AGENTS.md` is located at the project root and should be referenced via `#AGENTS.md` in chats.
- Combine with other rules (e.g., Kiro steering) for comprehensive compliance.
- If `AGENTS.md` is updated, re-review for ongoing adherence.
- Link: See `AGENTS.md` for full details on setup, structure, and troubleshooting.

## Last Updated
2025-09-23