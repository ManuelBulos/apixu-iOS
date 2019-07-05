#
# Be sure to run `pod lib lint APIXU.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'APIXU'
  s.version          = '0.1.0'
  s.summary          = 'Swift library for Apixu Weather API http://www.apixu.com'

  s.description      = <<-DESC
  'iOS library for Apixu Weather API http://www.apixu.com'
                       DESC

  s.homepage         = 'https://github.com/manuelbulos/apixu-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'manuelbulos' => 'manuelbulos@gmail.com' }
  s.source           = { :git => 'https://github.com/manuelbulos/apixu-iOS.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/manuelbulos'

  s.ios.deployment_target = '10.0'
  s.swift_versions = '5.0'

  s.source_files = 'APIXU/Classes/**/*'
  s.frameworks = 'Foundation', 'CoreLocation'
end
