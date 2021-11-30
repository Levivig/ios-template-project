# ios-template-project


## Installation

```sh
git clone https://github.com/Levivig/ios-template-project
cd ios-template-project
brew bundle
bundle install
bundle exec fastlane generate_project
open Template.xcodeproj/
```

## Configuration

1. Rename Template in project.yml, including Info.plist path
2. Rename the Template folder
3. Update paths in swiftgen.yml
4. Update paths in fastlane/Fastfile
5. Run `bundle exec fastlane generate_project` again
5. Open project, build and run to see if everything works
