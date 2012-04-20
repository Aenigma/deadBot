#!/usr/bin/ruby
def silly
	read, write = IO.pipe
	fork do
		until STDIN.eof? do
			line = STDIN.gets	
			if line == "poop\n"
				write.puts("HAHA YOU SAID POOP")
			else
				write.puts(line)
			end
		end
	end
	return read
end
rp = silly
until rp.eof? do
	print rp.gets
end
