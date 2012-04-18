#!/usr/bin/ruby

require "socket"

server = "irc.rizon.net"
port = "6667"
nick = "deadBot"
channel = "#deadSnowman"

s = TCPSocket.open(server, port)
s.puts "USER testing 0 * Testing"
s.puts "NICK #{nick}"
s.puts "JOIN #{channel}"
s.puts "PRIVMSG #{channel} :Hello from deadBot"

until s.eof? do
  msg = s.gets
  puts msg

  #respond to ping
  if msg.match(/^PING :(.*)$/)
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

