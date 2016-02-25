require 'uri'
require 'open-uri'
require 'nokogiri'
require 'ostruct'

class Scraper

  BASE_URL = 'http://www.paginebianche.it/cap/'

  def initialize r
    @r = r
  end

  def get_cap
    doc = Nokogiri::HTML(get_page_content)
    doc.css("span[class='result-cont-li li-cap']").text
  end

  def get_page_content
    url = create_url
    source = open(url){|f|f.read}
  end

  def create_url
    region = URI.escape(@r.region.downcase)
    plate = URI.escape(@r.plate.downcase)
    name = URI.escape(@r.name.downcase)
    BASE_URL + [region, plate, name].join('/') + '.html'
  end


end