class ModuleGenerator < RubiGen::Base

  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  attr_reader :module_name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @module_name = args.shift
    @destination_root = "modules/#{module_name}"
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      BASEDIRS.each { |path| m.directory path }

      m.template_copy_each %w( README )
      m.template_copy_each %w( init.pp ), 'manifests'

    end
  end

  protected
    def banner
      <<-EOS
Creates a Puppet module.

USAGE: #{spec.name} name
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
    manifests
    files
    templates
    tests
    )
end
