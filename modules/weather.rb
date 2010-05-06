def weather(*args)
  api = 'http://api.wunderground.com/auto/wui/geo/WXCurrentObXML/index.xml?query='
  inp = args[0].first.downcase

  user = DB[:users].filter(:name => inp).first
  if user and user[:weather]
    zip = user[:weather]
  else
    zip = args.flatten.join
  end

  xml = RestClient.get(api + zip)
  doc = Hpricot::XML(xml.to_s)
  res = []

  [ 'full', 'temperature_string', 'weather', 'local_time' ].each do |var|
    res << doc.at(var).inner_html
  end

  say_to_chan res.join(' - ') unless res.first == ', '
end

alias :w :weather
