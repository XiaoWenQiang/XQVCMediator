Pod::Spec.new do |s|
  s.name     = "RXVCMediator"
  s.version  = "1.0.0"
  s.license  = "MIT"
  s.summary  = "ViewController push or present with Mediator"
  s.homepage = "https://github.com/XiaoWenQiang/XQVCMediator.git"
	s.author   = { "xiaoqiang" => "xiaowenqiang_1@126.com" }
  s.social_media_url = "https://www.jianshu.com/u/16227d25bcf4"
  s.source   = { :git => 'https://github.com/XiaoWenQiang/XQVCMediator.git', :tag => "v#{s.version}" }
  s.description = %{
    RXVCMediator is a simple viewcontroller to push or present.
  }
  s.source_files = 'XQVCMediator/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.platform = :ios, '8.0'

end