def dict(*args)
  sender  = args[0].pop
  term    = args.flatten.to_s rescue nil
  if term
    html = RestClient.get("http://dictionary.reference.com/browse/#{CGI.escape(term)}")
  else
    say_to_chan 'No word specified.'
  end

  begin
    doc        = Hpricot(html.to_s)
    definitions = doc.search("div[@class='dndata']")
    
    say_to_chan "1. #{definitions[0].inner_html.strip_html! :replacement => '', :remove_wrapped_content => true}" unless definitions[0].inner_html.strip_html!.length < 2
    say_to_chan "2. #{definitions[1].inner_html.strip_html! :replacement => '', :remove_wrapped_content => true}" unless definitions[1].inner_html.strip_html!.length < 2
  rescue
    say_to_chan 'Definition not found.'
  end
end

alias :d :dict
alias :def :dict
