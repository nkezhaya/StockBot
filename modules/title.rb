def title(*args)
  dat = RestClient.get(args.flatten.first)
  doc = Hpricot(dat.to_s)

  title = doc.search("title").inner_html

  say_to_chan "URL Title: #{title}"
end
