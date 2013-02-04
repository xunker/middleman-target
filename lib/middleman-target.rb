require "middleman-core"

::Middleman::Extensions.register(:target) do
  require "middleman-target/extension"
  ::Middleman::Target
end