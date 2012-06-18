require './Movie'
require './Viewer'
require './MovieTest'

class MovieData

	# fields
	attr_reader :viewer_hash, :movie_hash, :total_ratings
	@popularity_array
	@genre_array

	# saved filepaths
	@trainingfile
	@testingfile
	@viewerfile
	@moviefile
	@genrefile

	# constructor
	def initialize(filepath, fileset = nil)
		@viewer_hash = Hash.new
		@movie_hash = Hash.new
		@total_ratings = 0
		if fileset.nil?
			@trainingfile = filepath + "/u.data"
		else
			@trainingfile = filepath + "/" + fileset.to_s + ".base"
			@testingfile = filepath + "/" + fileset.to_s + ".test"
		end
		@viewerfile = filepath + "/u.user"
		@moviefile = filepath + "/u.item"
		@genrefile = filepath + "/u.genre"
	end

	# processes file to create necessary data structures
	def load_data
		# open file with movie rating data and go through line by line
		File.open(@trainingfile).each_line do |line|
			# split line data into relevant variables
			user_id, movie_id, r, timestamp = line.split
			# create new user if not found, else recall user
			v = @viewer_hash[user_id.to_i] ||= Viewer.new(user_id.to_i)
			# create new movie if not found, else recall movie
			m = @movie_hash[movie_id.to_i] ||= Movie.new(movie_id.to_i)
			# add user to movie's information
			m.add_rating(v, r.to_i)
			# add movie and rating to user's information
			v.add_movie(m, r.to_i)
			# increment total rating count
			@total_ratings += 1
		end
	end

	# adds information to viewer objects from u.user
	def populate_viewers
		File.open(@viewerfile).each_line do |line|
			user_id, age, sex, occupation, zip = line.split("|")
			u = viewer_hash[user_id.to_i]
			u.age = age.to_i
			u.sex = sex
			u.occupation = occupation
			u.zip = zip.to_i
		end
	end

	# adds information to movie objects from u.item
	def populate_movies
		# create genre key
		genre_key
		# open file with movie data and go through line by line
		File.open(@moviefile).each_line do |line|
			temp = line.force_encoding("iso-8859-1").split(/[|]+/)
			m = movie_hash[temp[0].to_i]
			m.title = temp[1]
			m.release_date = temp[2].split("-").last.to_i
			(4..22).each do |i|
				if temp[i].to_i == 1
					m.genre << (i - 4)
				end
			end
		end
	end

	# creates and stores genre key
	def genre_key
		@genre_array = Array.new
		File.open(@genrefile).each_line do |line|
			genre, genre_id = line.split("|")
			@genre_array[genre_id.to_i] = genre
		end
	end

	# returns the popularity of a given movie
	def popularity(movie_id)
		# finds the movie object from array
	 	m = @movie_hash[movie_id]
	 	# makes sure the popularity_array has been generated
	 	@popularity_array ||= popularity_list
	 	# returns index + 1 for its rank
	 	return @popularity_array.index(m) + 1
	end

	# popularity in this context is a combined weighting of ratings and views
	# a movie that has been seen 500 times with all ones is equally popular to
	# a movie seen 100 times with all fives... imperfect but workable
	def popularity_list
		# sorts by object-contained popularity score
		@popularity_array = @movie_hash.sort_by { |m| m.popularity }
	end

	# similarity in this context means "likelihood of going to a movie together"
	# this method defines 100% similarity as having seen all the same movies
	# and rated them all identically, and users recieve token credit for having
	# seen the same movie even if they disagree
	def similarity(user1, user2)
		# assign each movie rating hash to local variable
		m1 = user1.moviehash
		m2 = user2.moviehash
		# similarity starts at zero by default
		similarity = 0
		# create an array of their overlapping keys
		overlap = (m1.keys & m2.keys)
		# calculate total number of movies both of watched, minus overlap
		population = m1.size + m2.size - overlap.size
		population = population.to_f
		# calculate how much each movie rating diff is worth out of 100%
		compatibility_points = (100 / population) / 5
		# for each overlapping movie key, compare the ratings
		overlap.each do |movie|
			similarity += compatibility_points * (5 - (m1[movie] - m2[movie]).abs)
		end
		return similarity
	end

	# returns a list of the top 5 most similar users based on similarity method
	def most_similar(u)
		# creates a new array to hold non-zero compatibility-mates
		sim_array = Array.new
		# for each user of site, runs similarity method
		@viewer_hash.each do |user|
			simscore = similarity(u, user)
			if simscore > 0
				# if their similarity is above zero, added to array
				sim_array << [user, simscore]
			end
		end
		# sort array from highest compatibility to least
		sim_array.sort_by! { |x| x[1] }
		# return top five matches (minus oneself) as solution
		return sim_array[1..5]
	end

	# returns the rating a user gave a movie
	def rating(u, m)
		# will return 0 if no rating found
		if u.moviehash[m].nil?
			return 0.0
		else
			return u.moviehash[m]
		end
	end

	# prediction algorithm
	def predict(u, m)
		# intialize local variables
		ratingpool = 0.0
		ratingcount = 0.0
		# checks the viewers of given movie for compatibility with u higher than 20
		viewers(m).each do |v| 
			if similarity(u, v) >= 20.0
				# if yes, adds the rating to a pool of ratings and increases pool count
				ratingpool += rating(v, m).to_f
				ratingcount += 1.0
			end
		end
		# returns either avg similar pool rating or user's average movie rating
		if ratingcount == 0.0
			return u.avg_rating
		else
			return (ratingpool/ratingcount)
		end
	end

	# returns an array of movies a user has watched
	def movies(u)
		u.moviehash.keys
	end

	# returns all viewers of a given movie
	def viewers(m)
		m.viewerhash.keys
	end

	# runs prediction tests of k items
	def run_test(k = nil)
		# initialize local variables
		testarray = Array.new
		i = 0
		# begin benchmark
		puts Time.now
		# open testing file and read line by line
		File.open(@testingfile).each_line do |line|
			# split line into relevant data variables, sanitize
			user_id, movie_id, r, timestamp = line.split
			u = @viewer_hash[user_id.to_i] ||= Viewer.new(user_id.to_i)
			m = @movie_hash[movie_id.to_i] ||= Movie.new(movie_id.to_i)
			# add to array for MovieTest
			testarray[i] = [u, m, r.to_i, predict(u,m)]
			# condition to break at k lines
			i += 1
			break line if i == k
		end
		# end benchmark
		puts Time.now
		# generates new movietest object
		mt = MovieTest.new(testarray)
	end

	# returns array of movies that matches title, genre, year
	def find_movies(criteria)
		populate_movies
		results = @movie_hash.dup
		if !criteria["genre"].nil?
			results.delete_if {|k, movie| !movie.genre.include?(criteria["genre"]) }
		end
		if !criteria["title"].nil?
			results.delete_if {|k, movie| !movie.title.include?(criteria["title"]) }
		end
		if !criteria["year"].nil?
			results.delete_if {|k, movie| !(movie.release_date == criteria["year"]) }
		end
		return results.values
	end

	# returns array of users that matches age, sex, and occupation
	def find_users(criteria)
		populate_viewers
		results = @viewer_hash.dup
		if !criteria["agerange"].nil?
			results.delete_if do |k, user|
				(criteria["agerange"][0] > user.age) || (user.age > criteria["agerange"][1])
			end
		end
		if !criteria["sex"].nil?
			results.delete_if {|k, user| !(user.sex == criteria["sex"]) }
		end
		if !criteria["occupation"].nil?
			results.delete_if {|k, user| !(user.occupation == criteria["occupation"]) }
		end
		return results.values
	end
end