def title(*args)
  begin
    Timeout.timeout 3 do
      dat = RestClient.get(args.flatten.first.strip)
      doc = Hpricot(dat.to_s)

      title = doc.search("title").inner_html.gsub(/(\n|\t)/, ' ').strip.gsub(/\s+/, ' ')
      title = Sanitize.clean(title)

      say_to_chan "URL Title: #{title}" unless title == ''
    end
  rescue Timeout::Error
    say_to_chan 'Execution timeout.'
  end
end
