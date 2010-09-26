module Plugins
  def fml(*args)
    api_key = '4be9c43fc03fe'
    lang    = 'en'
    sender  = args[0].pop
    term    = args.flatten.to_s rescue nil

    begin
      xml = RestClient.get("http://api.betacie.com/view/random?key=#{api_key}&language=#{lang}")
      doc  = Hpricot(xml.to_s)
      id = doc.search("item").first.attributes["id"]
      fml = doc.search("//item").search("//text").first.inner_html
        
      say_to_chan id + " - " + fml
    rescue
      say_to_chan 'Today, I tried to query the FML bot, but it was down. FML'
    end
  end

  alias :f :fml
end
