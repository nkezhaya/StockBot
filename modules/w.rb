def w(*args)
  api = 'http://api.wunderground.com/auto/wui/geo/WXCurrentObXML/index.xml?query='
  zip = args.flatten.join

  xml = RestClient.get(api + zip)
  doc = Hpricot::XML(xml)
  res = []

  [ 'full', 'temperature_string', 'weather', 'local_time' ].each do |var|
    res << doc.at(var).inner_html
  end

  say_to_chan res.join(' - ') unless res.first == ', '
end
