module Middleman::Features::Target
  TARGETS = { }
  DEFAULT_TARGET_CONFIGURATION_FILE = './targets.yaml'
  class << self
    def registered(app)
      if configuration_file = ENV['MIDDLEMAN_TARGET_CONFIGURATION']
        raise "#{configuration_file} was not found" unless File.exist?(configuration_file)
      end
      read_configuration(
         ENV['MIDDLEMAN_TARGET_CONFIGURATION'] || DEFAULT_TARGET_CONFIGURATION_FILE
      )

      app.extend ClassMethods
      app.helpers HelperMethods
    end
    alias :included :registered

    def read_configuration(configuration_file)
      return unless File.exist?(configuration_file)
      configuration(YAML.load(File.new(configuration_file)))
    end

    def configuration(overrides = {})
      # Anyone who thought constants in Ruby were really constant is probably
      # going to get confused by the next line, and why it throws no error.
      overrides.each{|k,v| TARGETS[k] = v}
      TARGETS
    end

  end

  module ClassMethods
    def build_targets(targets={})
      p targets
    end
  end

  module HelperMethods
    DEFAULT_BUILD_TARGET = :default
    def build_target
      @middleman_build_target ||= if ENV['MIDDLEMAN_BUILD_TARGET']
        ENV['MIDDLEMAN_BUILD_TARGET'].downcase.to_sym
      else
        DEFAULT_BUILD_TARGET
      end
    end

    def build_target_is?(target_name)
      build_target == target_name.to_sym
    end
    alias :target? :build_target_is?

    def default_target?
      build_target == DEFAULT_BUILD_TARGET
    end
    alias :no_target? :default_target?
  end
end
