require "digest/sha1"
require "socket"
require "securerandom"

class PropertybaseId
  class Generator
    def generate(object: )
      PropertybaseId.new(
        object_id: pb_object_id(object),
        time: ::Time.now.to_i,
        random_int: random_32
      )
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

    def random_32
      SecureRandom::random_number("zzzzzz".to_i(36) + 1)
    end

    def next_counter
      @counter = (@counter + 1) % PropertybaseId.max_value(5)
    end

    def process_id
      "#{Process.pid}#{Thread.current.object_id}".hash % PropertybaseId.max_value(2)
    end
  end
end
