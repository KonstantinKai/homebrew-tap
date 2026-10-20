class Unau < Formula
  desc "Terminal code review that ends in a file an agent can act on"
  homepage "https://github.com/KonstantinKai/unau"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.4.0/unau-aarch64-apple-darwin.tar.xz"
      sha256 "9528fccc573a23f43fc67aa38296859ca7dd34e6415bea6daa816bfb777e761d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.4.0/unau-x86_64-apple-darwin.tar.xz"
      sha256 "5fcceb13434b7a63592efb70cc2f7313fff2ce812668fa41e8044d83dd1688c8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.4.0/unau-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "00c8f037b29f8699cef90caffa42e50216e58233b18d36a3feb0bb9ae8400093"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.4.0/unau-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "120a955a2fa1e040d0356ee8f4d3f5fa2d837f47acb269078f2a01e1801d0c72"
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
