Pod::Spec.new do |s|
  s.name             = 'ChartSDK'
  s.version          = '0.1.0'
  s.summary          = 'ChartSDK lets a user create charts.'

  s.description      = <<-DESC
  ChartSDK lets a user create pie charts.
                       DESC

  s.homepage         = 'https://github.com/a-kolosov/ChartSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anton Kolosov' => 'kolosovanton91@gmail.com' }
  s.source           = { :git => 'https://github.com/a-kolosov/ChartSDK.git', :tag => s.version.to_s }

  s.source_files = 'ChartSDK/Classes/**/*'
  s.frameworks = 'UIKit', 'CoreGraphics'
  s.ios.deployment_target = '10.3'
  s.swift_version = "5.0"
end
