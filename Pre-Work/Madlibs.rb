# Kendall McCarthy
# May 29th, 2012
# Week 1, Lecture 2, Madlibs program

class Madlibs

	# create one large string variable for story template
	$story = File.read("Animal_Panic.madlibs")

	# create list of questions that need to be asked from variables in (())
	$questions = $story.scan(/\(\((.*?)\)\)/)

	# create hash to contain master question list, to account for multiple uses
	$masterquestion = Hash.new()

	# for each question
	$questions.each {|x|
		# make it into a string variable instead of an array... why do I have to do this??
		x = x[0]
		# if it's one of those re-used ones, construct a key
		if x.include? ":"
			caller, mate = x.split(':')
		# if not, it keys to itself
		else
			caller, mate = x, x
		end
		# as long as the value isn't already in the hash, add
		if !($masterquestion.has_key?(x))
			$masterquestion[caller] = mate
		end
	}

	# create hash to contain the answers to the master questions
	$masteranswer = Hash.new()

	# for each key and field
	$masterquestion.each_pair {|k,q|
		# use the field to prompt user input
		puts "Please name #{q}:"
		# remove the linebreak from user input
		a = gets.chomp
		# add to the answer hash with the field as a key
		$masteranswer[q] = a
	}

	# now the idea is to go backwards...
	# start with the original story and find a word in (())
	# if it contains :, take only the first word as a key
	# the word we find is the key for the master question array
	# the field from the master question array is the key for the master answer array
	# the replacement we want is the field of the master answer array
	$story.gsub!(/\(\((.*?)\)\)/) {|found|
		$masteranswer[$masterquestion[found.gsub(/[()]/, '').split(':').first]]
	}

	# print the updated story, yay!
	puts $story
end