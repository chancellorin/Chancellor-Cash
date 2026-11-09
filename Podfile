source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

target 'Sherlock' do
  use_frameworks!

  pod 'Alamofire'
  pod 'KKDeviceInsightKitSwift'
  pod 'KKUtilsKitSwift'
  pod 'PureLayout'
  pod 'SnapKit'
  pod 'CHIOTPField/Two'
  pod 'SideMenuSwift'
  pod 'KKCameraKitSwift'
  pod 'KakaJSON'
  pod 'SVProgressHUD'
  pod 'KKImageCompressKitSwift'
  pod 'IQKeyboardManagerSwift'
  pod 'Adjust'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 15.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
