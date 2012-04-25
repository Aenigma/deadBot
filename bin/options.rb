#!/usr/bin/ruby
require 'optparse'
options ={}
OptionParser.new do |opts|
	opts.banner = "Usage: deadbot [options]"
	opts.on("-d","--[no-]debug","Output debug messages to STDOUT") do |o|
		options[:debug] = o
	end
end.parse!
p options
p ARGV
