require_relative '../csv_parser'
require_relative '../istat_header'
require_relative '../city'
require_relative '../scraper'
require 'byebug'

class ScrapeTask

  ROOT = File.expand_path("..", File.join(File.dirname(__FILE__)))  
  HEADERS = ["name", "region", "province", "plate", "cf", "cap"]
  
  def initialize logger
    istat = CsvParser.new('codici_istat_2016.csv')
    @h = IstatHeader.hash(istat.headers)
    @v = istat.values
    n = @v.size - 1
    @range = (0..n)
    @values = []
    @errors = []
    @logger = logger
  end

  def run

    scrape_routine(@range)

    while !@errors.empty? do
      @range = @errors
      @errors = []
      scrape_routine(@range)
    end

    export
 
  end

  def scrape_routine(index_range)
    index_range.each do |i|
      begin
        r = City.new(@v[i], @h)
        s = Scraper.new(r)
        cap = s.get_cap
        @values << [r.name, r.region, r.province, r.plate, r.cf, cap]
        @logger.info("OK\t#{r.name}\t#{r.plate}\t#{cap}\n")
      rescue Exception
        @logger.info("ERROR\t#{r.name}\t#{r.plate}\tfailed\n")
        @errors << i
      end
      sleep(4)
    end
  end

  def compile_text
    text = HEADERS.join(';')+'\n'
    @values.each do |v|
      text += v.join(';')+'\n'
    end
    return text
  end

  def export
    f = File.open(File.join(ROOT, 'data', export_filename ), "w")
    f.write( compile_text )
    f.close
  end

  def export_filename
    sprintf("%s_%s.txt", "cities_list", Time.now.to_i)
  end
end