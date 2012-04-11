require '../lib/target'
activate :target

build_targets({
  :phonegap => {
    :includes => [:android, :ios]
  }
})


disable :layout

configure :build do

end