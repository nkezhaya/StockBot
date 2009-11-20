#!/usr/bin/env ruby

require 'rubygems'
require 'socket'
require 'rest_client'
require 'hpricot'
require 'sanitize'
require 'cgi'
require 'net/http'

class StockBot
  def initialize(server, port, channel)
    include_classes_and_modules

    @channel = channel
    @socket = TCPSocket.open(server, port)
    say "NICK StockBot"
    say "USER stockbot 0 * StockBot"
    say "JOIN ##{@channel}"
    say_to_chan "#{1.chr}ACTION is here to help#{1.chr}"
  end

  def say(msg)
    puts msg
    @socket.puts msg
  end

  def say_to_chan(msg)
    say "PRIVMSG ##{@channel} :#{msg.gsub("\x93", '"').gsub("\x94", '"')}" rescue nil
    sleep 2 # flood control
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      puts msg

      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end

      if msg.match(/PRIVMSG ##{@channel} :(.*)$/)
        content = $~[1]

        begin
          if content.match(/^\!(\w+)(\ )?([\w|\s]*)/)
            call = $1
            call += "\"#{$3}\".split(' ')" unless $3 == nil
            eval(call) if @modules.include? $1
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
trap("INT"){ bot.quit }
bot.run
