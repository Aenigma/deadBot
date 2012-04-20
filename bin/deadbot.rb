#! /usr/bin/ruby
require '../lib/deadlib'
ircclass = IRC.new("irc.rizon.net","6667","deadbot2",{:channel => ["#deadsnowman"]})
until ircclass.read.eof?
	print ircclass.read.gets
end
