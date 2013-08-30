#! /usr/bin/ruby
require './lib/deadlib'
require 'yaml'
if !File.exists?("./config.yaml")
	puts "No config found; installing default config file."
	yaml = YAML.dump([
		{
			:opts => {
				:channel => [ "#deadsnowman","#deadsnowman2" ]
				},
			:nick=>"deadBotTest",
			:port => "6667",
			:server => "irc.rizon.net"
		},
		{
			:server => "irc.rizon.net",
			:port => "6667",
			:nick => "aenigmaBotTest",
			:opts => {
				:channel => ["#deadsnowman" ]
				}
		}
		])
	File.open("./config.yaml","w") do |f|
		f << yaml 
	end
else
	File.open("./config.yaml","r") do |f|
		yaml = f.read
	end
end

data = YAML.load(yaml)
irclist = Array.new()
data.each do |hash|
	irclist << IRC::DeadBot.new(hash[:server],hash[:port],hash[:nick],hash[:opts])
end

until STDIN.gets.chomp == "exit"
	puts "invalid command: #{$_}"
end

puts "got exit..."

irclist.each do |irc|
	irc.close
	irc.join
end
