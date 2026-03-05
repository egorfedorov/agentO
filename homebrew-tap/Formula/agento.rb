class Agento < Formula
  desc "ASCII desktop companion for Claude CLI & Codex CLI"
  homepage "https://github.com/egorfedorov/agentO"
  url "https://github.com/egorfedorov/agentO.git",
      tag: "v6.4.0",
      revision: "39ac8b11e6042b7ee1d4f2590aa84e13f029b2f7"
  license "MIT"

  depends_on xcode: ["14.0", :build]
  depends_on :macos

  def install
    system "swiftc", "-O", "-o", "agento", "AgentO.swift",
           "-framework", "AppKit", "-framework", "Foundation", "-framework", "Carbon"
    bin.install "agento"

    app_dir = prefix/"AgentO.app/Contents"
    (app_dir/"MacOS").mkpath
    (app_dir/"Resources").mkpath
    cp bin/"agento", app_dir/"MacOS/agento"
    cp "assets/AppIcon.icns", app_dir/"Resources/AppIcon.icns" if File.exist?("assets/AppIcon.icns")

    (app_dir/"Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>agento</string>
        <key>CFBundleIdentifier</key>
        <string>com.agento.app</string>
        <key>CFBundleName</key>
        <string>Agent-O</string>
        <key>CFBundleVersion</key>
        <string>#{version}</string>
        <key>CFBundleShortVersionString</key>
        <string>#{version}</string>
        <key>LSUIElement</key>
        <true/>
        <key>CFBundleIconFile</key>
        <string>AppIcon</string>
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

      For AI prompts, install at least one provider CLI:
        claude / codex / ollama

      Global hotkey: Cmd+Shift+O to show/hide
    EOS
  end

  test do
    assert_predicate bin/"agento", :exist?
  end
end
