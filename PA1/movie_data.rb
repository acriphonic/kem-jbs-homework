require './Movie'
require './Viewer'

class MovieData

	# initialize variables
	$user_array = Array.new
	$movie_array = Array.new
	$popularity_array = Array.new
	$total_ratings = 0
	$total_users = 0
	$total_movies = 0

	def self.load_data
		# open file with movie rating data and go through line by line
		File.open('u.data').each_line { |line|
			# split line data into relevant variables
			user_id, movie_id, rating, timestamp = line.split
			user_id = user_id.to_i
			movie_id = movie_id.to_i
			rating = rating.to_i
			# create new user if not found, else recall user
			if $user_array[user_id - 1] == nil
				v = Viewer.new(user_id)
				$user_array[user_id - 1] = v
				$total_users += 1
			else
				v = $user_array[user_id - 1]
			end
			# create new movie if not found, else recall movie
			if $movie_array[movie_id - 1] == nil
				m = Movie.new(movie_id)
				$movie_array[movie_id - 1] = m
				$total_movies += 1
			else
				m = $movie_array[movie_id - 1]
			end
			# add user to movie's information
			m.add_rating(v, rating)
			# add movie and rating to user's information
			v.add_movie(m, rating)
			# increment total rating count
			$total_ratings += 1
		}
	end

	def self.popularity(movie_id)
		# finds the movie object from array
	 	m = $movie_array[movie_id - 1]
	 	# makes sure the popularity_array has been generated
	 	popularity_list
	 	# returns index + 1 for its rank
	 	return $popularity_array.index(m) + 1
	end

	# popularity in this context is a combined weighting of ratings and views
	# a movie that has been seen 500 times with all ones is equally popular to
	# a movie seen 100 times with all fives... imperfect but workable
	def self.popularity_list
		$popularity_array = $movie_array.dup
		$popularity_array.sort! { |b, a| 
			a.popularity <=> b.popularity
		}
	end

	# similarity in this context means "likelihood of going to a movie together"
	# this method defines 100% similarity as having seen all the same movies
	# and rated them all identically, and users recieve token credit for having
	# seen the same movie even if they disagree
	def self.similarity(user1, user2)
		# assign each movie rating hash to local variable
		m1 = user1.get_movies
		m2 = user2.get_movies
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
		overlap.each {|movie|
			similarity += compatibility_points * (5 - (m1[movie] - m2[movie]).abs)
		}
		return similarity
	end

	def self.most_similar(u)
		# creates a new array to hold non-zero compatibility-mates
		sim_array = Array.new
		# for each user of site, runs similarity method
		$user_array.each {|user|
			simscore = similarity(u, user)
			if simscore > 0
				# if their similarity is above zero, added to array
				sim_array << [user, simscore]
			end
		}
		# sort array from highest compatibility to least
		sim_array.sort! {|y, x|
			x[1] <=> y[1]
		}
		# return top five matches (minus oneself) as solution
		return sim_array[1..5]
	end

	# prepatory method calls
	load_data
	popularity_list
	# prints top 10 spots in popularity array
	puts $popularity_array[0..9]
	# prints bottom 10 spots in popularity array
	puts $popularity_array[($total_movies - 10)..($total_movies - 1)]
	# grabs user 1 from user array
	u1 = $user_array[0]
	# prints most similar users to user 1
	puts most_similar(u1)
end
