require 'ftools'
require 'rake'
require 'templater'
require File.dirname(__FILE__)+'/lib/scaffold.rb'

GEM_FILES = FileList[
    '[A-Z]*',
    'bin/**/*',
    'lib/**/*',
    'spec/**/*',
    'templates/**/**'
]

Gem::Specification.new do |spec|
    spec.platform = Gem::Platform::RUBY
    spec.name = 'scaffold'
    spec.files = GEM_FILES.to_a
    spec.executables = 'scaffold'
    spec.version = Scaffold::VERSION
    spec.add_dependency('puppet', '>= 0.24.8')
    spec.add_dependency('templater', '>= 0.5.0')
    spec.summary = 'Scaffold is a templating tool for Puppet'
    spec.description = 'Scaffold allows you to create basic Puppet configuration, modules, nodes, classes, functions and types.'
    spec.author = 'James Turnbull'
    spec.email = 'james@lovedthanlost.net'
    spec.homepage = 'http://github.com/jamtur01/puppet-scaffold'
    spec.rdoc_options = ["--main", "README.rdoc"]
    spec.require_paths = ["lib"]
end
