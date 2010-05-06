class StockBot
  def initialize(server, port, channel)
    @channel = channel
    @socket = TCPSocket.open(server, port)
    say "NICK StockBot"
    say "USER stockbot 0 * StockBot"
    say "JOIN ##{@channel}"

    Dir['modules/*'].each { |object| require object }
  end

  def say(msg)
    puts msg unless msg =~ /^(P.NG)/
    @socket.puts msg
    sleep 2 # flood control
  end

  def say_to_chan(msg)
    say "PRIVMSG ##{@channel} :#{msg.gsub("\x93", '"').gsub("\x94", '"')}" rescue nil
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      puts msg unless msg =~ /^(P.NG)/

      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end

      if msg.match(/PRIVMSG ##{@channel} :(.*)$/)
        content = $~[1]

        if respond_to? 'title', true
          if content.match(/((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?(\/[\w\-\=\?\d\%]+)?)/ix)
            url = $1
            unless content.match(/^(\.|\!)title/)
              title url rescue nil
            end
          end
        end

        begin
          if content.match(/^(\.|\!)(\w+)(\ )?(.*)/)
            method = $2.to_s
            args   = $4.to_s.strip.gsub(/'/, "\\\\'")

            if respond_to?(method, true)
              send(method, args.split(' ').push(msg.match(/\:([^\!]+)\!/)[1]))
            end
          end
        rescue
          puts $!
          say_to_chan "Invalid request."
        end
      end
    end
  end

  def quit
    say "PART ##{@channel} :lolwat"
    say 'QUIT'
  end
end
