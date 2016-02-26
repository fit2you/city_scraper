require 'ostruct'
require 'test/unit'
require_relative '../lib/scraper'


class CsvParserTest < Test::Unit::TestCase

  def setup
    @r = OpenStruct.new(name: "Trieste", plate: "TS", region: "Friuli-Venezia Giulia")
    @s = Scraper.new(@r)
  end

  def test_url
    url = @s.create_url
    expected = "http://www.paginebianche.it/cap/friuli-venezia-giulia/ts/trieste.html"
    assert_equal(expected, url)
  end
end