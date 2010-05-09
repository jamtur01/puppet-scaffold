require 'rubygems'
require 'rake'
require 'rake/gempackagetask'
require 'fileutils'
require 'ftools'

version = File.read('lib/scaffold.rb')[/VERSION *= *'(.*)'/,1] or fail "Couldn't find Scaffold version"

GEM_FILES = FileList[
    '[A-Z]*',
    'bin/**/*',
    'lib/**/*',
]

spec = Gem::Specification.new do |spec|
    spec.name = 'scaffold'
    spec.files = GEM_FILES.to_a
    spec.executables = 'scaffold'
    spec.version = version
    spec.add_dependency('templater', '>= 0.5.0')
    spec.summary = 'Scaffold is a templating tool for Puppet'
    spec.description = 'Scaffold allows you to create basic Puppet configuration, modules, nodes, classes, functions and types.'
    spec.author = 'James Turnbull'
    spec.email = 'james@lovedthanlost.net'
    spec.homepage = 'http://github.com/jamtur01/puppet-scaffold'
    spec.rdoc_options = ["--main", "README.rdoc"]
    spec.require_paths = ["lib"]
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
  end

desc "Release gem to Gemcutter"
task :release => :build do
  system "gem push scaffold-#{version}.gem"
end
