Pod::Spec.new do |s|
  s.name                  = "YZClockView"
  s.version               = "0.1"
  s.summary               = "A simple, elegant UIView to express time."
  s.homepage              = "https://github.com/AustinChou/YZClockView"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Austin Chou" => "austinchou0126@gmail.com" }
  s.social_media_url      = "http://twitter.com/austinchou0126"
  s.platform              = :ios
  s.ios.deployment_target = "6.0"
  s.source                = { :git => "https://github.com/AustinChou/YZClockView.git", :tag => s.version }
  s.source_files          = "Classes/*.{h,m}"
  s.public_header_files   = "Classes/*.h"
  s.requires_arc          = true
end
