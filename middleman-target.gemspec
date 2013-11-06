require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name = "middleman-target"
  s.version = "0.0.6"
  s.author = "Matthew Nielsen"
  s.email = "xunker@pyxidis.org"
  s.homepage = "https://github.com/xunker/middleman-target"
  s.summary = "Ability to specify build targets for Middleman projects"
  s.description = "Allows you specify different targets for a middleman build so you can build different versions of a site from the same source tree."
  s.files = [
    "README.md",
    "examples/config.rb", "examples/source/index.html.erb",
    "lib/middleman-target/extension.rb",
    "lib/middleman-target.rb",
    "lib/middleman_extension.rb",

    "fixtures/build_target/config.rb",
    "fixtures/build_target/source/build_target.html.erb",

    "fixtures/build_target_default/config.rb",
    "fixtures/build_target_default/source/build_target_default.html.erb",

    "fixtures/build_target_includes/config.rb",
    "fixtures/build_target_includes/source/build_target_includes.html.erb",

    "fixtures/build_targets/config.rb",
    "fixtures/build_targets/source/build_targets.html.erb",

    "features/support/env.rb",
    "features/target.feature"

  ]
  s.has_rdoc = false
  
  s.add_dependency("middleman", ">= 3.0")

  if (RUBY_ENGINE.to_s == "rbx" && RUBY_VERSION >= "2.1.0")
    # for rbx-19mode, needed for the Gem::Specification.detect call below.
    s.add_dependency('rubysl') 
  end

  s.add_development_dependency('rake', '~>10.0.4')
  s.add_development_dependency('cucumber', "~> 1.1.0")
  s.add_development_dependency("aruba", "~> 0.4.11")
  s.add_development_dependency('rspec', '~> 2.12.0')
  # s.add_development_dependency('debugger')

  # Check for the current installed version of middleman.
  # We'll let this work with anything greater than 3.0, but
  # show the user a warning if the version is greater than
  # highest_tested_version.
  
  current_middleman_version = begin
    Gem::Specification.detect{|g|g.name=='middleman'}.version
  rescue NoMethodError
    nil
  end

  # if current_middleman_version is nil it's because we're doing a
  # bundle install or some such and we should let it go.
  if current_middleman_version

    highest_tested_version = Gem::Version.new("3.2.0")

    if (current_middleman_version > highest_tested_version)
      s.post_install_message = <<EOF
Notice: This version of middleman-target has only been tested with
        middleman 3.2.0 and lower, you are using #{current_middleman_version}. It will probably
        work just fine, but if it doesn't please file an issue on the
        Github page at https://github.com/xunker/middleman-target

EOF

    end
  end
  
end
