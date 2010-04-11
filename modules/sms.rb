def sms(*args)
  from  = '#stock@irc.freenode.net'
  to    = "#{args[0].flatten[0]}@txt.att.net"
  body  = args[0].flatten[1]

  Pony.mail(:to => to, :from => from, :body => body)
  say_to_chan 'Message sent.'
end
