#!/usr/bin/env ruby

require 'rubygems'
require 'socket'
require 'rest_client'
require 'hpricot'
require 'sanitize'
require 'cgi'
require 'net/http'
require 'pony'

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

        begin
          if content.match(/^\!(\w+)(\ )?(.*)/)
            call = $1
            call += " \"#{$3.strip}\".split(' ').uniq" unless $3 == nil
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
