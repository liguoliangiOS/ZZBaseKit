#
# Be sure to run `pod lib lint ZZBaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZZBaseKit'
  s.version          = '0.1.4'
  s.summary          = '方便使用的基础库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                      把常用的方法做了一个整合，形成一个方便使用的基础库
                       DESC

  s.homepage         = 'https://github.com/liguoliangiOS/ZZBaseKit'
  s.license          =  { :type => 'MIT', :text => <<-LICENSE
                          Copyright © 2019 ZZBaseKit
                          All rights reserved.
                          LICENSE
                        }
  s.author           = 'liguoliang'
  s.source           = { :git => 'https://github.com/liguoliangiOS/ZZBaseKit.git', :tag => s.version.to_s }
  s.swift_version =  '5.0'
  s.ios.deployment_target = '8.0'
  s.source_files = 'ZZBaseKit/BaseKit/**/*'


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
