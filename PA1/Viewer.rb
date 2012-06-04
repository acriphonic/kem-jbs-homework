class Viewer
	
	# object fields
	@user_id
	@moviehash

	# constructor
	def initialize(user_id)
		@user_id = user_id
		@moviehash = Hash.new()
	end

	# allows movie ratings to be updated
	def add_movie(movie, rating)
		@moviehash[movie] = rating
	end

	# all of the following are accessor methods
	def get_id
		@user_id
	end

	def get_movies
		@moviehash
	end

	# overrides to string
	def to_s
		puts @user_id
	end
end