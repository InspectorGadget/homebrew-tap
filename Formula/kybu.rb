class Kybu < Formula
  desc "Zero-Touch AWS IAM Policy Generator"
  homepage "https://github.com/InspectorGadget/kybu"
  # The GitHub Action will automatically update 'url' and 'sha256'
  url "https://github.com/InspectorGadget/kybu/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "c9e2cdfc75d8c7c18f5f460375fd29de8785ffb82e798d645a282319d2938e1e"
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