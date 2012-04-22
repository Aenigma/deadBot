#!/usr/bin/ruby
require 'yaml'
require 'pp'
if !File.exists?("../config.yaml")
	yaml = YAML.dump([
		{
			:opts => {
				:user => "testing 0 * Testing",
				:channel => [ "#deadsnowman","#deadsnowman2" ]
				},
			:nick=>"deadBot",
			:port => "6700",
			:server => "irc.rizon.net"
		},
		{
			:server => "irc.rizon.net",
			:port => "6700",
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

print yaml
data = YAML.load(yaml)
print "loaded YAML file.. this is the ruby internals\n"
pp data
