def urban(*args)
  sender  = args[0].pop
  term    = args.flatten.first.strip rescue nil

  if term
    html = RestClient.get("http://www.urbandictionary.com/define.php?term=#{CGI.escape(term)}")
    doc = Hpricot(html.to_s)

    begin
      definition = doc.at("meta[@name='Description']")['content']
      definition = definition.split(' - ')
      definition = definition.first + " - " + definition.last

      say_to_chan definition
    rescue
      say_to_chan 'Definition not found.'
    end
  else
    html = RestClient.get("http://www.urbandictionary.com/random.php")
    doc = Hpricot(html.to_s)
    
    begin
      definition = doc.at("meta[@name='Description']")['content']
      definition = definition.split(' - ')
      definition = definition.first + " - " + definition.last

      say_to_chan definition
    rescue
      say_to_chan 'Urban Dictionary is down.'
    end
  end
end

alias :ud :urban
