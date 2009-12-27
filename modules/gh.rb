def gh(*args)
  html = RestClient.get('http://confessions.grouphug.us/random')
  doc = Hpricot(html)

  doc.search("//h2[@class='title']")[5].inner_html =~ /(\d+)/
  number = $1
  confession = doc.search("//div[@class='content']")[5].inner_html.strip
  confession = Sanitize.clean(confession)
  confession.remove_nonascii!

  if confession.length > 400
    confession_chunks = []

    while confession.length > 400
      confession_chunks << confession[0..400]
      confession = confession[401..99999]
    end

    confession = []
  end

  if confession.class == Array
    say_to_chan("#{number} - #{confession_chunks.first}")

    1.upto(confession_chunks.length) do |index|
      say_to_chan(confession_chunks[index])
    end
  else
    say_to_chan("#{number} - #{confession}")
  end
end
