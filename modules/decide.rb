def decide(*args)
  sender = args[0].pop
  options = args.flatten.sort_by { rand }

  doc = RestClient.get "http://www.random.org/integers/?num=1&min=1&max=#{options.length}&col=1&base=10"
  dat = Hpricot(doc.to_s)

  result = options[dat.search("//pre[@class='data']").inner_html.strip.to_i - 1]

  say_to_chan "#{result}"
end
