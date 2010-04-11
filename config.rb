require 'rubygems'
require 'socket'
require 'rest_client'
require 'hpricot'
require 'sanitize'
require 'cgi'
require 'net/http'
require 'pony'

$users = {
  'zarathu'     => {
    :w          => '75209',
    :sms        => '9727435255'
  },

  'skalnik'     => {
    :w          => '30332',
    :sms        => '9722682292'
  },

  'sneakyness'  => {
    :w          => '48312',
    :sms        => '5869253509'
  }
}
