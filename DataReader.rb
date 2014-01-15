require 'csv'
require_relative 'MovieData'

class DataReader
  
  def initialize
    @movie_list = []
  end
  
  def load_data(file_name)
    CSV.foreach(file_name) do |row| #Should be either row or col.
    @movie_list << MovieData.new(row[0], row[1], row[2], row[3])
    end
  end
  
end