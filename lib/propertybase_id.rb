require "propertybase_id/version"
require "propertybase_id/generator"
require "propertybase_id/mappings"

class PropertybaseId
  attr_reader :object_id
  attr_reader :time
  attr_reader :random_int

  def initialize(object_id:, time:, random_int:)
    @object_id = object_id
    @time = time
    @random_int = random_int
  end

  def object
    @_object ||= self.class.team_from_object_id(@object_id || "")
  end

  def to_s
    @_string ||= begin
      object_str = format_number(@object_id, 2)
      time_str = format_number(@time, 7)
      random_str = format_number(@random_int, 6)

      "#{object_str}#{time_str}#{random_str}"
    end
  end

  def ==(o)
    self.class == o.class &&
    self.object_id == o.object_id &&
    self.time == o.time &&
    self.random_int == o.random_int
  end

  alias_method :eql?, :==

  def hash
    [
      object_id,
      time,
      random_int,
    ].hash
  end

  def self.generate(object:)
    @@generator.generate(object: object)
  end

  def self.parse(input_id)
    raise ArgumentError, "invalid length (#{input_id.size})" if input_id.size != max_length

    _, object_id, time, random_str = input_id.match(/(\w{2})(\w{7})(\w{6})/).to_a

    team_from_object_id(object_id.to_i(36))

    new(
      object_id: object_id.to_i(36),
      time: time.to_i(36),
      random_int: random_str.to_i(36),
    )
  end

  def self.max_length
    15
  end

  def self.max_value(digits = max_length)
    ("z" * digits).to_i(36)
  end

  private

  def format_number(integer, length)
    integer.to_s(36).rjust(length, "0")
  end

  def self.team_from_object_id(input_id)
    obj, _ = PropertybaseId::Mappings.objects.select{|_, v| v == input_id }.first
    raise ArgumentError, "No object to id #{input_id.to_s(36)}" if obj.nil?
    obj
  end

  @@generator = PropertybaseId::Generator.new
end
