class Csq < Formula
  desc "Multi-account rotation and quota management for Claude Code"
  homepage "https://github.com/terrene-foundation/csq"
  version "2.20.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-aarch64"
      sha256 "25a8edba24e13cedff339f10ed0782340265c5cd8b9ae98121c0e0b79a995dc9"
    else
      url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-macos-x86_64"
      sha256 "53d46aef5ada5f7a966f92e25fb52809ddf683f5c4d92936b3df6573e14dde82"
    end
  end

  on_linux do
    url "https://github.com/terrene-foundation/csq/releases/download/v#{version}/csq-linux-x86_64"
    sha256 "3804a85adb7ba30685a1b63334030d2ad788e245fa51d02f8839f02542f02076"
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
