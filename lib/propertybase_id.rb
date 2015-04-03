require "propertybase_id/version"
require "propertybase_id/generator"
require "propertybase_id/mappings"

class PropertybaseId
  attr_reader :object_id
  attr_reader :host_id
  attr_reader :time
  attr_reader :process_id
  attr_reader :counter

  def initialize(object_id:, host_id:, time:, process_id:, counter:)
    @object_id = object_id
    @host_id = host_id
    @time = time
    @process_id = process_id
    @counter = counter
  end

  def object
    @_object ||= self.class.team_from_object_id(@object_id || "")
  end

  def to_s
    @_string ||= begin
      object_str = format_number(@object_id, 3)
      host_str = format_number(@host_id, 2)
      time_str = format_number(@time, 6)
      process_str = format_number(@process_id, 2)
      counter_str = format_number(@counter, 5)

      "#{object_str}#{host_str}#{time_str}#{process_str}#{counter_str}"
    end
  end

  def ==(o)
    self.class == o.class &&
    self.object_id == o.object_id &&
    self.host_id == o.host_id &&
    self.process_id == o.process_id &&
    self.time == o.time &&
    self.counter == o.counter
  end

  alias_method :eql?, :==

  def hash
    [
      object_id,
      host_id,
      time,
      process_id,
      counter,
    ].hash
  end

  def self.generate(object:)
    @@generator.generate(object: object)
  end

  def self.parse(input_id)
    raise ArgumentError, "invalid length (#{input_id.size})" if input_id.size != max_length

    _, object_id, host_id, time, process_id, counter = input_id.match(/(\w{3})(\w{2})(\w{6})(\w{2})(\w{5})/).to_a

    team_from_object_id(object_id.to_i(36))

    new(
      object_id: object_id.to_i(36),
      host_id: host_id.to_i(36),
      time: time.to_i(36),
      process_id: process_id.to_i(36),
      counter: counter.to_i(36),
    )
  end

  def self.max_length
    18
  end

  def self.max_value(digits = max_length)
    ("zz" * digits).to_i(36)
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
