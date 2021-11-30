export PATH="$PATH:/opt/homebrew/bin"
if which swiftgen; then
  swiftgen -v
else
  echo "warning: swiftgen not installed"
fi