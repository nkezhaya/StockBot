module Plugins
  def urban(*args)
    sender  = args[0].pop
    term    = args.flatten.to_s rescue nil
    html    = if term
                RestClient.get("http://www.urbandictionary.com/define.php?term=#{CGI.escape(term)}")
              else
                RestClient.get('http://www.urbandictionary.com/random.php')
              end

    begin
      doc        = Hpricot(html.to_s)
      definition = doc.at("meta[@name='Description']")['content'].split(' - ')
      definition = definition.first + " - " + definition.last

      say_to_chan definition
    rescue
      say_to_chan 'Definition not found.'
    end
  end

  alias :ud :urban
end
