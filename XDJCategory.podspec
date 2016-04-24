

Pod::Spec.new do |s|
  s.name             = "XDJCategory"
  s.version          = "0.1.0"
  s.summary          = "xdj category."


  s.description      = <<-DESC
"xdj specs category."
                       DESC

  s.homepage         = "https://github.com/kentchen1991/XDJCategory"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "kentchen1991" => "492122973@qq.com" }
  s.source           = { :git => "https://github.com/kentchen1991/XDJCategory.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'XDJCategory/Classes/**/*'
  s.resource_bundles = {
    'XDJCategory' => ['XDJCategory/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
