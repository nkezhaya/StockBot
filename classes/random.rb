class Random
  def self.number(max = 10)
    doc = RestClient.get "http://www.random.org/integers/?num=1&min=1&max=#{options.length}&col=1&base=10"
    dat = Hpricot(doc.to_s)

    dat.search("//pre[@class='data']").inner_html.strip.to_i
  end
end
