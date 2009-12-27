class String
  def remove_nonascii!(replacement = '')
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
