# grsai plugin

A Claude Code plugin that bundles the `grsai` CLI (Windows) and exposes a `grsai` skill
for generating images via the Grsai `gpt-image-2` API.

> The `plugin/` folder is **generated**. The source of truth for the docs lives in
> `build-templates/`; the bundled exe is the latest `cargo build --release` output.
> Regenerate everything with one command (from the repo root):
>
> ```
> cargo plugin
> ```

## What's inside

- `skills/grsai/SKILL.md` — the skill (how an AI uses it)
- `skills/grsai/bin/grsai.exe` — the bundled Windows binary (~3.5 MB, self-contained)
- `scripts/bundle.sh` — refresh only the exe (no cargo task needed)

## Requirements

- **Windows** (the bundled binary is Windows-only). On macOS/Linux, build from source with
  `cargo build --release`.

## Install

This repo is also a plugin marketplace. From the Claude Code prompt:

```
/plugin marketplace add <path-or-url-to-this-repo>
/plugin install grsai@grsai
```

Or add the local `plugin/` directory directly via `/plugin`.

## First-run configuration

Each machine must configure its Grsai API key once:

```
skills/grsai/bin/grsai.exe config
```

Stored at `%APPDATA%\grsai\config.json`; never bundled — the plugin is safe to distribute.

## Use

See `skills/grsai/SKILL.md`. Quick example:

```
grsai.exe prompt="一只柴犬在草地上奔跑" outputPath="dog.png"
```

## Build / update

- **Regenerate the whole plugin** (docs + fresh exe): `cargo plugin`
- **Refresh only the exe**: `./plugin/scripts/bundle.sh`
- Edit doc content in `build-templates/`, then run `cargo plugin`. Bump `version` in
  `build-templates/plugin.json` (and `Cargo.toml`) together when versioning.
