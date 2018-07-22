# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'depp'
  s.version       = '1.0.0'
  s.date          = '2018-07-22'
  s.summary       = "Talk to other languages' package managers"
  s.authors       = ['Aaron Christiansen']
  s.email         = 'aaronc20000@gmail.com'
  s.files         = Dir.glob('src/**/*')
  s.license       = 'MIT'
  s.require_paths = %w[src]
end
