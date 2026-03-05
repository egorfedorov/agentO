class Agento < Formula
  desc "ASCII desktop companion for Claude CLI & Codex CLI"
  homepage "https://github.com/egorfedorov/agentO"
  url "https://github.com/egorfedorov/agentO/archive/refs/tags/v5.3.0.tar.gz"
  sha256 ""
  license "MIT"

  depends_on xcode: ["14.0", :build]
  depends_on :macos

  def install
    system "swiftc", "-O", "-o", "agento", "AgentO.swift",
           "-framework", "AppKit", "-framework", "WebKit"
    bin.install "agento"

    # Create .app wrapper
    app_dir = prefix/"AgentO.app/Contents"
    (app_dir/"MacOS").mkpath
    (app_dir/"Resources").mkpath
    cp bin/"agento", app_dir/"MacOS/AgentO"
    cp "assets/AppIcon.icns", app_dir/"Resources/" if File.exist?("assets/AppIcon.icns")

    (app_dir/"Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>AgentO</string>
        <key>CFBundleIdentifier</key>
        <string>com.agento.app</string>
        <key>CFBundleName</key>
        <string>Agent-O</string>
        <key>CFBundleVersion</key>
        <string>#{version}</string>
        <key>CFBundleIconFile</key>
        <string>AppIcon</string>
        <key>LSMinimumSystemVersion</key>
        <string>12.0</string>
        <key>NSHighResolutionCapable</key>
        <true/>
      </dict>
      </plist>
    PLIST
  end

  def caveats
    <<~EOS
      To run Agent-O:
        agento

      Or open the .app bundle:
        open #{prefix}/AgentO.app

      Global hotkey: Cmd+Shift+O to show/hide
    EOS
  end

  test do
    assert_predicate bin/"agento", :exist?
  end
end
