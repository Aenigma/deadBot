#!/usr/bin/ruby
# dummy program to get shell options sorted out
require 'optparse'
options ={}
OptionParser.new do |opts|
	opts.banner = "Usage: deadbot [options]"
	opts.on("-d","--[no-]verbose","Output debug messages to STDOUT") do |o|
		options[:verbose] = o
	end
	opts.on("-c","--config FILE","Uses a separate YAML file in place of ./config.yaml") do |o|
		options[:config] = o
	end
end.parse!
p options
p ARGV
