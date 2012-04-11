module Middleman::Features::Target

  class << self
    def registered(app)
      app.set :build_targets, {}
      app.extend ClassMethods
      app.helpers HelperMethods
    end
    alias :included :registered
  end

  module ClassMethods
    def set_build_targets(targets={})
      settings.build_targets = targets
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
