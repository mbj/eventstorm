# -*- encoding: utf-8 -*-
require File.expand_path('../lib/eventstorm/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'eventstorm'
  s.version = Eventstorm::VERSION.dup

  s.authors  = ['Markus Schirp','Gibheer']
  s.email    = 'mbj@seonic.net'
  s.summary  = 'Event distribution and aggregation framework'
  s.homepage = 'http://github.com/mbj/eventstorm'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)
  s.extra_rdoc_files = %w(README.md)

  s.rubygems_version = '1.8.10'

  s.add_runtime_dependency('ffi-rzmq', '~> 0.9.3')
  s.add_runtime_dependency('bson', '~> 1.5.2')
  s.add_runtime_dependency('bson_ext', '~> 1.5.2')

  s.add_development_dependency('rspec',     '< 2.8.0')
end
