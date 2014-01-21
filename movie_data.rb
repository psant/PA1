#Prasant Lokinendi

class MovieRating
  
  attr_reader :user_id, :movie_id, :rating, :timestamp, :popularity
  
  def initialize(user_id,movie_id,rating,timestamp)
    @user_id = user_id
    @movie_id = movie_id
    @rating = rating
    @timestamp = timestamp
  end
  
  #Popularity is defined as the sum of the ratings of all reviews. Thus, movies that are reviewed more frequently even at a lower rating
  #might have a larger popularity than movies with a few very high ratings
  def popularity (movie_id) 
      sum_ratings = 0
      
      list_of_ratings.each do |rating|
        if (movie_id == rating.movie_id)
          sum_ratings = sum_ratings + rating.rating
        end
      end
      return sum_ratings
      
    end
end

class MovieData
  attr_reader :list_of_ratings
  
  #Creates array to store movies
  def initialize
    @list_of_ratings = Array.new
  end
  
  #Loads data from TSV file and adds each line to the list of ratings
  def load_data
    File.open("u.data", "r") do |file|
      while line = file.gets
        tempLine = line.split("\t")
        rating = MovieRating.new(tempLine[0].to_i, tempLine[1].to_i, tempLine[2].to_i, tempLine[3].to_i)
        @list_of_ratings << rating
      end
    end
    
    #Exact same method as the one used in MovieRating class
    def popularity (movie_id) 
      sum_ratings = 0
      
      list_of_ratings.each do |rating|
        if (movie_id == rating.movie_id)
          sum_ratings = sum_ratings + rating.rating
        end
      end
      return sum_ratings
      
    end
    
    def popularity_list
      list = []
      list_of_ratings.each do |rating|
        temp = MovieRating.new(rating.movie_id, rating.user_id, rating.rating, rating.timestamp)
        list << temp
      end
      list.sort_by{|movie_id, popularity| popularity}
      #Returns the ten most popular movies
      for i in 0..9
        temp = list[i]
        puts temp
      end
    end
  end
end