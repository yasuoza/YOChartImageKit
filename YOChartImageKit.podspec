Pod::Spec.new do |s|
  s.name             = "YOChartImageKit"
  s.version          = "1.2.2"
  s.summary          = "ChartKit for watchOS"
  s.description      = <<-DESC
                       Chart image framework for watchOS

                       Since watchOS does not have `UIView` class, YOChartImageKit draws a `UIImage` of a chart with given values.
                       Values and colors can be customized.
                       DESC
  s.homepage         = "https://github.com/yasuoza/YOChartImageKit"
  s.screenshots      = "https://raw.githubusercontent.com/yasuoza/YOChartImageKit/assets/images/watchos/all.png"
  s.license          = "MIT"
  s.author           = { "Yasuharu Ozaki" => "yasuharu.ozaki@gmail.com" }
  s.source           = { :git => "https://github.com/yasuoza/YOChartImageKit.git", :tag => s.version.to_s }

  s.ios.deployment_target = "7.0"
  s.watchos.deployment_target = "2.0"

  s.requires_arc = true

  s.source_files = "Source/**/*.{h,m}"

  s.frameworks = "UIKit"
end
