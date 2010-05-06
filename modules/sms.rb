def sms(*args)
  args  = args[0].flatten
  from  = "#{args.pop}#stock@irc.freenode.net"
  to    = args.shift.downcase
  body  = args.join ' '

  if to.to_i == 0
    user = DB[:users].filter(:name => to).first
    if user and user[:sms_email]
      to  = user[:sms_email]
    else
      say_to_chan 'Invalid recipient.'
      return
    end
  end

  Pony.mail(:to => to, :from => from, :body => body)
  say_to_chan 'Message sent.'
end

alias :txt :sms
