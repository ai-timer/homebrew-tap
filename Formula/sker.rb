class Sker < Formula
  desc "Sker CLI: offline-first architectural rule engine and agent gate"
  homepage "https://github.com/ai-timer/sker"
  version "0.1.1-preview"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-aarch64-apple-darwin.tar.xz"
      sha256 "4131f0542a9942d9f1ea02461f70f1b9c58bdaea012dcc31902f58d9594266fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-x86_64-apple-darwin.tar.xz"
      sha256 "c12bd9a316fe92dc099017bb47f94eb77f9b06937b6f12154b9ed09f1b217857"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a9ef8722914ac964e122cb0e6fc46338af90d7bd1502b14a9867dd5d99dcd57f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-timer/sker/releases/download/v0.1.1-preview/sker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "12e5090319f445f908fd0a6ad507c15df5950f8637f36b0d5cbd1a6bed6c48e9"
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
