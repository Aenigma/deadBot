#!/usr/bin/ruby
require 'socket'
require 'logger'
module IRC
	@@logger = Logger.new("deadbot.log")
	
	def self.logger
		@@logger
	end

	class DeadBot
		THREAD_JOIN_WAIT = 5
		RECONNECT_DELAY = 20
		attr_accessor :thread
		def initialize(server,port,nick,opts={})
			@thread = nil
			@server,@port,@nick=server,port,nick
			@opts = {
				:user => "#{@nick} 0 * #{@nick}",
				:channel => [],
				:logfile => self.to_s + ".log"
				}.merge!(opts)
			serverconnect()
			handler()
		end

		def serverconnect()
			@socket = TCPSocket.open(@server,@port)
			write "USER #{@opts[:user]}"
			write "NICK #{@nick}"

			@opts[:channel].each do |chan|
				write "JOIN #{chan}"
				IRC::logger.info "#{self.to_s} joined #{chan}"
			end
		end

		def handler()
			@thread = Thread.new do
				while msg = self.read
					if msg.chomp.match(/^PING :(.*)$/)
						write "PONG #{$~[1]}"
						IRC::logger.debug "#{self.to_s} responded to PING with #{$~[0]}"
					elsif msg.chomp.match /^ERROR :Trying to reconnect too fast\.$/
						IRC::logger.info "#{self.to_s} got error: #{$~[0]}"
						self.close
						Thread.new do
							IRC::logger.debug "#{self.to_s} waiting to reconnect..."
							self.join
							sleep RECONNECT_DELAY
							IRC::logger.debug "#{self.to_s} trying to reconnect..."
							self.serverconnect
							self.handler
							IRC::logger.info "#{self.to_s} has reconnected"
						end
					else
						File.open(@opts[:logfile],"a") do |f|
							f.puts msg.chomp
						end
					end
				end
				closesocket
			end
		end
		
		def closesocket
			IRC::logger.debug "attempting to close #{self.to_s}..."
			IRC::logger.debug "closing #{self.to_s}..."
			@socket.close
			IRC::logger.debug "finished closing #{self.to_s}"
		end
		
		def read
			begin
				@socket.gets
			rescue Exception => e
				IRC::logger.error "#{self.to_s} has gotten an exception: #{e.to_s}#{e.backtrace}"
			end
		end
		
		def write(obj)
			begin
				@socket.puts obj.to_str
			rescue Exception => e
				IRC::logger.error "#{self.to_s} has gotten an exception: #{e.to_s}#{e.backtrace}"
			end
		end
		
		def close
			IRC::logger.debug "#{self.to_s} close method called..."
			begin
				write "PART #{@opts[:channel].join(",")}"
				write "QUIT"
			rescue
				IRC::logger.error "#{self.to_s} has gotten an exception: #{e.to_s}#{e.backtrace}"
			end
			IRC::logger.info "#{self.to_s} has parted and quit."
		end
		
		def join
			IRC::logger.debug "#{@self.to_s} waiting for thread to finish..."
			@thread.join THREAD_JOIN_WAIT
			if @thread.alive?
				IRC::logger.info "#{@self.to_s} thread is finished."
			else
				IRC::logger.warn "#{@self.to_s} thread timed out to finish..."
				@thread.kill
				IRC::logger.warn "#{@self.to_s} thread was killed"
			end
		end

		def to_s
			"#{@nick}@#{@server}"
		end
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
