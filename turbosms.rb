#!/usr/bin/env ruby
unless ARGV.first
  puts "Usage: ruby #{$0} money_in [my_commission] [money_sms]"
  exit 1
end
money_in = ARGV.first.to_f
money_sms = (ARGV[2] || 0.16).to_f
webmoney_commission = 0.8 / 100
my_commission = (ARGV[1] || 2.0).to_f / 100
turbosms = ((money_in * (1.0 - my_commission)) / ((1.0 +  webmoney_commission) * money_sms)).to_i
webmonwy_payment = money_sms * turbosms
benefit = money_in - ( webmonwy_payment * (1.0 + webmoney_commission))
turbosms_without_my = (money_in / ((1.0 +  webmoney_commission) * money_sms)).to_i
key_format = "%-20s"
puts "#{key_format}: %.4f" % ["Money Input", money_in]
puts "#{key_format}: %i" % ["TurboSMS", turbosms]
puts "#{key_format}: %i" % ["TurboSMS lost", (turbosms_without_my - turbosms)]
puts "#{key_format}: %.4f (%.3f%%)" % ["Webmoney benefit", webmoney_commission * webmonwy_payment, webmoney_commission * 100]
puts "#{key_format}: %.4f (%.3f%%)" % ["My benefit", benefit, benefit * 100 / money_in]
