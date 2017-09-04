require 'test/unit'
require 'byebug'

require_relative '../lib/istat/istat_csv_parser'
require_relative '../lib/istat/istat_header'
require_relative '../lib/istat/city'

class IstatCsvParserTest < Test::Unit::TestCase

  def setup
    @istat = IstatCsvParser.new('codici_istat_2017.csv')
    @h = IstatHeader.hash(@istat.headers)
    @v = @istat.values
  end

  def test_city
    city = City.new(@v[0], @h)
    val = [city.name, city.region, city.province, city.plate, city.cf]
    puts val
  end
end