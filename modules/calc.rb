def calc(*args)
  arg = args[0].flatten
  snd = arg.pop
  url = "http://www.google.com/search?q=#{arg.join}"
  dat = RestClient.get(url)
  doc = Hpricot(dat.to_s)
  r1  = doc.search("//h2[@class='r']")
  r2  = r1.search("b").inner_html.gsub(/<\/?[^>]*>/, "")

  unless r2.empty?
    say_to_chan "#{snd}: #{r2}"
  else
    say_to_chan 'No results.'
  end
end
