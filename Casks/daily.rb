cask "daily" do
  version "0.37.0"
  sha256 "4cac1b3a84ee1a4b6ad9f43995691078f3226684066336612463f60fb55273a3"

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
