module Middleman
  module Target

    # Options class copied from
    # https://github.com/middleman/middleman-blog/blob/master/lib/middleman-blog/extension.rb
    class Options
      KEYS = [ :build_targets ]

      KEYS.each do |name|
        attr_accessor name
      end

      def initialize(options={})
        options.each do |k,v|
          self.send(:"#{k}=", v)
        end
      end
    end

    class << self
      def registered(app, options_hash={}, &block)
        # app.set :build_targets, {}
        app.helpers HelperMethods

        options = Options.new(options_hash)
        yield options if block_given?

        if options.build_targets
          raise "#build_targets must be a hash" unless options.build_targets.class == Hash
          app.set :build_target_definitions, options.build_targets
        else
          app.set :build_target_definitions, {}
        end
      end
      alias :included :registered
    end

    module HelperMethods
      DEFAULT_BUILD_TARGET = :default

      def build_targets
        @build_target ||= build_target_definitions
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
          build_target == target_name
        else
          if !build_targets[target_name.to_s].nil?
            if (build_targets[target_name.to_s][:includes] || []).include?(build_target.to_s)
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
end