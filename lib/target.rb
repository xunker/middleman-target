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
      raise "#set_build_targets() argument must be a hash" unless targets.class == Hash
      settings.build_targets = targets
    end
  end

  module HelperMethods
    DEFAULT_BUILD_TARGET = :default

    def build_targets
      @build_target ||= settings.build_targets
    end

    def build_target
      @middleman_build_target ||= if ENV['MIDDLEMAN_BUILD_TARGET']
        ENV['MIDDLEMAN_BUILD_TARGET'].downcase.to_sym
      else
        DEFAULT_BUILD_TARGET
      end
    end

    def build_target_is?(target_name)
      if build_targets.empty?
        build_target == target_name.to_sym
      else
        if !build_targets[target_name.to_s].nil?
          if (build_targets[target_name.to_s]["includes"] || []).include?(build_target.to_s)
            return true
          end
        end
        return false
      end
    end
    alias :target? :build_target_is?

    def default_target?
      build_target == DEFAULT_BUILD_TARGET
    end
    alias :no_target? :default_target?
  end
end
