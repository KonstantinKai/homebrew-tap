class Unau < Formula
  desc "Terminal code review that ends in a file an agent can act on"
  homepage "https://github.com/KonstantinKai/unau"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.1/unau-aarch64-apple-darwin.tar.xz"
      sha256 "afe46f9262e4ebbe07da35a2abb4a092232632b39e7beef340dfd9c8c3374195"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.1/unau-x86_64-apple-darwin.tar.xz"
      sha256 "0fa6b574f8b40f04dc05a6f1639096c139bbe23fe9f60cd26d525d72c88e67cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.1/unau-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "63e66b88f2b9baef5e24d80824cab080e003be5dd1e13477c85e0eba8daa9c7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KonstantinKai/unau/releases/download/v0.5.1/unau-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a317d039b7e548b0bede482768ec85899041081926655e74b3e2d25386bd591"
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
