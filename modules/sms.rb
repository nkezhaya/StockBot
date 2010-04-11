def sms(*args)
  from  = '#stock@irc.freenode.net'
  to    = args[0].flatten[0].downcase
  body  = args[0].flatten[1]

  if $users[to] and $users[to][:sms]
    to  = $users[to][:sms]
  end

  Pony.mail(:to => "#{to.to_i}@txt.att.net", :from => from, :body => body)
  say_to_chan 'Message sent.'
end
