class Viewer
	
	# object fields
	attr_accessor :user_id, :age, :sex, :occupation, :zip
	attr_reader :moviehash
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

	# overrides to string
	def to_s
		puts @user_id
	end
end