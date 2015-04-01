$LOAD_PATH.unshift File.expand_path("../../../lib", __FILE__)
require "propertybase_id"

time = 10
stop_it = Time.now.to_i + time

a = []
while(Time.now.to_i < stop_it) do
  a << PropertybaseId.generate(object: "team")
end

size = a.size
uniq = a.uniq.size

puts "total  : #{size}"
puts "uniques: #{uniq}"

if uniq == size
  puts "No conflicts"
else
  puts "Created conflicting elements"
end
