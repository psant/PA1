require_relative 'DataReader'

reader = DataReader.new

ARGV.each do |file_name|
  STDERR.puts "Processing #{file_name}"
  reader.load_data(file_name)
end
