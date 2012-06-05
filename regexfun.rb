
# printer helper method
def printer(text, result)
	print "Out of the following phrase:\n"
	puts text
	print "Ruby captures:\n"
	puts result
end

# array to hold things
@result = Array.new

# phone numbers
teltest = "Please call me at (888)8888888 or 888-888-8888 or (888)888-8888 or (888) 888-8888 thanks but not 888888888 bye"
@result = teltest.scan(/[(]?[0-9]{3,}\D?[)]?\s?[0-9]{3,}\S?[0-9]{4,}/)
printer(teltest, @result)

# brandeis courses
brantest = "You could sign up for COSI 21A, or maybe ED 2B, but not COSI 20 or C 21A"
@result = brantest.scan(/([A-Z]{2,5}\s\d{1,3}[A-Z])/)
printer(brantest, @result)

# urls
urltest = "So https://mail.google.com is more secure than http://mail.google.com but wee://is.not.website"
@result = urltest.scan(/(http\S+|www\S+)/)
printer(urltest, @result)

# clock times
clocktest = "Meet me at 4 pm or maybe even 7:30a or if seconds matter 12:40:30 a.m. but sometimes I confuse 5p with 5 pence"
@result = clocktest.scan(/(\d{1,2}[:]?\d{0,2}[:]?\s?[a|p|m|.]{1,4})\s/)
printer(clocktest, @result)

# fanfiction pairings
fictest = "I read this great fanfiction with a kirk x spock pairing, though I prefer spock/kirk but kirk and bones shouldn't be a pairing"
@result = fictest.scan(/([a-zA-Z]{2,}\s?[x\/]\s?[a-zA-Z]{2,})/)
printer(fictest, @result)