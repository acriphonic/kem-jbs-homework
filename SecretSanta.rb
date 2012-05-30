#!/usr/bin/env ruby

#require 'net/smtp'
#require 'rubygems'
#require 'tlsmail'

# Assigns Secret Santas using circular array
# Requires there to be a solution, does not account for impossible Santa lists

# Checks if families are next to each other in circular array
def notadjacent?
	$santaarray.each_with_index do |santa, i|
		if (i+1) == $santaarray.size
			# last individual must be compared to first individual in circular array
			return false if santa[/\S+ </] == $santaarray[0][/\S+ </]
		else
			# otherwise, compare to subsequent individual
			return false if santa[/\S+ </] == $santaarray[i+1][/\S+ </]
		end
		return true
	end
end

# E-mail method, censored to protect my password privacy (and so will not function)
# def email(santa, gifted)
# 	Net::SMTP:enable_tls(OpenSSL::SSL::VERIFY_NONE)
# 	Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', belleiseult@gmail.com,
# 	 passwordgoeshere, :login) do |smtp|
# 		message = <<MESSAGE_END
# From: Kendall McCarthy <belleiseult@gmail.com>
# To: #{santa}
# Subject: Secret Santa

# Better start looking for a gift for #{gifted}.

# MESSAGE_END
# 	smtp.send_message message, belleiseult@gmail.com, santa
# end

# reads standard input and splits along lines
$santaarray = STDIN.readlines.collect { |x| x.chomp }
# shuffles circular array until no family members are adjacent
$santaarray = $santaarray.sort_by {rand} until notadjacent?

# send e-mails
$santaarray.each_with_index do |santa, i|
	if (i+1) == $santaarray.size
		# last individual must be paired with first individual in circular array
		# email(santa, $santaarray[0])
		puts "#{santa} is paired with #{$santaarray[0]}"
	else
		# otherwise, is paired with subsequent individual
		# email(santa, $santaarray[i+1])
		puts "#{santa} is paired with #{$santaarray[i+1]}"
	end
end