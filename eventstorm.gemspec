# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'eventstorm'
  s.version = '0.0.1'

  s.authors  = ['Markus Schirp','Gibheer']
  s.email    = 'mbj@schirp-dso.com'
  s.summary  = 'Event distribution and aggregation framework'
  s.homepage = 'http://github.com/mbj/eventstorm'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)
  s.extra_rdoc_files = %w(README.md)

  s.rubygems_version = '1.8.10'
end
