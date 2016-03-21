require 'uri'
require 'open-uri'
require 'nokogiri'

require_relative 'ae_city'


class AeScraper

  HOME_URL = 'https://telematici.agenziaentrate.gov.it/VerificaCF/Scegli.do?parameter=verificaCfPf'
  USER_AGENT = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:44.0) Gecko/20100101 Firefox/44.0'
  BASE_URL = 'https://telematici.agenziaentrate.gov.it/VerificaCF/AjaxOptionListComuni.do?prov='

  class << self 

    def execute(logger)
      @logger = logger
      cities = []
      province_list.each do |prov, name|
        cities << cities_list(prov, name)
        sleep(0.33)
      end
      cities.flatten
    end

    def province_list
      begin
        provinces = {}
        home = open(HOME_URL, "User-Agent" => USER_AGENT ){|f| f.read}
        doc = Nokogiri::HTML(home)
        options = doc.css("div[class= 'f24_campod']").css("select[name= 'prov']").css('option')

        options.each do |op|
          if op['value'] != ""
          provinces[op['value']] = op.text
          end
        end
        @logger.info("OK! Provinces collected correctly")
        return provinces
      
      rescue Exception => e
        @logger.error("ERROR! Provinces were not collected")
      end  
    end

    def cities_list prov, prov_name
      begin
        result = []
        url = BASE_URL + prov
        cities = open(url, "User-Agent" => USER_AGENT ){|f| f.read}
        doc = Nokogiri::XML(cities)
        doc.css('comuneImpl').each do |comune|
          result << AeCity.new(comune.css(name="dizione").text, comune.css(name="codCat").text, prov, prov_name)
        end
        @logger.info("OK! #{prov_name} collected correctly")
        return result
      
      rescue Exception => e
        @logger.error("ERROR! #{prov_name} was not collected")
      end
    end

  end
end