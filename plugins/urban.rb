module Plugins
  def urban(*args)
    sender  = args[0].pop
    term    = args.flatten.to_s rescue nil
    html    = RestClient.get("http://www.urbandictionary.com/define.php?term=#{CGI.escape(term)}")

    begin
      doc        = Hpricot(html.to_s)
      definition = doc.at("meta[@name='Description']")['content'].split(' - ')

      say_to_chan definition
    rescue
      say_to_chan 'Definition not found.'
    end
  end

  alias :ud :urban
end
