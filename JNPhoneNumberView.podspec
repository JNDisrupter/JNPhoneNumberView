
Pod::Spec.new do |s|
  s.name                        = "JNPhoneNumberView"
  s.version                     = "1.0.14"
  s.summary                     = "Phone Number Validation with country dial code picker"
  s.description                 = "A view to show the country dial code and the phone number, you can click on the dial code and select another country from the countries picker, this view has a delegate methods to pass the international number and validity of it."
  s.homepage                    = "https://github.com/JNDisrupter"
  s.license                     = { :type => "MIT", :file => "LICENSE" }
  s.author                      = { "Jayel Zaghmoutt" => "eng.jayel.z@gmail.com", "hamzakhanfar" => "ha.khanfer@gmail.com" }
  s.source                      = { :git => "https://github.com/JNDisrupter/JNPhoneNumberView.git", :tag => "#{s.version}" }
  s.ios.deployment_target       = "9.0"
  s.swift_version               = "5.0"
  s.source_files                = "JNPhoneNumberView/**/*.swift"
  s.resources                   = "JNPhoneNumberView/**/*.{png,pdf,jpeg,jpg,storyboard,xib,xcassets,ttf,json}"
  s.dependency "libPhoneNumber-iOS"
end
