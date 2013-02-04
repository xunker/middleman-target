activate :target do |target|

  target.build_targets = {
    "phonegap" => {
      :includes => %w[android ios]
    }
  }

end