def fml(*args)
  dat = RestClient.get('http://fmylife.com/random')
  doc = Hpricot(dat.to_s)

  post = doc.search("#wrapper").search(".post").first.search('p').first.inner_html
  post.strip_html!
  post.gsub! /\s+/, ' '

  say_to_chan post
end
