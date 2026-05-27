class Csq < Formula
  desc "Multi-account rotation and quota management for Claude Code"
  homepage "https://github.com/terrene-foundation/csq"
  version "2.14.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-aarch64"
      sha256 "4e2359ad3c64534c6f0fcd8a0442327aca0d6d9c847191434ceddef29f81f862"
    else
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-x86_64"
      sha256 "512529307d2412c058180f24214cf2d07d1ac178fed9fd8ffb2f234369241e96"
    end
  end

  on_linux do
    url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-linux-x86_64"
    sha256 "645b4948bb8caacb6019a377b47f2bd2ad65feb318e38c7bc7d81dc34a5eaf7c"
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
