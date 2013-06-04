require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name = "middleman-target"
  s.version = "0.0.5"
  s.date = %q{2013-02-04}
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
  s.add_dependency("middleman", ">= 3.0", "< 3.2")

  s.add_development_dependency('cucumber', "~> 1.1.0")
  s.add_development_dependency("aruba", "~> 0.4.11")
  s.add_development_dependency('rspec', '~> 2.12.0')
end
