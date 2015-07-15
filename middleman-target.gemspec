require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name = "middleman-target"
  s.version = "0.0.8"
  s.author = "Matthew Nielsen"
  s.email = "xunker@pyxidis.org"
  s.homepage = "https://github.com/xunker/middleman-target"
  s.summary = "Build a middleman project for multiple platforms using the same codebase"
  s.description = "Allows you to build a middleman project for multiple platforms using the same codebase. Useful for creating PhoneGap/Cordova apps that target multiple OSes while using same source tree."
  s.license = 'MIT'
  s.files = `git ls-files`.split($/).reject{|fn| fn =~ /^\.ruby\-/}

  s.has_rdoc = false

  s.add_dependency("middleman", ">= 3.0")

  s.add_development_dependency('rake', '~> 0')
  s.add_development_dependency('cucumber', '~> 2.0')
  s.add_development_dependency('aruba', '~> 0.8')
  s.add_development_dependency('rspec', '~> 3.0')

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

    highest_tested_version = Gem::Version.new("3.3.12")

    if (current_middleman_version > highest_tested_version)
      s.post_install_message = <<EOF
Notice: This version of middleman-target has only been tested with
        middleman #{highest_tested_version}, you are using #{current_middleman_version}. It will probably
        work just fine, but if it doesn't please file an issue on the
        Github page: https://github.com/xunker/middleman-target/issues

EOF

    end
  end

end
