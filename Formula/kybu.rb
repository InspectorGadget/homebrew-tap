class Kybu < Formula
  desc "Zero-Touch AWS IAM Policy Generator"
  homepage "https://github.com/InspectorGadget/kybu"
  # The GitHub Action will automatically update 'url' and 'sha256'
  url "https://github.com/InspectorGadget/kybu/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "b970af6d9a5f96a36fdf1bb8b9f054c1ce13169e4f98561591cb9df91c763faf"
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