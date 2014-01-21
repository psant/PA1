#Prasant Lokinendi
require_relative 'movie_data'

database = MovieData.new
database.load_data

puts "Popularity List"
puts database.popularity_list.first[10]

puts "Popularity of Movie 1014"
puts database.popularity(1014)

puts "Popularity of Movie 406"
puts database.popularity(406)

puts "Ten Most Similar to User 5"
puts database.most_similar(5).first(10)

