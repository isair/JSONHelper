Pod::Spec.new do |s|
  s.name         = 'JSONHelper'
  s.version      = '1.3.0'
  s.summary      = 'Lightning quick JSON deserialization for iOS & OS X written in Swift.'
  s.homepage     = 'https://github.com/isair/JSONHelper'
  s.license      = { :type => 'zlib', :file => 'LICENSE' }
  s.author       = { 'Baris Sencan' => 'barissncn@gmail.com' }
  s.source       = { :git => 'https://github.com/isair/JSONHelper.git', :tag => '1.3.0' }
  s.source_files = 'JSONHelper/Pod Classes/*.swift'
  s.frameworks   = 'Foundation'
  s.requires_arc = true
end