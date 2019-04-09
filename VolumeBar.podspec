Pod::Spec.new do |s|
  s.name = 'VolumeBar'
  s.version = '3.1'
  s.swift_version = '5.0'
  s.summary = 'A volume indicator that doesn\'t obstruct content.'
  s.homepage = 'https://gizmosachin.github.io/VolumeBar/'
  s.license = 'MIT'
  s.social_media_url = 'https://twitter.com/gizmosachin'
  s.author = { 'Sachin Patel' => 'me@gizmosachin.com' }
  s.source = { :git => 'https://github.com/gizmosachin/VolumeBar.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/*.swift', 'Sources/Internal/*.swift'
  s.requires_arc = true
  s.frameworks = 'Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore'
  s.documentation_url = 'https://gizmosachin.github.io/VolumeBar/'
end
