Pod::Spec.new do |spec|
  spec.name          = 'JSONyCodable'
  spec.homepage      = "https://github.com/Machipla/JSONyCodable"
  spec.version       = '0.0.2'
  spec.platform      = :ios, "9.0"
  spec.authors       = 'Mario Chinchilla'
  spec.summary       = 'Making easier the decoding/encoding from/to JSON via Decodable/Encodable protocol!'
  spec.license       = { :type => "MIT", :file => "LICENSE.md" }
  spec.source        = { :git => 'https://github.com/Machipla/JSONyCodable.git', :tag => "#{spec.version}" }
  spec.swift_version = '4.0'

  spec.source_files = 'Sources/**/*.{swift}'
  spec.dependency     'SugarLump/Foundation', '~> 0.0.1'
  spec.frameworks   = 'Foundation'
end