---
name: grsai
description: Generate or edit images via the Grsai gpt-image-2 API by invoking a bundled CLI. Use when the user wants to create an image from a text prompt, or generate/extend from one or more reference images (image-to-image). Handles API key configuration, reference-image base64 encoding, the API call, and downloading the result to a file path. Bundled binary is Windows-only; on macOS/Linux build from source.
---

# grsai — image generation

Generate images with the Grsai `gpt-image-2` API by running the bundled `grsai.exe`.
The binary handles everything — API key config, reference-image base64 encoding, the API
call, and downloading the result to a file. You only construct the command line.

## Platform

The bundled binary (`bin/grsai.exe`) is **Windows-only**.
On macOS/Linux, build from source (see [Non-Windows](#non-windows)).

## Locate the binary

The binary sits next to this file at `bin/grsai.exe`, i.e.
`<this skill's directory>/bin/grsai.exe`. Resolve that directory, then invoke the binary.

Plugin skills are usually installed under `~/.claude/plugins/.../skills/grsai/`.
If the exact path is unknown:

1. Find the `grsai.exe` shipped with the `grsai` plugin/skill — search under `~/.claude/`
   and the project's `.claude/`.
2. Fallback — if working inside the grsai source repo, build and use
   `target/release/grsai.exe` (`cargo build --release`).

Invoke as: `<resolved-path>/grsai.exe <command> [key=value ...]`.

## First-run setup (API key)

grsai needs an API key + model, stored per machine at `%APPDATA%\grsai\config.json`.
On a new machine configure once before generating:

```
<resolved-path>/grsai.exe config
```

It prompts for the API key and the model (default `gpt-image-2`).

If a generate call fails with `apikey error`, the key is missing or wrong — re-run `config`.

## Commands

### Generate

```
grsai.exe prompt="<description>" [images=["<path>", ...]] [aspectRatio="<WxH>"] [outputPath="<path>"]
```

| Argument | Required | Default | Notes |
|---|---|---|---|
| `prompt` | yes | — | What to generate |
| `images` | no | `[]` | Local reference image paths (image-to-image); base64-encoded automatically |
| `aspectRatio` | no | `1024x1024` | Size hint (the API may return a nearby size) |
| `outputPath` | no | `%TEMP%\grsai\<file>` | Save location; relative to the current working dir. If it points at a directory, the file is saved inside it |

On success the image is downloaded, saved, and its absolute path is printed.

### Other

```
grsai.exe config   # (re)configure API key + model
grsai.exe help     # show usage
```

## Examples

Text-to-image:

```
grsai.exe prompt="一只柴犬在草地上奔跑,阳光明媚" outputPath="dog.png"
```

Image-to-image (generate from a reference):

```
grsai.exe prompt="把这只柴犬放到雪地里" images=["C:\photos\shiba.png"] outputPath="shiba-snow.png"
```

## Non-Windows

There is no bundled binary for macOS/Linux. Build from source, then use the result the
same way:

```
cargo build --release      # -> target/release/grsai (or grsai.exe on Windows)
```

## Notes

- The API key is never embedded in the binary or the plugin — only in each machine's local
  config. The plugin is safe to distribute.
- Running with no arguments on an unconfigured machine starts first-run setup.
