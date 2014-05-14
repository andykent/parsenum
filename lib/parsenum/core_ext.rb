class String
  def number
    Parsenum.parse(self).value
  end

  def numbers
    Parsenum.parse_all(self).map(&:value)
  end
end