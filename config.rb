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
    :sms        => '9727435255@txt.att.net'
  },

  'skalnik'     => {
    :w          => '30332',
    :sms        => '9722682292@txt.att.net'
  },

  'sneakyness'  => {
    :w          => '48312',
    :sms        => '5869253509@txt.att.net'
  },

  'makmanalp'   => {
    :w          => '01609',
    :sms        => '5087627257@tmomail.net'
  }
}
