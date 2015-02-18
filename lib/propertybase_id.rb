require "propertybase_id/version"
require "propertybase_id/local_random"
require "propertybase_id/mappings"

class PropertybaseId
  attr_reader :object
  attr_reader :server
  attr_reader :local_random

  def initialize(object, server, local_random)
    @object = object && object.dup.freeze
    @server = server
    @local_random = local_random
    validate!
  end

  def to_s
    @_string ||= begin
      object_str = format_number(@_object_id, 2)
      server_str = format_number(server, 2)
      local_random_str = format_number(local_random, 12)

      "#{object_str}#{server_str}#{local_random_str}"
    end
  end


  def self.create(opts)
    new(opts.fetch(:object), opts.fetch(:server), generate_local_random)
  end

  def self.parse(input_id)
    _, object_id, server_id, local_random = input_id.match(/(\w{2})(\w{2})(\w{12})/).to_a

    object, _ = PropertybaseId::Mappings.objects.select{|_, v| v == object_id.to_i(36) }.first
    new(object, server_id.to_i(36), local_random.to_i(36))
  end

  private

  def validate!
    @_object_id ||= PropertybaseId::Mappings.objects.fetch(object) do
      raise ArgumentError, "Object #{object.inspect} not found"
    end
  end

  def self.generate_local_random
    PropertybaseId::LocalRandom.new.to_i
  end

  def format_number(integer, length)
    integer.to_s(36).rjust(length, "0")
  end
end
