#
# Be sure to run `pod lib lint JNPhoneNumberView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JNPhoneNumberView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of JNPhoneNumberView.'
  s.description      = ""
  s.homepage         = "https://github.com/JNDisrupter"
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Jayel Zaghmoutt" => "eng.jayel.z@gmail.com", "hamzakhanfar' => 'ha.khanfer@gmail.com" }
  s.source           = { :git => 'https://github.com/hamzakhanfar/JNPhoneNumberView.git', :tag => s.version.to_s }
  s.ios.deployment_target       = '9.0'
  s.swift_version               = '5.0'
  s.source_files = 'JNPhoneNumberView/**/*.swift'
  s.resources = 'JNPhoneNumberView/**/*.{png,pdf,jpeg,jpg,storyboard,xib,xcassets,ttf,json}'
  s.dependency 'libPhoneNumber-iOS'
end
