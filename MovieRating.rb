class MovieData
  
  attr_reader :user_id, :movie_id, :rating, :timestamp
  
  def initialize(user_id,movie_id,rating,timestamp)
    @user_id = user_id
    @movie_id = movie_id
    @rating = rating
    @timestamp = timestamp
  end
end