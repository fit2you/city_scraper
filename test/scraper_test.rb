require 'ostruct'
require 'test/unit'
require_relative '../lib/scraper'


class CsvParserTest < Test::Unit::TestCase

  def setup
    @r = OpenStruct.new(name: "Milano", plate: "MI", region: "Lombardia")
    @s = Scraper.new(@r)
  end

  def test_url
    url = @s.create_url
    expected = "http://www.paginebianche.it/cap/lombardia/mi/milano.html"
    assert_equal(expected, url)

    puts @s.get_cap

  end
end