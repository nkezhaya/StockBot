class String
  def html_to_ascii!(replacement = '')
    self.gsub!('&#8217;', "'")
    self.gsub!('&#8220;', '"')
    self.gsub!('&#8221;', '"')
    self.gsub!('&#8230;', '...')
    self.gsub!('&nbsp;', ' ')
    self.gsub!('  ', ' ')

    n = self.split ''
    self.slice! 0..self.size

    n.each do |b|
      if b[0].to_i < 32 or b[0].to_i > 127
        self.concat(replacement)
      else
        self.concat(b)
      end
    end

    self.to_s
  end
end
