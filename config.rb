require 'rubygems'
require 'socket'
require 'rest_client'
require 'hpricot'
require 'sanitize'
require 'cgi'
require 'net/http'
require 'pony'
require 'sequel'

Dir['classes/*'].each { |object| require object }
DB = Sequel.sqlite('stockbot.db')
