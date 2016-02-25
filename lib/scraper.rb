require 'uri'

class Scraper

  BASE_URL = 'http://www.paginebianche.it/cap/'

  class << self

    def create_url r
      region = URI.escape(r.region.downcase)
      plate = URI.escape(r.plate.downcase)
      city = URI.escape(r.city.downcase)
      BASE_URL + [region, plate, city].join('/') + '.html'
    end

  end

end