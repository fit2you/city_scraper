require 'uri'
require 'open-uri'
require 'nokogiri'
require 'ostruct'

class AeScraper

  BASE_URL = 'http://www.paginebianche.it/cap/'
  USER_AGENT = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:44.0) Gecko/20100101 Firefox/44.0'
  
  def initialize r
    @r = r
  end

  def get_cap
    doc = Nokogiri::HTML(get_page_content)
    doc.css("span[class='result-cont-li li-cap']").text
  end

  def get_page_content
    url = create_url
    source = open(url, "User-Agent" => USER_AGENT ){|f| f.read}
  end

  def create_url
    region = URI.escape(@r.region.gsub(" ", "-").downcase)
    plate = URI.escape(@r.plate.downcase)
    name = URI.escape(@r.name.downcase)
    BASE_URL + [region, plate, name].join('/') + '.html'
  end


end