module Plugins
  def solve(*args)
    sender  = args[0].pop
    term    = args.flatten.to_s rescue nil

    if term
      html = RestClient.get("http://www.wolframalpha.com/input/?i=#{CGI.escape(term)}")
      begin
        solved = html.to_s.scan(/"stringified": *"([^"]*)"/)
        say_to_chan solved.flatten.first + ", " + solved.flatten.last
      rescue
        say_to_chan 'Unable to solve equation.'
      end
    else
      say_to_chan 'No equation set.'
    end
  end

  alias :s :solve
end
