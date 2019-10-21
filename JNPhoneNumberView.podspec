
Pod::Spec.new do |s|
  s.name                        = "JNPhoneNumberView"
  s.version                     = "1.0.0"
  s.summary                     = "A short description of JNPhoneNumberView."
  s.description                 = "Test"
  s.homepage                    = "https://github.com/JNDisrupter"
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license                     = { :type => "MIT", :file => "LICENSE" }
  s.author                      = { "Jayel Zaghmoutt" => "eng.jayel.z@gmail.com", "hamzakhanfar" => "ha.khanfer@gmail.com" }
  s.source                      = { :git => "https://github.com/JNDisrupter/JNPhoneNumberView.git", :tag => "#{s.version}" }
  s.ios.deployment_target       = "9.0"
  s.swift_version               = "5.0"
  s.source_files                = "JNPhoneNumberView/**/*.swift"
  s.resources                   = "JNPhoneNumberView/**/*.{png,pdf,jpeg,jpg,storyboard,xib,xcassets,ttf,json}"
  s.dependency "libPhoneNumber-iOS"
end
