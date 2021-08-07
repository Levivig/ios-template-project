platform :ios, '12.0'

inhibit_all_warnings!

target 'Template' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Template
  # pod 'Crashlytics'
  # pod 'Fabric'
  # pod 'Firebase/Analytics'
  pod "PromiseKit"
  # pod 'SDWebImage'
  pod 'SnapKit'
  pod 'SwifterSwift'
  pod 'SwiftLint'
  pod 'SwiftyBeaver'

end

post_install do | installer |
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end
    end
  end
end
