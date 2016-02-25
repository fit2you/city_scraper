require_relative 'csv_parser'
require_relative 'istat_header'
require_relative 'city'
require_relative 'scraper'
require 'byebug'

class ScrapeTask

  ROOT = File.expand_path("../..", File.join(File.dirname(__FILE__)))  
  HEADERS = ["name", "region", "province", "plate", "cf", "cap"]
  
  def initialize
    istat = CsvParser.new('codici_istat_2016.csv')
    @h = IstatHeader.hash(istat.headers)
    @v = istat.values
    n = @v.size - 1
    @range = (0..n)
    @values = []
    @errors = []
  end

  def run

    scrape_routine(@range)

    while !@errors.empty? do
      @range = @errors
      @errors = []
      scrape_routine(@range)
    end

    compile_text
 
  end

  def scrape_routine(index_range)
    index_range.each do |i|
      begin
        r = City.new(@v[i], @h)
        s = Scraper.new(r)
        cap = s.get_cap
        @values << [r.name, r.region, r.province, r.plate, r.cf, cap]
        puts "#{r.name} #{r.plate} #{cap}"
      rescue Exception
        puts "#{r.name} #{r.plate} gave a problem"
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
    f = File.open(File.join(ROOT, 'data', 'output.txt'), "w")
    f.write( compile_text )
    f.close
  end

end