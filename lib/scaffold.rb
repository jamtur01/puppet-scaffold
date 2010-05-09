path = File.dirname(__FILE__) + '/scaffold/'

require 'rubygems'
require 'templater'
require 'puppet'
require path + 'generator'

module Scaffold

  Puppet.parse_config

  VERSION = '0.0.2'

  def config
    config = {}
  
    configfile = options[:configfile] || Puppet[:confdir] + 'scaffold.conf'

    File.foreach(configfile) do |line|
      line.strip!
      # Skip comments and whitespace
      if (line[0] != ?# and line =~ /\S/ )
        i = line.index('=')
        if (i)
          config[line[0..i - 1].strip] = line[i + 1..-1].strip
        else
          config[line] = ''
        end
      end
    end
 
    # Print it out
    config.each do |key, value|
      print key + " = " + value
      print "\n"
    end
  end

end
