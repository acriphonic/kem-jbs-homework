class Movie

	#object fields
	@movie_id
	@raterhash
	@popularity
	@ratingcount

	# constructor
	def initialize(movie_id)
		@movie_id = movie_id
		@raterhash = Hash.new()
		@popularity = 0
		@ratingcount = 0
	end

	# allows movie ratings to be updated
	def add_rating(viewer, rating)
		@raterhash[viewer] = rating
		@popularity += rating
		@ratingcount += 1
	end

	# accessor method
	def get_avgrating
		return (@popularity / @ratingcount)
	end

	# accessor method
	def popularity
		return @popularity
	end

	# accessor method
	def movie_id
		@movie_id
	end

	# accessor method
	def get_viewers
		@raterhash
	end

	# override to string
	def to_s
		puts "film #{@movie_id} with popularity #{@popularity}"
	end
end