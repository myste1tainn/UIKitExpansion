Pod::Spec.new do |s|
  s.name             = 'UIKitExpansion'
  s.version          = '0.1.0'
  s.summary          = 'Code extension, object and function on top of Apple\'s UIKit'
  s.description      = <<-DESC
  This library provide convenience functions, object and extension over Apple's UIKit framework
  So that developer can write a shorter cleaner code.
                       DESC

  s.homepage         = 'https://github.com/myste1tainn/UIKitExpansion'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'myste1tainn' => 'a.keereena@gmail.com' }
  s.source           = { :git => 'https://github.com/myste1tainn/UIKitExpansion.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'UIKitExpansion/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'SwiftExpansion', '~> 0.2'
end
