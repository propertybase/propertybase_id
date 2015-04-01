$LOAD_PATH.unshift File.expand_path("../../../lib", __FILE__)
require "propertybase_id"

module Conflicts
  extend self

  def run(time: 2, threads: 1)
    thread_objects = []
    stop_it = Time.now.to_i + time
    arrays = threads.times.map { [] }

    arrays.each do |a|
      thread_objects << Thread.new do
        while(Time.now.to_i < stop_it) do
          a << PropertybaseId.generate(object: "team")
        end
      end
    end

    thread_objects.each(&:join)

    process_ids = arrays.map(&:first).map(&:process_id)

    puts "Process IDs: #{process_ids.inspect} (unique: #{process_ids.uniq.size})"

    arrays.flatten!

    arrays_unique = arrays.uniq

    size = arrays.size
    uniq = arrays_unique.size

    puts "total : #{size}"
    puts "unique: #{uniq}"

    if uniq == size
      puts "No conflicts"
      puts "====="
      0
    else
      puts "Created conflicting elements:"
      puts "Conflicts: #{(arrays.find_all{ |e| arrays.count(e) > 1 }).inspect}"
      puts "====="
      -1
    end
  end
end
