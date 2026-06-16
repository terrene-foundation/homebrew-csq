class Csq < Formula
  desc "Multi-account rotation and quota management for Claude Code"
  homepage "https://github.com/terrene-foundation/csq"
  version "2.16.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-aarch64"
      sha256 "acf298466d8e5c61a88f9e247154c40a566e944e819ac97e619082857995488a"
    else
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-x86_64"
      sha256 "6cea4666ce59b7eb74597773e4e8f9581ac8fec1877d4eb4374a58bcef754b17"
    end
  end

  on_linux do
    url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-linux-x86_64"
    sha256 "6883ca11d4830c91d3a3fee219dffe19491c0a1b558e4a0ba394c2fcb7c64caa"
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
