def title(*args)
  dat = RestClient.get(args.flatten.first.strip)
  doc = Hpricot(dat.to_s)

  title = doc.search("title").inner_html.gsub(/(\n|\t)/, ' ').strip.gsub(/\s+/, ' ')

  say_to_chan "URL Title: #{title}"
end
