$LOAD_PATH.unshift File.expand_path("../../../lib", __FILE__)
require "propertybase_id"

time = 20
stop_it = Time.now.to_i + time
thread_number = 4
threads = []

arrays = thread_number.times.map { [] }

arrays.each do |a|
  threads << Thread.new do
    while(Time.now.to_i < stop_it) do
      a << PropertybaseId.generate(object: "team")
    end
  end
end

threads.each(&:join)

arrays.each do |a|
  puts a.first.to_s
end

arrays.flatten!

size = arrays.size
uniq = arrays.uniq.size

puts "total  : #{size}"
puts "uniques: #{uniq}"

if uniq == size
  puts "No conflicts"
else
  puts "Created conflicting elements"
end
