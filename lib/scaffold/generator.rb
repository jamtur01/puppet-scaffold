module Scaffold
  module Generator
    extend Templater::Manifold
    
    desc <<-DESC
      Create template Puppet objects and configurations.
    DESC
    
    ##
    class ModuleGenerator < Templater::Generator
      desc <<-DESC
        Create an empty Puppet module
      DESC
      
      first_argument :module_name, :required => true, :desc => "Your module name."
      
      def self.source_root
        File.expand_path(File.join(Dir.pwd, 'templates/module'))
      end
      
      # Create all subsdirectories
      empty_directory :manifests_directory do |d|
        d.destination = "#{module_name}/manifests"
      end
      empty_directory :files_directory do |d|
        d.destination = "#{module_name}/files"
      end
      empty_directory :templates_directory do |d|
        d.destination = "#{module_name}/templates"
      end
      empty_directory :tests_directory do |d|
        d.destination = "#{module_name}/tests"
      end
      empty_directory :lib_directory do |d|
        d.destination = "#{module_name}/lib/puppet/parser/functions"
      end
      empty_directory :libfacter_directory do |d|
        d.destination = "#{module_name}/lib/facter"
      end
           
      template :readme_file do |f|
        f.source = "#{source_root}/README"
        f.destination = "#{module_name}/README"
      end
      template :init_file do |f|
        f.source = "#{source_root}/manifests/init.pp"
        f.destination = "#{module_name}/manifests/init.pp"
      end
      
    end

    class FunctionGenerator < Templater::Generator
      desc <<-DESC
        Create a Puppet function.
      DESC
    
      first_argument :module_name, :required => true, :desc => "The module that contains the function"
      second_argument :function_name, :required => true, :desc => "Your function name."
      third_argument :type, :required => :true, :default => "statement", :desc => "The type of function."
    
      def self.source_root
        File.expand_path(File.join(Dir.pwd, 'templates/function'))
      end 
   
      # Create all subsdirectories
      empty_directory :lib_directory do |d| 
        d.destination = "#{module_name}/lib/puppet/parser/functions"
      end 
    
      template :function_file do |f| 
        f.source = "#{source_root}/function.rb"
        f.destination = "#{module_name}/lib/puppet/parser/functions/#{function_name}.rb"
      end
    end

    class PuppetGenerator < Templater::Generator
      desc <<-DESC
        Generate a basic Puppet configuration - specify the location of your Puppet configuration directory, for example /etc/puppet.
      DESC
    
      first_argument :confdir_name, :required => true, :desc => "The location of configuration directory."
    
      def self.source_root
        File.expand_path(File.join(Dir.pwd, 'templates/puppet')) 
      end 
  
      # Create all subsdirectories
      empty_directory :manifests_directory do |d| 
        d.destination = "#{confdir_name}/manifests"
      end 
      empty_directory :files_directory do |d| 
        d.destination = "#{confdir_name}/files"
      end 
    
      template :site_file do |f| 
        f.source = "#{source_root}/manifests/site.pp"
        f.destination = "#{confdir_name}/manifests/site.pp"
      end
      file :fileserver_file do |f|
        f.source = "#{source_root}/fileserver.conf"
        f.destination = "#{confdir_name}/fileserver.conf"
      end
    end
 
    add :module, ModuleGenerator
    add :function, FunctionGenerator
    add :puppet, PuppetGenerator
  end    
end
