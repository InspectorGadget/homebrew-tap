class Kybu < Formula
  desc "Zero-Touch AWS IAM Policy Generator"
  homepage "https://github.com/InspectorGadget/kybu"
  # The GitHub Action will automatically update 'url' and 'sha256'
  url "https://github.com/InspectorGadget/kybu/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "f1702a01b7639c3d99097e3ecee1bc7e1db1c15d430b460a68506ea39dea32a8"
  license "MIT"

  # Ensures Go is installed before building
  depends_on "go" => :build

  def install
    ldflags = [
      "-s -w",
      "-X github.com/InspectorGadget/kybu/variables.Version=v#{version}"
    ].join(" ")

    # Build the binary and install it to the Homebrew bin directory
    system "go", "build", "-ldflags", ldflags, "-o", bin/"kybu", "."
  end

  def caveats
    <<~EOS
      Kybu has been installed!

      To start generating IAM policies, simply run:
        kybu

      Then open your browser to:
        http://localhost:8080

      Note: Kybu will automatically enable AWS CSM in your ~/.aws/config 
      and disable it when you exit (Ctrl+C).
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/kybu --version")
  end
end