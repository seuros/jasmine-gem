module Jasmine
  class YamlConfigParser
    def initialize(path, pwd, path_expander = lambda {}, yaml_loader = lambda {})
      @path = path
      @path_expander = path_expander
      @pwd = pwd
      @yaml_loader = yaml_loader
    end

    def src_dir
      return @pwd unless loaded_yaml['src_dir']
      File.join(@pwd, loaded_yaml['src_dir'])
    end

    def spec_dir
      return File.join(@pwd, 'spec', 'javascripts') unless loaded_yaml['spec_dir']
      File.join(@pwd, loaded_yaml['spec_dir'])
    end

    def src_files
      @path_expander.call(src_dir, loaded_yaml['src_files'] || [])
    end

    def spec_files
      @path_expander.call(spec_dir, loaded_yaml['spec_files'] || [])
    end

    def helpers
      @path_expander.call(spec_dir, loaded_yaml['helpers'] || [])
    end

    def css_files
      @path_expander.call(src_dir, loaded_yaml['stylesheets'] || [])
    end

    private
    def loaded_yaml
      @yaml_loader.call(@path)
    end
  end
end
