class Random
  def self.number(max = 10)
    dat = RestClient.get "http://www.random.org/integers/?num=1&min=1&max=#{max}&col=1&base=10"
    doc = Hpricot(dat.to_s)

    doc.search("//pre[@class='data']").inner_html.strip.to_i
  end
end
