cask "daily" do
  version "0.14.0"
  sha256 "ac48e0cb8b3643ae135bd05ce18f7ad3579ff07649cd0ed40398b494f2e803b9"

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
