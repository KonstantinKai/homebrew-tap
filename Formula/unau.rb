class Unau < Formula
  desc "Terminal code review that ends in a file an agent can act on"
  homepage "https://github.com/KonstantinKai/unau"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.2/unau-aarch64-apple-darwin.tar.xz"
      sha256 "d816a140d2c5b632c0f17a882bfc6f1f5798fc7f18a5c3f8b8bd345e69416eb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.2/unau-x86_64-apple-darwin.tar.xz"
      sha256 "67f36981ab021680f37e7a6029f59f94276029003b9bfd026aea3749139e1a4a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.2/unau-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0ef72b951ee9b21124946431e5a1e74fcb725dff4f452a3c775965ea8022130"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.2/unau-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2cec00996cdb8ddb3bee51c687fca234e21a9bff801240ad5b3bc0b4e8cf35b3"
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
