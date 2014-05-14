require "parsenum/version"

module Parsenum
  INTEGER     = 'integer'
  NIL         = 'nil'
  FLOAT       = 'float'
  PERCENTAGE  = 'percentage'
  CURRENCY    = 'currency'

  def parse(str)
    candidate = Parsenum::Scanner.new(str).candidates.first
    Parsenum::Parser.new(candidate)
  end
  module_function :parse

  def parse_all(str)
    Parsenum::Scanner.new(str).candidates.map do |candidate|
      Parsenum::Parser.new(candidate)
    end
  end
  module_function :parse_all
end

require "parsenum/scanner"
require "parsenum/parser"
require "parsenum/core_ext"
