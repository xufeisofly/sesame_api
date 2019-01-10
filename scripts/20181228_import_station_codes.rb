# frozen_string_literal: true

stations = YAML.safe_load(File.read('./stations.yml')).inject(:merge)

stations.each do |k, v|
  City.create(name: k, code: v)
  puts k, v
end
