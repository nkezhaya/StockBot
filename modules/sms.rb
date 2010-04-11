def sms(*args)
  from  = '#stock@irc.freenode.net'
  to    = args[0].flatten[0]
  body  = args[0].flatten[1]

  if $users[args[0].flatten[0].downcase] and $users[args[0].flatten[0].downcase][:sms]
    to  = $users[args[0].flatten[0].downcase][:sms]
  end

  Pony.mail(:to => "#{to.to_i}@txt.att.net", :from => from, :body => body)
  say_to_chan 'Message sent.'
end
