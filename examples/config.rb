require '../lib/target'
activate :target

set_build_targets({
  :phonegap => {
    :includes => [:android, :ios]
  }
})

disable :layout

configure :build do

end