def sms(*args)
  args  = args[0].flatten
  from  = "#{args.pop}#stock@irc.freenode.net"
  to    = args.shift.downcase
  body  = args.join ' '

  if to.to_i == 0
    if $users[to] and $users[to][:sms]
      to  = $users[to][:sms]
    else
      say_to_chan 'Invalid recipient.'
    end
  end

  Pony.mail(:to => to, :from => from, :body => body)
  say_to_chan 'Message sent.'
end

alias :txt :sms
