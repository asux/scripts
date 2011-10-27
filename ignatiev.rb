#!/usr/bin/env ruby
require 'optparse'
require 'ostruct'
require 'forwardable'

class Ignatiev
  extend Forwardable

  def_delegators :@options, :money_in, :sms_cost, :my_commission, :webmoney_commission, :antigate

  def self.usage(opts)
    puts opts.banner
    puts "Options:"
    puts opts.summarize
    exit 1
  end

  def self.parse(args)
    options = OpenStruct.new

    options.money_in = args.shift.to_f
    options.sms_cost = 0.16
    options.webmoney_commission = 0.8 / 100
    options.my_commission = 2.5 / 100
    options.antigate = 0.0

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} money_in [--sms-cost=float] [--my-commission=float] [--antigate=float]"

      opts.on('--sms-cost=SMS_COST', Float, "Cost of SMS") do |value|
        options.sms_cost = value
      end

      opts.on('--my-commission=MY_COMISSION', Float, "My commission") do |value|
        options.my_commission = value
      end

      opts.on('--antigate=ANTIGATE', Float, "Antigate payment") do |value|
        options.antigate = value
      end
    end # opts

    usage(opts) if options.money_in == 0.0

    opts.parse!(args)
    instance = new(options, opts)
  end # parse

  def initialize(options, opts)
    @options, @opts = options, opts
  end

  def key_format
    "%-28s"
  end

  def turbosms_money
    money_in - antigate
  end

  def turbosms_money_with_benefit
    turbosms_money * (1.0 - my_commission)
  end

  def turbosms
    (turbosms_money_with_benefit / ((1.0 +  webmoney_commission) * sms_cost)).to_i
  end

  def turbosms_without_my
    (turbosms_money / ((1.0 +  webmoney_commission) * sms_cost)).to_i
  end

  def webmoney_payment
    sms_cost * turbosms
  end

  def benefit
    turbosms_money - ( webmoney_payment * (1.0 + webmoney_commission))
  end

  def print
    puts "#{key_format}: %.2f" % ["Money Input", money_in]
    puts "#{key_format}: %.2f" % ["Antigate payment", antigate]
    puts "#{key_format}: %.2f" % ["TurboSMS money", turbosms_money]
    puts "#{key_format}: %.2f" % ["TurboSMS money w/ benefit", turbosms_money_with_benefit]
    puts "#{key_format}: %.2f" % ["SMS cost", sms_cost]
    puts "#{key_format}: %i" % ["TurboSMS count", turbosms]
    puts "#{key_format}: %i" % ["TurboSMS lost", (turbosms_without_my - turbosms)]
    puts "#{key_format}: %.2f (%.2f%%)" % ["Webmoney benefit", webmoney_commission * webmoney_payment, webmoney_commission * 100]
    puts "#{key_format}: %.2f (%.2f%%)" % ["My benefit", benefit, benefit * 100 / turbosms_money]
  end

end # class

ignatiev = Ignatiev.parse(ARGV)
ignatiev.print
