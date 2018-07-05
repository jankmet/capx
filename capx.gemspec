# coding: utf-8

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'capx/version'

Gem::Specification.new do |spec|
  spec.name                  = 'capx'
  spec.version               = Capx::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 1.9.3'
  spec.authors               = ['Jan Kmet']
  spec.email                 = ['jan.kmet@gmail.com']
  spec.summary               = 'capistrano shell extension for ssh'
  spec.description           =  <<-EOF
    Uses capistrano file structur for accessing ssh.
  EOF
  spec.homepage              = ''

  spec.files                 = `git ls-files`.split($RS)
  spec.executables           = ['capx']
  spec.test_files            = spec.files.grep(/^spec\//)
  spec.require_paths         = ['lib']
  spec.licenses              = ['MIT']
end

