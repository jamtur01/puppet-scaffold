require 'rubygems'
require 'newgem/tasks'
require 'fileutils'
require 'templater'
require File.dirname(__FILE__)+'/lib/scaffold.rb'

version = Scaffold::VERSION

desc "Build gem"
task :build do
  system "gem build .gemspec"
end

desc "Release gem to Gemcutter"
task :release => :build do
  system "gem push scaffold-#{version}.gem"
end
