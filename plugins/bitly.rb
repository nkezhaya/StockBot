module Plugins
  API_KEY = 'R_2bb91a5f9d453880b5274d0e41b2e7a3'
  LOGIN   = 'nkezhaya'

  def bitly(*args)
    html = RestClient.get("http://api.bit.ly/shorten?version=2.0.1&longUrl=#{CGI.escape(args[0].first)}&login=#{LOGIN}&apiKey=#{API_KEY}&format=xml")
    doc = Hpricot(html)
    say_to_chan(doc.search('//shorturl').inner_html)
  end
end
