# Homebrew formula for LeakyRepo
# To use: brew install --build-from-source <path-to-this-file>
# Or: brew tap gittingsboyce/leakyrepo && brew install leakyrepo

class Leakyrepo < Formula
  desc "Secrets detection tool that catches API keys and tokens before commit"
  homepage "https://github.com/gittingsboyce/leakyrepo"
  url "https://github.com/gittingsboyce/leakyrepo/archive/v1.2.1.tar.gz"
  sha256 "0f6638ca036ef1fa300f2af9f239b1e73fee296eb164cf82b4cf60f8a8983462"
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

