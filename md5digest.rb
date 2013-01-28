#!/usr/bin/env ruby
require 'digest'
str = ARGV.first || $stdin.read.chomp
puts "MD5 hexdigest of #{str.inspect} is ", Digest::MD5.hexdigest(str)
