def down(*args)
  site = args.flatten.first
  dat = RestClient.get("http://downforeveryoneorjustme.com/#{CGI.escape(site)}")

  if dat.include? 'looks down from here'
    say_to_chan "Yeah, it's down."
  else
    say_to_chan "It's just you."
  end
end
