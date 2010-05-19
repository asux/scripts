#!/usr/bin/ruby -w
length = 8
if ARGV.count > 0 then
    length = ARGV[0].to_i
end
x = []
length.times do |i|
   x << rand(16).to_s(16)
end
puts x.join("")
