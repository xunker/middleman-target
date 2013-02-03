require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name = "middleman-target"
  s.version = "0.0.1"
  s.date = %q{2012-04-12}
  s.author = "Matthew Nielsen"
  s.email = "xunker@pyxidis.org"
  s.homepage = "https://github.com/xunker/middleman-target"
  s.summary = "Ability to specify build targets for Middleman projects"
  s.description = "Allows you specify different targets for a middleman build so you can build different versions of a site from the same source tree."
  s.files = [
    "README.md",
    "examples/config.rb", "examples/source/index.html.erb",
    "lib/middleman-target.rb",
    "spec/spec.opts", "spec/spec_helper.rb", "spec/lib/middleman-target_spec.rb"
  ]
  s.has_rdoc = false
  s.add_dependency("middleman", "~> 3.0.11")
  s.add_development_dependency('rspec', '~> 2.9.0')
end
