# coding: utf-8

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'capx/version'

Gem::Specification.new do |spec|
  spec.name                  = 'capx'
  spec.version               = Capx::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.2.0'
  spec.authors               = ['Jan Kmet']
  spec.email                 = ['jan.kmet@gmail.com']
  spec.summary               = 'SSH shortcut using capistrano deploy configuration'
  spec.description           =  <<-EOF
    SSH shortcut using capistrano deploy configuration.
    SSH username and host are parsed from capistrano deploy configuration
  EOF
  spec.homepage              = 'https://github.com/jankmet/capx'

  spec.files                 = `git ls-files`.split($RS)
  spec.executables           = ['capx']
  spec.test_files            = spec.files.grep(/^spec\//)
  spec.require_paths         = ['lib']
  spec.licenses              = ['MIT']
end

