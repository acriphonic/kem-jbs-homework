class Rating < ActiveRecord::Base
  attr_accessible :movie_id, :rating, :user_id
end
