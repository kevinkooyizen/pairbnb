class StaticController < ApplicationController
	def home
    @listing = Listing.all
	end

  def about
  end
end
