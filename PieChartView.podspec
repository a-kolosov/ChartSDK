Pod::Spec.new do |s|

  # 1
  s.platform = :ios
  s.ios.deployment_target = '10.3'
  s.name = "PieChartView"
  s.summary = "PieChartView lets a user create a simple pie chart."
  s.requires_arc = true
  
  # 2
  s.version = "0.1.0"
  
  # 3
  s.license = { :type => "MIT", :file => "LICENSE" }
  
  # 4 - Replace with your name and e-mail address
  s.author = { "Anton Kolosov" => "kolosovanton91@gmail.com" }
  
  # 5 - Replace this URL with your own GitHub page's URL (from the address bar)
  s.homepage = "https://github.com/a-kolosov/PieChartView"
  
  # 6 - Replace this URL with your own Git URL from "Quick Setup"
  s.source = { :git => "https://github.com/a-kolosov/PieChartView.git", 
               :tag => "#{s.version}" }
  
  # 7
  s.framework = "UIKit"
  
  # 8
  s.source_files = "PieChartView/**/*.{swift}"
  
  # 9
  s.swift_version = "5.0"
  
  end