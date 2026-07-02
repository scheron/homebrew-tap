cask "daily" do
  version "0.16.1"
  sha256 "71c6e034a9b9561b0f6d05f2c7d354d2ed338af5771e157e5d4402cbf8a75b17"

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
