def fml(*args)
  dat = RestClient.get('http://fmylife.com/random')
  doc = Hpricot(dat.to_s)

  post = doc.search("#wrapper").search(".post").first.search('p').first.inner_html
  post.html_to_ascii!
  post.strip_html!
  post.gsub! /\s+/, ' '

  post = Sanitize.clean(post)

  post.scan(/.{1.350}/).each do |line|
    say_to_chan line
  end
end
