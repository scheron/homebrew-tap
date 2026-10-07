cask "daily" do
  version "0.31.1"
  sha256 "b0b56a6c4ff3dac455d90f4793d869df87b40cfef6664feb76d7af960e2fec95"

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
