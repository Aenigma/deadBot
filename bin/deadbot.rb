#! /usr/bin/ruby
require '../lib/deadlib'
if !File.exists?("../config.yaml")
	yaml = YAML.dump([
		{
			:opts => {
				:user => "testing 0 * Testing",
				:channel => [ "#deadsnowman","#deadsnowman2" ]
				},
			:nick=>"deadBot",
			:port => "6667",
			:server => "irc.rizon.net"
		},
		{
			:server => "irc.rizon.net",
			:port => "6667",
			:nick => "aenigmabot",
			:opts => {
				:user => "testing 0 * Testing",
				:channel => ["#deadsnowman" ]
				}
		}
		])
	File.open("../config.yaml","w") do |f|
		f << yaml 
	end
else
	File.open("../config.yaml","r") do |f|
		yaml = f.read
	end
end

data = YAML.load(yaml)
irclist = Array.new()
data.each do |hash|
	irclist << IRC.new(hash[:server],hash[:port],hash[:nick],hash[:opts])
end

irclist.each do |irc|
	fork do
		until irc.read.eof?
			File.open("irc.log","a") do |f|
				f << irc.read.gets
			end
		end
	end
end

until STDIN.getc == nil
end

irclist.each do |irc|
	irc.close
end


=begin
Infinite loop now. but this part should contain code for a basic shell to
allow using the bot as a client for manual commands such as to shut down
and start more clients.
=end
