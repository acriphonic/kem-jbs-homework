class Viewer
	
	# object fields
	@user_id
	@moviehash
	@ratingsum
	@moviepop

	# constructor
	def initialize(user_id)
		@user_id = user_id
		@moviehash = Hash.new()
		@ratingsum = 0
		@moviepop = 0
	end

	# allows movie ratings to be updated
	def add_movie(movie, rating)
		@moviehash[movie] = rating
		@ratingsum += rating
		@moviepop += 1
	end

	# returns average movie rating
	def avg_rating
		@ratingsum / @moviepop
	end

	# accessor method
	def get_id
		@user_id
	end

	# accessor method
	def get_movies
		@moviehash
	end

	# overrides to string
	def to_s
		puts @user_id
	end
end