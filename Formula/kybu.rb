class Kybu < Formula
  desc "Zero-Touch AWS IAM Policy Generator"
  homepage "https://github.com/InspectorGadget/kybu"
  # The GitHub Action will automatically update 'url' and 'sha256'
  url "https://github.com/InspectorGadget/kybu/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "b200f00ba472b8e0da9a44ae962ddd4b1e868f10c471fc7e3d887e3b0cac8386"
  license "MIT"

  # Ensures Go is installed before building
  depends_on "go" => :build

  def install
    # Inject the version dynamically during the local build.
    ldflags = [
      "-s -w",
      "-X github.com/InspectorGadget/kybu/variables.Version=v#{version}"
    ].join(" ")

    # Build the binary and install it to the Homebrew bin directory
    system "go", "build", "-ldflags", ldflags, "-o", bin/"kybu", "."
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/kybu --version")
  end
end