#!/usr/bin/env ruby
require 'rails'
require 'ap'
decoded = Base64.decode64(ARGV.first || "")
begin
  decoded = Marshal.load(decoded)
rescue ArgumentError
end
ap decoded
