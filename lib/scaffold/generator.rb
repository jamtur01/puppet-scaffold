module Scaffold
  module Generator
    extend Templater::Manifold

    desc <<-DESC
      Create template Puppet objects and configurations.
    DESC
    
    ##
    class ModuleGenerator < Templater::Generator
      desc <<-DESC
        Create an empty Puppet module. You must specify the name of the module.
      DESC
      
      first_argument :module_name, :required => true, :desc => "Your module name."
      
      def self.source_root
            File.join(File.dirname(__FILE__), 'templates/module')
      end
      
      # Create all subsdirectories
      empty_directory :files_directory do |d|
        d.destination = "#{module_name}/files"
      end
      empty_directory :templates_directory do |d|
        d.destination = "#{module_name}/templates"
      end
      empty_directory :lib_directory do |d|
        d.destination = "#{module_name}/lib/puppet/parser/functions"
      end
      empty_directory :libfacter_directory do |d|
        d.destination = "#{module_name}/lib/facter"
      end
          
      file :metadata_file do |f|
        f.source = "#{source_root}/metadata.json"
        f.destination = "#{module_name}/metadata.json" 
      end
      template :readme_file do |f|
        f.source = "#{source_root}/README"
        f.destination = "#{module_name}/README"
      end
      template :init_file do |f|
        f.source = "#{source_root}/manifests/init.pp"
        f.destination = "#{module_name}/manifests/init.pp"
      end
      template :testinit_file do |f| 
        f.source = "#{source_root}/tests/init.pp"
        f.destination = "#{module_name}/tests/init.pp"
      end 
      
    end

    class NodeGenerator < Templater::Generator
      desc <<-DESC
        Generate a basic Puppet node.  You must specify the name of the node.
      DESC

      first_argument :node_name, :required => true, :desc => "Your node name."
    
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates/puppet')
      end 
  
      # Create all subsdirectories
      empty_directory :manifests_directory do |d| 
        d.destination = "manifests/nodes/"
      end 
      
      template :node_file do |f|
        f.source = "#{source_root}/manifests/nodes/node.pp"
        f.destination = "manifests/nodes/#{node_name}.pp"
      end
 
    end 

    class ClassGenerator < Templater::Generator
      desc <<-DESC
        Create a Puppet class. You must specify the name of the module to create the class in and the name of the class.
      DESC
    
      first_argument :module_name, :required => true, :desc => "The module that contains the class"
      second_argument :class_name, :required => true, :desc => "Your class name."
    
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates/module')
      end 
   
      template :class_file do |f| 
        f.source = "#{source_root}/manifests/class.pp"
        f.destination = "#{module_name}/manifests/#{class_name}.pp"
      end 
    end 

    class DefineGenerator < Templater::Generator
      desc <<-DESC
        Create a Puppet definition. You must specify the name of the module to create the definition in and the name of the definition.
      DESC
    
      first_argument :module_name, :required => true, :desc => "The module that contains the definition"
      second_argument :define_name, :required => true, :desc => "Your definition name."
    
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates/module')
      end 
   
      template :class_file do |f| 
        f.source = "#{source_root}/manifests/define.pp"
        f.destination = "#{module_name}/manifests/#{define_name}.pp"
      end 
    end 

    class FunctionGenerator < Templater::Generator
      desc <<-DESC
        Create a Puppet function. Specify the name of the module, the name of the function and the type of the function, either statement or rvalue.  Generator defaults to statement.
      DESC
    
      first_argument :module_name, :required => true, :desc => "The module that contains the function"
      second_argument :function_name, :required => true, :desc => "Your function name."
      third_argument :type, :required => :true, :default => "statement", :desc => "The type of function."
    
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates/function')
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

    class TypeGenerator < Templater::Generator
      desc <<-DESC
        Create a Puppet type and provider. You must specify the module to create the type and provider in and the name of the type to be created.
      DESC
    
      first_argument :module_name, :required => true, :desc => "The module that contains the type"
      second_argument :type_name, :required => true, :desc => "Your type name."
    
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates/type')
      end 
   
      # Create all subsdirectories
      empty_directory :type_directory do |d| 
        d.destination = "#{module_name}/lib/puppet/type"
      end 
      empty_directory :provider_directory do |d|
        d.destination = "#{module_name}/lib/puppet/provider/#{type_name}"
      end

    
      template :type_file do |f| 
        f.source = "#{source_root}/type.rb"
        f.destination = "#{module_name}/lib/puppet/type/#{type_name}.rb"
      end
      template :provider_file do |f|    
        f.source = "#{source_root}/provider.rb"
        f.destination = "#{module_name}/lib/puppet/provider/#{type_name}/#{type_name}.rb"
      end
 
    end 

    class PuppetGenerator < Templater::Generator
      desc <<-DESC
        Generate a basic Puppet configuration.  
      DESC
    
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates/puppet')
      end 
  
      # Create all subsdirectories
      empty_directory :manifests_directory do |d| 
        d.destination = "manifests/nodes"
      end 
      empty_directory :files_directory do |d| 
        d.destination = "files"
      end 
    
      template :site_file do |f| 
        f.source = "#{source_root}/manifests/site.pp"
        f.destination = "manifests/site.pp"
      end
      file :fileserver_file do |f|
        f.source = "#{source_root}/fileserver.conf"
        f.destination = "fileserver.conf"
      end
    end
 
    add :module, ModuleGenerator
    add :node, NodeGenerator
    add :class, ClassGenerator
    add :define, DefineGenerator
    add :function, FunctionGenerator
    add :type, TypeGenerator
    add :puppet, PuppetGenerator
  end    
end
