class Sker < Formula
  desc "Sker CLI: offline-first architectural rule engine and agent gate"
  homepage "https://github.com/ai-timer/sker"
  version "0.1.1-preview"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-aarch64-apple-darwin.tar.xz"
      sha256 "ff81817ce577b6becb60b11e356cc6aefc7a69110c01d0836d19957fe4a84820"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-x86_64-apple-darwin.tar.xz"
      sha256 "37555ff021c3cb411f9c08a9835dbb7110fbc576204c3b3e5c296a2c9b27e23e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e172ea11f956e3259a64e085fe31e1e2a47c82f2379c766c015e8318e6dffaf2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "38a274649abcd58be32698e307f62438495da00356d5c5a93a235d5329d0d418"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sker"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sker"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sker"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sker"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
