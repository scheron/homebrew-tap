cask "daily" do
  version "0.31.0"
  sha256 "fa8fdb3d5d2181efc5ff03f2710305564104d8f20e938e1b004e78df0c2c708a"

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
