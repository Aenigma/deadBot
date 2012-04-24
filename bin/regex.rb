#! /usr/bin/ruby
nick = "rubybot"
File.open("./irc.log","r") do |f|
	if (f.read =~ /^:#{nick}.* MODE #{nick} :(\+[a-z]*)/)
		puts "match found"
	else
		puts "naw"
	end
end
p $~
