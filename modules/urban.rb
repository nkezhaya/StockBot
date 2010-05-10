def urban(*args)
  if args.flatten.first
    word = args.flatten.first
    html = RestClient.get('http://www.urbandictionary.com/define.php?term=' + word)
    doc = Hpricot(html)
  else
    html = RestClient.get('http://www.urbandictionary.com/random.php')
    doc = Hpricot(html)
  end
  
  definition = doc.at("meta[@name='Description']")['content']
  definition = definition.split(' - ')
  definition = definition.first + " - " + definition.last

  say_to_chan definition
end

alias :ud

