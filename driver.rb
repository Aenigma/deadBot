#! /usr/bin/ruby
require 'deadbot'
ircclass = IRC.new("irc.rizon.net","6667","deadbot2",{:channel => ["#deadsnowman"]})
until ircclass.read.eof?
	print ircclass.read.gets
end
