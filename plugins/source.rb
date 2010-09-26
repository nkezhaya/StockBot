module Plugins
  def source(*args)
    say_to_chan 'http://github.com/whitepaperclip/StockBot'
  end

  alias :src :source
end
