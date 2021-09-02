#
# Be sure to run `pod lib lint TurfSwiftBuffer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TurfSwiftBuffer'
  s.version          = '1.0.0'
  s.summary          = 'create a buffer with coordinates'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Use when you want to get coordinates with a buffer of a certain distance inside or outside from polygonal coordinates
                       DESC

  s.homepage         = 'https://github.com/JK0369/TurfSwiftBuffer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JongKwonKim' => 'palatable7@naver.com' }
  s.source           = { :git => 'https://github.com/JK0369/TurfSwiftBuffer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '13.0'

  s.source_files = 'TurfSwiftBuffer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TurfSwiftBuffer' => ['TurfSwiftBuffer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Turf'
end
