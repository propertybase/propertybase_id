class PropertybaseId
  class LocalRandom
    MAX_INTEGER = 10000
    TIME_MULTIPLIER = 10000

    attr_reader :time

    def initialize(time=Time.now)
      @time = time
    end

    def to_i
      @_integer ||= begin
        rand_int = SecureRandom.random_number(MAX_INTEGER)
        max_digits = (MAX_INTEGER - 1).to_s.size
        prefix = "%0#{max_digits}d" % rand_int
        time_with_miliseconds = (time.to_f * TIME_MULTIPLIER).to_i

        "#{prefix}#{time_with_miliseconds}".to_i
      end
    end
  end
end
