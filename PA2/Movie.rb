class Movie

	#object fields
	attr_accessor :movie_id, :genre, :release_date, :popularity, :title
	attr_reader :raterhash
	@ratingcount

	# constructor
	def initialize(movie_id)
		@movie_id = movie_id
		@genre = Array.new
		@raterhash = Hash.new
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

	# override to string
	def to_s
		puts @title
	end
end