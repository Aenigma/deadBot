#!/usr/bin/ruby
require 'socket'
require 'yaml'
class IRC
	def initialize(server,port,nick,opts={})
		@read,@write = IO.pipe
		@server,@port,@nick=server,port,nick
		@opts = {
			:user => "testing 0 * Testing",
			:channel => [],
			}.merge!(opts)
		serverconnect()
		pinghandler()
	end

	def serverconnect()
		@socket = TCPSocket.open(@server,@port)
		@socket.puts "USER testing 0 * Testing"
		@socket.puts "NICK #{@nick}"
		
		p "#{@opts[:channel]}"
		@opts[:channel].each do |chan|
			@socket.puts "JOIN #{chan}"
			print "\n\n\n\njoined #{chan}\n\n\n\n"
		end
	end

	def pinghandler()
		fork do
			until @socket.eof? do
				msg = @socket.gets
				if msg.match(/^PING :(.*)$/)
					@socket.puts("PONG #{$~[1]}")
				else
					@write.puts(msg)
				end
			end
			@socket.puts("QUIT")
		end
	end

	def read
		return @read
	end
end
=begin
until s.eof? do
  msg = s.gets
  puts msg

  #respond to ping
  if msg.match('/^PING :(.*)$/')
    s.puts "PONG #{$~[1]}"
    next
  end

  #respod to "test"  Responds multiple times on entry for some reason
  if msg.downcase.match("test")
    s.puts "PRIVMSG #{channel} :worked"
  end

  #part and quit on responce
  #if msg.downcase.match(nick + ": go away")
  if msg.downcase.match("deadbot: go away")
    s.puts "PART #{channel}"
    s.puts "QUIT"
  end

end
=end
