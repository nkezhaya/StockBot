#!/usr/bin/env ruby

require 'config'

bot = StockBot.new("irc.freenode.net", 6667, 'stocktest')
bot.run
