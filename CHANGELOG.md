# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Simplified the plugin: dropped the `dotenv`/`direnv` setup and the separate `utils/env` module, consolidating logic into `lua/plugin/init.lua` and trimming the CI pipeline.
- Reworked the `Makefile` and added a `scripts/rename.sh` helper to make renaming the template easier and more reliable.

### Added

- **Notes example** (`lua/plugin/notes.lua`) — a self-contained example command plus matching tests and README usage, demonstrating how to build a feature on top of the template.
- Standalone test harness: `tests/bootstrap.lua` with `tests/plugin_spec.lua` running on `plenary.nvim`.

### Fixed

- Note creation now opens the newly created note in the current window instead of an unexpected split.

## [1.0.0] - 2025-05-09

### Added

- CI workflows for quality gates and tagged releases (`.github/workflows/`).
- `plugin.json` manifest and `LICENSE`.
- Utility module (`lua/utils/env.lua`), a `lua/cmd.lua` command shim, and initial unit tests.
- `dotenv`/direnv integration for local developer environment.

## [0.1.0] - 2024-03-22

### Added

- Project bootstrap: editor config, stylua/luacheck/luarc setup, `Makefile`, initial `README.md`, and the `lua/plugin/init.lua` entry point.

[Unreleased]: https://github.com/marco-souza/plugin.nvim/compare/1.0.0...HEAD
[1.0.0]: https://github.com/marco-souza/plugin.nvim/releases/tag/1.0.0
[0.1.0]: https://github.com/marco-souza/plugin.nvim/releases/tag/v0.1.0