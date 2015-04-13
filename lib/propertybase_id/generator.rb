require "digest/sha1"
require "socket"

class PropertybaseId
  class Generator
    def initialize
      @counter = 0
      @mutex = Mutex.new
    end

    def generate(object: )
      @mutex.synchronize do
        PropertybaseId.new(
          object_id: pb_object_id(object),
          host_id: host_id,
          time: ::Time.now.to_i,
          process_id: process_id,
          counter: next_counter
        )
      end
    end

    private

    def pb_object_id(object)
      PropertybaseId::Mappings.objects.fetch(object.to_s) do
        raise ArgumentError, "Object #{object.inspect} not found"
      end
    end

    def host_id
      @_host_id ||= Digest::SHA1.hexdigest(Socket.gethostname).to_i(16) % PropertybaseId.max_value(2)
    end

    def next_counter
      @counter = (@counter + 1) % PropertybaseId.max_value(5)
    end

    def process_id
      "#{Process.pid}#{Thread.current.object_id}".hash % PropertybaseId.max_value(2)
    end
  end
end
