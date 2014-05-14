class Parsenum::Parser
  attr_reader :source, :value, :type

  def initialize(source, type=nil)
    @source = source
    @value = nil
    @type = nil
    run
  end

  def currency
    return nil unless type == Parsenum::CURRENCY
    return 'GBP' if @source =~ /£/
    return 'USD' if @source =~ /\$/
    "other"
  end

  def nil?
    @type == Parsenum::NIL
  end

  def percentage?
    @type == Parsenum::PERCENTAGE
  end

  def currency?
    @type == Parsenum::CURRENCY
  end

  def float?
    @type == Parsenum::FLOAT
  end

  def integer?
    @type == Parsenum::INTEGER
  end

  private

  def run
    @type ||= estimate_type(@source)
    @value = extract(@source, @type)
  end

  def estimate_type(str)
    return Parsenum::NIL        if str.nil?
    return Parsenum::PERCENTAGE if str =~ /%/
    return Parsenum::CURRENCY   if str =~ /\$|£/
    return Parsenum::FLOAT      if str =~ /\d\.\d/
    return Parsenum::INTEGER    if str =~ /\d/
    Parsenum::NIL
  end

  def extract(str, t=nil)
    t ||= estimate_type(str)
    self.send(:"extract_#{t}", str)
  end

  def extract_nil(str)
    nil
  end

  def extract_integer(str)
    strip_commas(str).to_i
  end

  def extract_float(str)
    strip_commas(str).to_f
  end

  def extract_percentage(str)
    str = str.sub('%', '')
    extract_float(str) / 100.0
  end

  def extract_currency(str)
    matches = str.match(/(\$|£)([\d\,\.]+)/)
    return 0 unless matches
    extract(matches[2])
  end


  def strip_commas(str)
    str.gsub(',', '')
  end
end