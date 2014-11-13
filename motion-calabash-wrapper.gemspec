# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'motion-calabash-wrapper'
  s.summary = 'Enhanced support for XCode 6.1 and RubyMine in motion-calabash'
  s.description = 'motion-calabash-wapper provides fixes and enhancements for motion-calabash on XCode 6.1'
  s.author = 'René Köcher'
  s.email = 'shirk@bitspin.org'
  s.homepage = 'http://www.bitspin.org'
  s.version = '0.11.4.0'
  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("motion-calabash", "0.11.4")

end
