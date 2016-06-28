#
# Be sure to run `pod lib lint NickFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NickFoundation"
  s.version          = "0.1.7"
  s.summary          = "Private Lib of Nick"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
"Private Lib of Nick , make coding fast"
                       DESC

  s.homepage         = "https://github.com/NickeyLin/NickFoundation"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Nick.Lin" => "tick_lin@sina.com" }
  s.source           = { :git => "https://github.com/NickeyLin/NickFoundation.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  #s.platform     = :ios, '6.0'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.7'

  s.requires_arc = true
  s.default_subspec = 'UILib','Common','Category'

  s.resource_bundles = {
    'NickFoundation' => ['Pod/Assets/*.png']
  }
  s.source_files = 'Pod/Classes/Common.h'

  s.subspec 'Common' do |cs|
    cs.source_files = 'Pod/Classes/Common'
  end

  s.subspec 'UILib' do |cs|
    cs.source_files = 'Pod/Classes/UILib'
  end

  s.subspec 'Category' do |cs|
    cs.source_files = 'Pod/Classes/Category'
  end

  s.subspec 'CoreData' do |cs|
    cs.source_files = 'Pod/Classes/CoreData'
    cs.dependency 'NickFoundation/Common'
  end

  s.subspec 'QRCode' do |cs|
    cs.source_files = 'Pod/Classes/QRCode/**/*'
    cs.dependency 'NickFoundation/UILib'
  end

  s.subspec 'Encode' do |cs|
    cs.source_files = 'Pod/Classes/Encode/**/*'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
