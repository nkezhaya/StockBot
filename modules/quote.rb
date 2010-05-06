def quote(*args)
  time = Time.now.strftime('%m/%d/%Y')
  rquote = Rquote.new
  args.uniq!

  for symbol in args
    stock = rquote.find(symbol)

    unless stock.first[:price] == '0.00'
      say_to_chan "#{symbol.upcase} -> #{time} | Last #{stock.first[:price]} (#{stock.first[:change]}) | Vol. #{stock.first[:volume]}"
    end
  end
end
