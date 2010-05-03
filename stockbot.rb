#!/usr/bin/env ruby

require 'config'

URL       = /((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?(\/[\w\-\=\?\d\%]+)?)/ix
OPERATORS = /\+\-\*\/\!\^\(\)/
STANDARDS = /\d\.\w\s\@/i

class StockBot
  def initialize(server, port, channel)
    include_classes_and_modules

    @channel = channel
    @socket = TCPSocket.open(server, port)
    say "NICK StockBot"
    say "USER stockbot 0 * StockBot"
    say "JOIN ##{@channel}"
    say_to_chan "WASSUP WID IT"
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

        if @modules.include? 'title'
          if content.match(/#{URL}/)
            url = $1
            title url unless content.match(/^(\.|\!)title/)
          end
        end

        begin
          if content.match(/^(\.|\!)(\w+)(\ )?([#{OPERATORS}#{STANDARDS}]+)/)
            call = "send('#{$2}'.to_sym, "; mtd = $2
            call += " \"#{$4.strip}\".split(' ')" unless $4 == nil
            call += ".push('#{msg.match(/\:([^\!]+)\!/)[1].gsub('\'', '\\\'')}'))"
            eval(call) if @modules.include?(mtd) or respond_to?(mtd, true)
          end
        rescue
          say_to_chan "Invalid request."
        end
      end
    end
  end

  def quit
    say "PART ##{@channel} :lolwat"
    say 'QUIT'
  end

  private
  def include_classes_and_modules
    @modules = []
    Dir['classes/*'].each { |object| require object }
    Dir['modules/*'].each { |object| require object; @modules << object.to_s.gsub('.rb', '').gsub('modules/', '') }
  end
end

bot = StockBot.new("irc.freenode.net", 6667, 'stock')
bot.run
