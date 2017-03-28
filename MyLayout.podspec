
Pod::Spec.new do |s|
  s.name             = 'MyLayout'
  s.version          = '1.3.4'
  s.summary          = '供应链收费模块'

  s.description      = <<-DESC
'供应链收费模块的抽取成pod'
                       DESC

  s.homepage         = 'https://github.com/youngsoft/MyLinearLayout'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhuru' => 'zhuru@2dfire.com' }
  s.source       = { :git => "https://github.com/youngsoft/MyLinearLayout.git", :tag => "1.3.4" }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MyLayout/Lib/*.{h,m}'

  s.resources = 'Resources/**/*'
  s.public_header_files = "MyLayout/Lib/*.h"


end
