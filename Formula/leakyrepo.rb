# Homebrew formula for LeakyRepo
# To use: brew install --build-from-source <path-to-this-file>
# Or: brew tap gittingsboyce/leakyrepo && brew install leakyrepo

class Leakyrepo < Formula
  desc "Secrets detection tool that catches API keys and tokens before commit"
  homepage "https://github.com/gittingsboyce/leakyrepo"
  url "https://github.com/gittingsboyce/leakyrepo/archive/v1.1.0.tar.gz"
  sha256 "aa11a80f6185d85f0d483e0741e72addda2dd4c757d5a6e7fdceaa06722519c4"
  license "MIT"
  head "https://github.com/gittingsboyce/leakyrepo.git", branch: "main"

  depends_on "go" => :build

  def install
    # Build the binary
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"leakyrepo", "."
  end

  test do
    # Test that the binary works
    system bin/"leakyrepo", "version"
    
    # Test init command
    testpath = testpath/"test-project"
    testpath.mkpath
    cd testpath do
      system bin/"leakyrepo", "init"
      assert_predicate testpath/".leakyrepo.yml", :exist?
    end
  end
end

