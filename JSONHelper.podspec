Pod::Spec.new do |spec|
  spec.name         = 'JSONHelper'
  spec.version      = '1.4.1'
  spec.summary      = 'Lightning fast JSON deserialization and value conversion library for iOS & OS X written in Swift.'

  spec.homepage     = 'https://github.com/isair/JSONHelper'
  spec.license      = { :type => 'zlib', :file => 'LICENSE' }
  spec.author       = { 'Baris Sencan' => 'barissncn@gmail.com' }

  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.9'

  spec.source       = { :git => 'https://github.com/isair/JSONHelper.git', :tag => '1.4.1' }
  spec.source_files = 'JSONHelper/*.swift'
  spec.frameworks   = 'Foundation'
  spec.requires_arc = true
end