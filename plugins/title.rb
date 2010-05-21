module Plugins
  def title(*args)
    begin
      Timeout.timeout 3 do
        dat = RestClient.get(args.flatten.first.strip, :user_agent => 'Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.8.1.12) Gecko/20080219 Firefox/2.0.0.12 Navigator/9.0.0.6 ')
        doc = Hpricot(dat.to_s)

        title = doc.search("title").inner_html.gsub(/(\n|\t)/, ' ').strip.gsub(/\s+/, ' ')
        title = Sanitize.clean(title)

        say_to_chan "URL Title: #{title}" unless title == ''
      end
    rescue Timeout::Error
    end
  end
end
