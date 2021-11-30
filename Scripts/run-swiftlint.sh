export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint; then
  swiftlint
else
  echo "warning: SwiftLint not installed"
fi