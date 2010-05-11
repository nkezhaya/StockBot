def solve(*args)
  sender  = args[0].pop
  term    = args.flatten.to_s rescue nil
  html    = if term
              RestClient.get("http://www.wolframalpha.com/input/?i=#{CGI.escape(term)}")
            else
              say to chan 'No equation set.'
            end

  begin
    solved = html.to_s.scan(/"stringified": *"([^"]*)"/)

    say_to_chan solved.flatten.first + ", " + solved.flatten.last
  rescue
    say_to_chan 'Unable to solve equation.'
  end
end

alias :s :solve
