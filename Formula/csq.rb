class Csq < Formula
  desc "Multi-account rotation and quota management for Claude Code"
  homepage "https://github.com/terrene-foundation/csq"
  version "2.21.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-aarch64"
      sha256 "10b80ac4b4c38551faa514b06b649d16e83742ca694245ec56ab53a74b08e5eb"
    else
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-x86_64"
      sha256 "e433004b718992a1185c36cf36da7710955c0b2c23be8d236672259e95315a12"
    end
  end

  on_linux do
    url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-linux-x86_64"
    sha256 "411a64a2ec9a6e14af6eef0d0e9a0f64719a74e0d06f9564e7fca060a86e988a"
  end

  def install
    # Releases ship a single bare per-arch binary (csq-macos-aarch64,
    # csq-macos-x86_64, csq-linux-x86_64). Install whichever was downloaded
    # under the canonical name `csq`.
    bin.install Dir["csq*"].first => "csq"
    # Homebrew's curl download does not set com.apple.quarantine, but strip it
    # defensively so a manually-fetched binary still launches without a prompt.
    quiet_system "/usr/bin/xattr", "-d", "com.apple.quarantine", bin/"csq" if OS.mac?
  end

  test do
    assert_match "csq #{version}", shell_output("#{bin}/csq --version")
  end
end
