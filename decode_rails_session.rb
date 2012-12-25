#!/usr/bin/env ruby
require 'rails'
puts Marshal.load Base64.decode64(ARGV.first || "")
