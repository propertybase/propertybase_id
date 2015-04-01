require File.expand_path("./shared.rb", __dir__)

ret_val = 0
counter = 0

while(ret_val == 0) do
  counter += 1
  puts "Run: #{counter}"
  ret_val = Conflicts.run(threads: 8, time: 1)
end
