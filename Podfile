source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'

def core 
  use_frameworks!
  inhibit_all_warnings!
  pod 'Alamofire', '~> 4.7'
  pod 'SQLite.swift', '~> 0.11.5'
  pod 'Moya'
  pod 'ModelMapper'
  pod 'SwiftyJSON', '~> 4.0'
end

def uikits
  use_frameworks!
  inhibit_all_warnings!
  pod 'IQKeyboardManagerSwift'
  pod 'DropDown', '2.3.13'
end

target 'currency_btc' do
  core
  uikits
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if Gem::Version.new('12.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
