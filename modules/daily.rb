def daily(args)
  rquote = Rquote.new

  for symbol in args
    stock = rquote.find(symbol)
    next if stock.first[:price] == "0.00"
    say_to_chan("http://finviz.com/chart.ashx?t=#{symbol.upcase}&p=d&s=l")
  end
end
