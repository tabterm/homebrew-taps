require "language/node"

class Tabterm < Formula
  desc "What if your browser's new tab page was a terminal? Based on Chrome OS's hterm"
  homepage "https://github.com/tabterm/tabterm"
  head "https://github.com/tabterm/tabterm.git"
  url "https://registry.npmjs.org/tabterm/-/tabterm-1.2.3.tgz"
  sha256 "8090366c36ad9bd48413955436cc57144750e492fb2d7d91aa52f8f9f2fee5b4"

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
