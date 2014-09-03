Pod::Spec.new do |s|
  s.name     = 'JSONHelper'
  s.version  = '1.1.0'
  s.license  = 'zlib'
  s.summary  = 'Lightning quick JSON deserialization for iOS & OS X written in Swift.'
  s.homepage = 'https://github.com/isair/JSONHelper'
  s.authors  = 'Baris Sencan'
  s.source   = { :git => 'https://github.com/isair/JSONHelper.git', :tag => '1.1.0' }
  s.source_files = 'JSONHelper/Pod Classes/*.swift'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
end
