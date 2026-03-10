cask "daily" do
  version "0.12.8"
  sha256 "02c4a1a5f09c793d6e4ee8c13f9daa20e1cda5d4dd122606719e66f2030c8d4b"

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
