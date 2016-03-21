require 'rake'
require_relative '../agenzia_entrate/ae_scraper'
require_relative '../multi_io'

desc "Get cadastral codes from Agenzia delle Entrate"
task :get_cadastral_codes do

  root = File.expand_path("../..", File.join(File.dirname(__FILE__)))  
  headers = ["name", "province", "plate", "cadastral_code"]
  
  log_file = File.open(File.join(root, 'log', 'cadastral_codes.log'), "a")
  logger = Logger.new(MultiIO.new(STDOUT, log_file))
  
  output_file_path = File.join(root, 'data', "cadastral_codes_#{Time.now.to_i}.txt")
  output_file = []
  output_file << headers.join("; ")

  AeScraper.execute(logger).each do |c|
    output_file << [c.name, c.province, c.plate, c.cadastral_code].join("\t")
  end

  f = File.open(output_file_path, "w") {|file| file.write(output_file.join("\n"))}

end