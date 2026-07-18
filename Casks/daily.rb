cask "daily" do
  version "0.17.0"
  sha256 "10f81721ee049130ed94b600c4a2d6093d276a1acfac4099b81c0ad750067af9"

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
