require './Movie'
require './Viewer'
require './MovieTest'
require './movie_data'

class MovieSearchDemo

	# movie data object
	@movdat

	def initialize(filepath)
		@movdat = MovieData.new(filepath)
		@movdat.load_data

	def test1(genre, year)
		start = Time.now
		search = Hash.new
		search["genre"] = genre
		search["year"] = year
		results = @movdat.find_movies(search)
		finish = Time.now
		puts "Took #{finish - start} seconds"
		puts results
	end

	def test2(agerange, sex, n)
		start = Time.now
		search = Hash.new
		search["agerange"] = agerange
		search["sex"] = sex
		results = @movdat.find_users(search)
		movie_tally = Hash.new
		@movdat.movie_hash.each do |k, movie|
			movie_tally[movie] = (movie.raterhash.keys & results).count
		end
		results = movie_tally.sort { |v1, v2| v2[1] <=> v1[1] }
		finish = Time.now
		puts "Took #{finish - start} seconds"
		puts results[0..4]
	end
end

z = MovieSearchDemo.new("ml-100k")
puts "displaying all sci-fi movies released in 1996"
z.test1(15, 1996)
puts "displaying top 5 most viewed movies by college age females"
z.test2([18, 21], "F", 5)
puts "displaying top 5 most viewed movies by college age males"
z.test2([18, 21], "M", 5)

end