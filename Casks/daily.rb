cask "daily" do
  version "0.14.1"
  sha256 "c7b8446394f7bbc508fee6216e214bd48efcde0d29443392d8e77988ac0e10f6"

  url "https://github.com/scheron/Daily/releases/download/v#{version}/Daily-#{version}-mac.dmg"
  name "Daily"
  desc "Simple daily planning and note-taking app"
  homepage "https://github.com/scheron/Daily"

  depends_on arch: :arm64

  app "Daily.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Daily.app"],
                   must_succeed: false
  end

  livecheck do
    url :url
    strategy :github_latest
  end
end
