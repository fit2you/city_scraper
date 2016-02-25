class CsvParser

  ROOT = File.expand_path("..", File.join(File.dirname(__FILE__)))

  def initialize file_name
   file =  File.open(File.join(ROOT, 'data', file_name)).read
   file.gsub!(/\r\n?/, "\n")
   rows = file.split("\n")
   @rows = rows.map{|r| r.split(';')}
  end

  def headers
    @rows[0]
  end

  def values
    @rows[1..-1]
  end
end