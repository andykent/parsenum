require_relative './spec_helper'

describe "Non-number Parsing" do
  it "doesn't blow up on nil values" do
    result = Parsenum.parse(nil)
    assert_equal Parsenum::NIL, result.type
    assert_equal nil, result.value
  end

  it "doesn't blow up on empty strings" do
    result = Parsenum.parse('')
    assert_equal Parsenum::NIL, result.type
    assert_equal nil, result.value
  end

  it "doesn't blow up on strings with no numbers present" do
    result = Parsenum.parse('hello world')
    assert_equal Parsenum::NIL, result.type
    assert_equal nil, result.value
  end
end

describe "Integer Parsing" do
  it "parses basic integers" do
    result = Parsenum.parse('123')
    assert_equal Parsenum::INTEGER, result.type
    assert_equal 123, result.value
  end

  it "parses integers with comma delimiters" do
    result = Parsenum.parse('123,456')
    assert_equal Parsenum::INTEGER, result.type
    assert_equal 123_456, result.value
  end

  it "parses integers out of text strings" do
    result = Parsenum.parse('got 99 problems')
    assert_equal Parsenum::INTEGER, result.type
    assert_equal 99, result.value
  end

    it "parses the first integer out of text" do
    result = Parsenum.parse('8 out of 10 cats')
    assert_equal Parsenum::INTEGER, result.type
    assert_equal 8, result.value
  end
end

describe "Float Parsing" do
  it "parses basic floats" do
    result = Parsenum.parse('1.23')
    assert_equal Parsenum::FLOAT, result.type
    assert_equal 1.23, result.value
  end

  it "parses floats with comma delimiters" do
    result = Parsenum.parse('123,456.7')
    assert_equal Parsenum::FLOAT, result.type
    assert_equal 123_456.7, result.value
  end
end

describe "Percentage Parsing" do
  it "parses basic percentages" do
    result = Parsenum.parse('12%')
    assert_equal Parsenum::PERCENTAGE, result.type
    assert_in_epsilon 0.12, result.value, 0.001
  end

  it "parses percentages with decimal places" do
    result = Parsenum.parse('12.3%')
    assert_equal Parsenum::PERCENTAGE, result.type
    assert_in_epsilon 0.123, result.value, 0.0001
  end
end

describe "Currency Parsing" do
  it "parses £" do
    result = Parsenum.parse('£123')
    assert_equal Parsenum::CURRENCY, result.type
    assert_equal 'GBP', result.currency
    assert_equal 123, result.value
  end

  it "parses £ with pence" do
    result = Parsenum.parse('£12.34')
    assert_equal Parsenum::CURRENCY, result.type
    assert_equal 'GBP', result.currency
    assert_in_epsilon 12.34, result.value, 0.001
  end
end

describe "Currency Parsing" do
  it "parses $" do
    result = Parsenum.parse('$123')
    assert_equal Parsenum::CURRENCY, result.type
    assert_equal 'USD', result.currency
    assert_equal 123, result.value
  end

  it "parses $ with cents" do
    result = Parsenum.parse('$12.34')
    assert_equal Parsenum::CURRENCY, result.type
    assert_equal 'USD', result.currency
    assert_in_epsilon 12.34, result.value, 0.001
  end
end

describe "parse_all" do
  it "parses multiple numbers" do
    result = Parsenum.parse_all('8 out of 10 cats')
    assert_equal result.size, 2
    assert_equal result[0].value, 8
    assert_equal result[1].value, 10
  end
end

describe "String extensions" do
  it "adds a 'number' method" do
    assert_equal 8, "8 out of 10 cats".number
  end

  it "adds a 'numbers' method" do
    assert_equal [8, 10], "8 out of 10 cats".numbers
  end
end