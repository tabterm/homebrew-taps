require "language/node"

class Tabterm < Formula
  desc "What if your browser's new tab page was a terminal? Based on Chrome OS's hterm"
  homepage "https://github.com/dbkaplun/tabterm"
  head "https://github.com/dbkaplun/tabterm.git"
  url "https://registry.npmjs.org/tabterm/-/tabterm-1.2.0.tgz"
  sha256 "ac6aac4260039e26ca0118e2c7853f2c52c683dfd6ae7fbdfe10b7a33deb5a9b"

  depends_on "node"
  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  plist_options :manual => "tabterm"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>bash</string>
          <string>-lc</string>
          <string>#{opt_bin}/tabterm</string>
        </array>
        <key>KeepAlive</key>
        <dict>
          <key>Crashed</key>
          <true/>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>ProcessType</key>
        <string>Background</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/tabterm.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/tabterm.log</string>
      </dict>
    </plist>
    EOS
  end

  test do
    true
  end
end