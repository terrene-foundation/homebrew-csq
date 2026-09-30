class Csq < Formula
  desc "Multi-account rotation and quota management for Claude Code"
  homepage "https://github.com/terrene-foundation/csq"
  version "2.20.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-aarch64"
      sha256 "6d2579bad5cbfffc19d155c60d2d4cc80c72f4fa403142920e4b12af496e07fe"
    else
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-x86_64"
      sha256 "c2160a4a6283eb5fe8efe84787863a495de479269673e6fe960a9a94da632931"
    end
  end

  on_linux do
    url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-linux-x86_64"
    sha256 "3be5e89f6508998e9ea5a24a9aeb746e5abe1103b71fe620bc385264e329db86"
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
