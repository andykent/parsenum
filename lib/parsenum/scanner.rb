class Parsenum::Scanner
  def initialize(str)
    @source = str
  end

  def candidates
    return [] if @source.nil?
    @source.scan(/[\£\$\d\.\,\%]+/)
  end
end