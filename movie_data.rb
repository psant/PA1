#Prasant Lokinendi

class MovieRating
  
  attr_reader :user_id, :movie_id, :rating, :timestamp, :popularity
  
  def initialize(user_id, movie_id, rating, timestamp)
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
  attr_reader :list_of_ratings, :list_of_users
  
  #Creates array to store movies
  def initialize
    @list_of_ratings = Array.new
    @list_of_users = Hash.new {|h,k| h[k] = []}
    
  end
  
  #Loads data from TSV file and adds each line to the list of ratings. Also loads users to a hash.
  def load_data
    File.open("u.data", "r") do |file|
      while line = file.gets
        tempLine = line.split("\t")
        rating = MovieRating.new(tempLine[0].to_i, tempLine[1].to_i, tempLine[2].to_i, tempLine[3].to_i)
        @list_of_ratings.push(rating)
        #@list_of_ratings << rating
        #Loads users
        @list_of_users[tempLine[0].to_i] = @list_of_users[tempLine[0].to_i].push(tempLine[1].to_i)
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
    
    #Returns the ten most popular movies in the database
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
        puts temp.to_s
      end
    end
    
    #Determines similarity by comparing the movies watched and given the same rating.
    def similarity(user1, user2)
      sim_counter = 0
      @list_of_users[user1].each do |rating|
        if @list_of_users[user2].include?(rating)
          sim_counter += 1
        end
        return sim_counter
      end
    end
    
    def most_similar(user)
      answer = []
      hs = {}
      
      for i in 0..@list_of_users.size do
        hs[i] = similarity(user, i)
      end
      
      while hs.size > 0
        answer.push(hs.max_by{|key, value| value}[0])
        hs.delete(hs.max_by{|key, value| value}[0])
      end
      return answer
    end
      
    

  end
end