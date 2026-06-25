# claude-plugins

A Claude Code plugin marketplace by @openaddr.

## Plugins

| Plugin | Description |
|--------|-------------|
| [`grsai`](plugins/grsai/) | Generate images via the Grsai `gpt-image-2` API (text-to-image, image-to-image). Bundled Windows CLI. |

## Install

```
/plugin marketplace add openaddr/claude-plugin
# (use the owner/repo shorthand or a .git URL — a bare https:// URL only fetches
#  marketplace.json and relative plugin paths like ./plugins/grsai won't resolve)
/plugin install grsai@openaddr-plugins
```

Each plugin may need first-run setup — see the plugin's own `README.md` / `SKILL.md`.

## Add another plugin

1. Put the plugin under `plugins/<name>/` (with its own `.claude-plugin/plugin.json`).
2. Add an entry to `.claude-plugin/marketplace.json`'s `plugins` array.

This repo is a **distribution catalog** — plugin artifacts are built in their source
repos and published in (e.g. grsai is published via `cargo publish-plugin` from its repo).
