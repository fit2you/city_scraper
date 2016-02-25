require 'ostruct'
require 'test/unit'

require_relative '../lib/scraper'


class CsvParserTest < Test::Unit::TestCase

  def setup
    @r = OpenStruct.new(city: "Milano", plate: "MI", region: "Lombardia")
  end

  def test_url
    url = Scraper.create_url(@r)
    expected = "http://www.paginebianche.it/cap/lombardia/mi/milano.html"
    assert_equal(expected, url)
  end
end