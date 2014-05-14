Parsenum
========

Because sometimes you just want to get numbers out of strings damnit.

This acutally happens a surprising amount. Usually when reading a CSV or scraping a webpage you want extract a number out of a test string. Sure in the simple case .to_i and .to_f work fine but often there's pesky things like commas or pound signs getting in the way.

This library is pretty dumb as parsers go but it's just an attempt to hide all the string ugliness so you can get to the numbers you need.


Simple examples
---------------

    "123".number                => 123
    "1.23".number               => 1.23
    "£3.99".number              => 3.99
    "28.5%".number              => 0.285
    "$1.99".number              => 1.99
    "got 99 problems".number    => 99
    "8 out of 10 cats".numbers  => [8, 10]


Advanced Examples
-----------------

    number = Parsenum.parse("$3.99")
    number.value      => 3.99
    number.currency?  => true
    number.currency   => 'USD'

    number = Parsenum.parse("68%")
    number.value        => 0.68
    number.percentage?  => true
    numbers = Parsenum.parse_all("8 out of 10 cats")
    numbers.size               => 2
    numbers.first.value        => 8
    numbers.first.integer?     => true


TODO
----

- support for more currencies
- bigdecimel support