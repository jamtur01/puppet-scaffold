class PuppetGenerator < RubiGen::Base

  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil

  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      BASEDIRS.each { |path| m.directory path }

      m.template_copy_each %w( site.pp nodes.pp ), 'manifests'
      m.template_copy_each %w( site.pp nodes.pp ), 'manifests'
      m.template_copy_each %w( puppet.conf fileserver.conf )

    end
  end

  protected
    def banner
      <<-EOS
Creates a working Puppet configuration.

USAGE: #{spec.name} name
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
    end

    def extract_options
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      manifests
    )
end
