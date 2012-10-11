module Plugins
  def gh(*args)
    begin
      html = RestClient.get("http://grouphug.us/frontpage?page=#{rand(16)}")
    rescue
      say_to_chan 'GH is down. :('
      return
    end

    doc = Hpricot(html.to_s)

    confession_div = doc.search("//div[@class='node node-confession node-promoted']").to_a.shuffle.first
    number = confession_div.search('//a')[0].inner_html

    confession = confession_div.search("//div[@class='field-items']//div")[0].inner_html
    confession.html_to_ascii!

    confession = Sanitize.clean(confession).strip

    confession.scan(/.{1,350}/).each_with_index do |line, index|
      line = "#{number} - #{line}" if index == 0
      say_to_chan("#{line}")
      sleep 2
    end
  end
end
