require_relative 'istat_csv_parser'
require_relative 'istat_header'
require_relative 'city'

class CapLog
  
  attr_reader :list
  ROOT = File.expand_path("../..", File.join(File.dirname(__FILE__)))

  def initialize file_name
    file =  File.open(File.join(ROOT, 'data', file_name)).read
    file.gsub!(/\r\n?/, "\n")
    @list = file.split("\n")
  end
end

class ParseFromLog

  ROOT = File.expand_path("..", File.join(File.dirname(__FILE__)))  
  HEADERS = ["name", "region", "province", "plate", "cf", "cap"]
  
  def initialize
    istat = IstatCsvParser.new('codici_istat_2016.csv')
    @h = IstatHeader.hash(istat.headers)
    @v = istat.values
    @c = CapLog.new('log.txt').list
    n = @v.size - 1
    @range = (0..n)
    @values = []
    @errors = []
    @log = File.open(File.join(ROOT, 'data', 'logger.txt'), "a")
  end

  def run
    @range.each do |i|
      begin
        r = City.new(@v[i], @h)
        cap = get_cap(r, i)
        @values << [r.name, r.region, r.province, r.plate, r.cf, cap]
        puts "#{r.name} #{r.plate} #{cap}"
        log_to_file("#{r.name} #{r.plate} #{cap}\n")
      rescue Exception
        puts "#{r.name} #{r.plate} gave a problem"
        log_to_file("#{r.name} #{r.plate} gave a problem\n")
        @errors << i
      end
    end
    @log.close
    export
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

  def get_cap city, index
    val = [city.name, city.plate].join(" ")
    if @c[index].include?(val) 
      @c[index].gsub(val, "").strip
    else
      byebug
    end
  end

  def log_to_file text
    @log.write(text)
  end

end

