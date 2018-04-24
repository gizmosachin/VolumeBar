Pod::Spec.new do |s|
  s.name = 'VolumeBar'
  s.version = '3.0.3'
  s.summary = 'A volume indicator that doesn\'t obstruct content.'
  s.homepage = 'http://github.com/gizmosachin/VolumeBar'
  s.license = 'MIT'
  s.social_media_url = 'http://twitter.com/gizmosachin'
  s.author = { 'Sachin Patel' => 'me@gizmosachin.com' }
  s.source = { :git => 'https://github.com/gizmosachin/VolumeBar.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/*.swift', 'Sources/Internal/*.swift'
  s.requires_arc = true
  s.frameworks = 'Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore'
  s.documentation_url = 'http://gizmosachin.com/VolumeBar/'
end
