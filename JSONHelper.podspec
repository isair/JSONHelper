Pod::Spec.new do |s|
  s.name = 'JSONHelper'
  s.version = '2.1.0'
  s.license = { :type => 'zlib', :file => 'LICENSE' }
  s.summary = 'Convert anything into anything in one operation; hex strings into UIColor/NSColor, JSON strings into class instances, y/n strings to booleans, arrays and dictionaries of these; anything you can make sense of!'

  s.homepage = 'https://github.com/isair/JSONHelper'
  s.author = { 'Baris Sencan' => 'baris.sncn@gmail.com' }
  s.social_media_url = 'https://twitter.com/IsairAndMorty'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/isair/JSONHelper.git', :tag => s.version }
  s.source_files = 'JSONHelper/**/*.swift'
  s.frameworks   = 'Foundation'
  s.requires_arc = true
end
