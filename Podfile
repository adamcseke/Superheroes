platform :ios, '12.0'

inhibit_all_warnings!

target 'Superheroes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Superheroes
  # pod 'Crashlytics'
  # pod 'Fabric'
  # pod 'Firebase/Analytics'
  # pod 'SDWebImage'
  pod 'SnapKit'
  pod 'SwifterSwift'
  pod 'SwiftLint'
  pod 'SwiftyBeaver'
  pod 'SDWebImage'
  pod 'SwiftGen'
  pod 'TBEmptyDataSet'
  pod 'Charts'
  pod 'SQLite.swift'

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
