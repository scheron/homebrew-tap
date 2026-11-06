cask "daily" do
  version "0.38.2"
  sha256 "32874cf067fe413e0cc86a2b44ec98544e37132761e4bec69dc71d06472d22bc"

  url "https://github.com/scheron/Daily/releases/download/v#{version}/Daily-#{version}-mac.dmg"
  name "Daily"
  desc "Simple daily planning and note-taking app"
  homepage "https://github.com/scheron/Daily"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "Daily.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Daily.app"],
        must_succeed: false
  end
end
