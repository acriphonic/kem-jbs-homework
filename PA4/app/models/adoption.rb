class Adoption < ActiveRecord::Base
  	attr_accessible :descr, :title

  	before_save :default_unapproved

  	private
  		def default_unapproved
  			if self.approved.nil?
  				self.approved = true
  			end
  		end
end
