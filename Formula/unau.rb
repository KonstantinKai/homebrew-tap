class Unau < Formula
  desc "Terminal code review that ends in a file an agent can act on"
  homepage "https://github.com/KonstantinKai/unau"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.2.0/unau-aarch64-apple-darwin.tar.xz"
      sha256 "fe463b2cd8629e853bdd81d9f78468af0a3cbf3aea66872e77580667dd865579"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.2.0/unau-x86_64-apple-darwin.tar.xz"
      sha256 "3fe935fa6fe23810f4d91b7007b0e5fd16c94e583923a433cf4363057df8aad7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.2.0/unau-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f311958924c4718c1f3cefa930ae9944a08825c87a0cd53eddebf7f4c35bc434"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.2.0/unau-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d658ced200a4b64133e6eab5cbfe519e7caddfd5ac89085424dfb0e2f5ab578a"
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
