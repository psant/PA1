require_relative 'movie_data'

database = MovieData.new
database.load_data

puts "Popularity List"
database.popularity_list

puts "Popularity of Movie 1014"
puts database.popularity(1014)
