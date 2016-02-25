require 'test/unit'
require_relative '../lib/csv_parser'
require_relative '../lib/header'
require 'byebug'

class CsvParserTest < Test::Unit::TestCase

  def setup
    @istat = CsvParser.new('codici_istat_2016.csv')
    @h = Header.new(@istat.headers)
    @h.istat_index

  end

  def test_headers
    a = [@h.name_idx, @h.region_idx, @h.metropolis_idx, @h.province_idx, @h.plate_idx, @h.cf_idx]
    puts a
  end
end