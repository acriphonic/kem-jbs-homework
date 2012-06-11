class MovieTest

	# fields
	@results
	@error_array

	# constructor
	def initialize(testarray)
		@results = testarray
		@error_array = Array.new
		@results.each do |x|
			@error_array << (x[2].to_f - x[3].to_f).abs
		end
		puts mean
		puts stddev
		puts rms
	end

	# returns average prediction error
	def mean
		@error_array.inject(:+) / @error_array.length
	end

	# returns standard deviation of the error
	def stddev
		m = mean
		if @error_array.length == 1
			puts "Oh no! There's no standard deviation for data sets of length 1"
		else
			Math.sqrt((@error_array.inject(0.0){|x, y| x + (y-m)**2}) / (@error_array.length - 1).to_f)
		end
	end

	# returns the root mean square error of prediction
	def rms
		Math.sqrt(@error_array.inject(0.0){|sum, x| sum += x*x} / @error_array.length.to_f)
	end

	# returns an array of the predictions in the form [u,m,r,p]
	def to_a
		@results
	end
end