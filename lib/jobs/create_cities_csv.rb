require_relative '../csv_parser'
require_relative '../istat_header'
require_relative '../city'

ROOT = File.expand_path("../..", File.join(File.dirname(__FILE__)))

istat = CsvParser.new('codici_istat_2016.csv')

h = IstatHeader.hash(istat.headers)
print h
v = istat.values
n = v.size - 1


headers = ["name", "region", "province", "plate", "cf"]
values = []


(0..n).each do |i|
  begin
    r = City.new(v[i], h)
    values << [r.name, r.region, r.province, r.plate, r.cf]
  rescue Exception
    print "row #{i} gave a problem"
  end
end


text = headers.join(';')+'\n'

values.each do |v|
  text += v.join(';')+'\n'
end

f = File.open(File.join(ROOT, 'data', 'output.txt'), "w")
f.write( text )
f.close