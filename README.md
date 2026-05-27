# homebrew-csq

Homebrew tap for [**csq**](https://github.com/terrene-foundation/csq) — multi-account rotation and quota management for Claude Code.

## Install

```sh
brew tap terrene-foundation/csq
brew install csq
```

## Upgrade

```sh
brew upgrade csq
```

The formula is bumped automatically by csq's release workflow on every stable release, so `brew upgrade` always tracks the latest published version.

## What gets installed

The `csq` CLI binary for your platform:

| Platform              | Artifact            |
| --------------------- | ------------------- |
| macOS (Apple Silicon) | `csq-macos-aarch64` |
| macOS (Intel)         | `csq-macos-x86_64`  |
| Linux (x86_64)        | `csq-linux-x86_64`  |

Binaries are Ed25519-signed by the Terrene Foundation release key; checksums are published in `SHA256SUMS` on each [release](https://github.com/terrene-foundation/csq/releases).

> The desktop app (`.app` / `.dmg`) is **not** distributed through this tap — download it from the [releases page](https://github.com/terrene-foundation/csq/releases).

## License

The formula in this repository is Apache-2.0, matching csq itself.
