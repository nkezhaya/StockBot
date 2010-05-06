require 'rubygems'
require 'socket'
require 'rest_client'
require 'hpricot'
require 'sanitize'
require 'cgi'
require 'net/http'
require 'pony'

Dir['classes/*'].each { |object| require object }

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
  },

  'god_'        => {
    :w          => 'H4G2M4',
    :sms        => '5145139979@pcs.rogers.ca'
  },

  'impl'        => {
    :w          => '64111',
    :sms        => '8168670001@txt.att.net'
  },

  'stitch'      => {
    :w          => '61114'
  }
}
