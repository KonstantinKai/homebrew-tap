class Unau < Formula
  desc "Terminal code review that ends in a file an agent can act on"
  homepage "https://github.com/KonstantinKai/unau"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.8.0/unau-aarch64-apple-darwin.tar.xz"
      sha256 "b095cd79e7806c003efbd703c7f4c6d0af0483c0fba10c9961e7555e9f23c780"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.8.0/unau-x86_64-apple-darwin.tar.xz"
      sha256 "8a2092cce28958b9591e8a79054e129a951bc5a15e1780a26dde47d9d6dbe6d6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.8.0/unau-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "46a0ed1f3c2326f9467428ca86b40bab8f9480fca1a22a9739bab2b655d7aaea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.8.0/unau-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cde66788660297b160ff2a12433a817749c86413d3b980ede4a531135d7dc250"
    end
  end
  license "MIT"

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
      bin.install "unau"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "unau"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "unau"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "unau"
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
