require "json"

class PropertybaseId
  module Mappings
    extend self

    def objects
      @_objects ||= begin
        load_json_file("objects")
      end
    end

    private

    def load_json_file(name)
      JSON.parse(File.read(File.expand_path('../data/objects.json', __FILE__)))
    end
  end
end
