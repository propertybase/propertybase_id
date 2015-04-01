require "digest/sha1"
require "socket"

class PropertybaseId
  class Generator
    def initialize
      @counter = 0
      @mutex = Mutex.new
    end

    def generate(object: )
      @mutex.lock
      begin
        count = next_counter
      ensure
        @mutex.unlock rescue nil
      end

      PropertybaseId.new(
        object_id: pb_object_id(object),
        host_id: host_id,
        time: time,
        process_id: process_id,
        counter: count
      )
    end

    private

    def pb_object_id(object)
      PropertybaseId::Mappings.objects.fetch(object) do
        raise ArgumentError, "Object #{object.inspect} not found"
      end
    end

    def time
      @_time ||= ::Time.now.to_i
    end

    def host_id
      @_host_id ||= Digest::SHA1.hexdigest(Socket.gethostname).to_i(16) % max_value(2)
    end

    def next_counter
      @counter = (@counter + 1) % max_value(5)
    end

    def process_id
      "#{Process.pid}#{Thread.current.object_id}".hash % max_value(2)
    end

    def max_value(digits)
      ("z" * digits).to_i(36) + 1
    end
  end
end
