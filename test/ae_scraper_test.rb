require 'test/unit'
require 'byebug'
require_relative '../lib/agenzia_entrate/ae_scraper'

class AeScraperTest < Test::Unit::TestCase

  def setup
  end

  def province_list
    AeScraper.get_province_list
  end

end