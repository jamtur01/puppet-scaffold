path = File.dirname(__FILE__) + '/scaffold/'

require 'rubygems'
require 'templater'
require 'puppet'
require path + 'generator'

module Scaffold

  Puppet.parse_config

  VERSION = '0.0.3'

end
