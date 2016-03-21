require 'fileutils'
require 'logger'
require_relative 'lib/multi_io'
require_relative 'lib/tasks/scrape_task'

Dir.glob('lib/tasks/*.rake').each {|r| import r}

desc "create txt file"
task :execute do
  FileUtils::mkdir_p 'log'
  log_file = File.open('log/city_scraper.log', "a")
  logger = Logger.new(MultiIO.new(STDOUT, log_file))
  action = ScrapeTask.new(logger)
  action.run
end