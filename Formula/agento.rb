class Agento < Formula
  desc "ASCII desktop companion for Claude CLI & Codex CLI — a Tamagotchi for developers"
  homepage "https://github.com/egorfedorov/agentO"
  url "https://github.com/egorfedorov/agentO/archive/refs/tags/v2.0.0.tar.gz"
  sha256 ""
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swiftc", "AgentO.swift", "-o", "agento",
           "-framework", "AppKit",
           "-framework", "Foundation",
           "-framework", "Carbon"
    bin.install "agento"
  end

  def caveats
    <<~EOS
      Agent-O is a native macOS floating panel.

      To launch:
        agento

      Requirements:
        - Claude CLI or Codex CLI must be installed
        - Grant Accessibility permissions if prompted (for global hotkey)

      Global hotkey: Cmd+Shift+O
    EOS
  end

  test do
    assert_predicate bin/"agento", :exist?
  end
end
